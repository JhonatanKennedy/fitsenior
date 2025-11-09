import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Checkbox } from "@/components/ui/checkbox";
import { Textarea } from "@/components/ui/textarea";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { ArrowLeft, MessageSquare, ClipboardList, Send } from "lucide-react";
import { format } from "date-fns";
import { ptBR } from "date-fns/locale";

interface Student {
  id: string;
  enrollment_id: string;
  email: string;
  absences: number;
}

interface Message {
  id: string;
  message: string;
  created_at: string;
  user_id: string;
  profiles: { full_name: string } | null;
}

const ClassManagement = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const { toast } = useToast();
  const [classData, setClassData] = useState<any>(null);
  const [students, setStudents] = useState<Student[]>([]);
  const [messages, setMessages] = useState<Message[]>([]);
  const [newMessage, setNewMessage] = useState("");
  const [attendance, setAttendance] = useState<Record<string, boolean>>({});
  const [notes, setNotes] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadClassData();
    loadStudents();
    loadMessages();
  }, [id]);

  const loadClassData = async () => {
    const { data } = await supabase
      .from("classes")
      .select("*")
      .eq("id", id)
      .single();

    setClassData(data);
    setLoading(false);
  };

  const loadStudents = async () => {
    const { data: enrollments } = await supabase
      .from("enrollments")
      .select(
        `
        id,
        student_id,
        profiles:student_id (
          id,
          full_name
        )
      `
      )
      .eq("class_id", id)
      .eq("status", "active");

    if (enrollments) {
      const studentsWithAbsences = await Promise.all(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        enrollments.map(async (enrollment: any) => {
          const { count } = await supabase
            .from("attendance")
            .select("*", { count: "exact", head: true })
            .eq("enrollment_id", enrollment.id)
            .eq("present", false);

          return {
            id: enrollment.student_id,
            enrollment_id: enrollment.id,
            email: enrollment.profiles?.full_name || "Sem nome",
            absences: count || 0,
          };
        })
      );

      setStudents(studentsWithAbsences);
    }
  };

  const loadMessages = async () => {
    const { data } = await supabase
      .from("forum_messages")
      .select("*")
      .eq("class_id", id)
      .order("created_at", { ascending: false });

    if (data) {
      const messagesWithProfiles = await Promise.all(
        data.map(async (msg) => {
          const { data: profile } = await supabase
            .from("profiles")
            .select("full_name")
            .eq("id", msg.user_id)
            .maybeSingle();

          return {
            ...msg,
            profiles: profile || null,
          };
        })
      );

      setMessages(messagesWithProfiles as Message[]);
    }
  };

  const handleAttendanceSubmit = async () => {
    const today = new Date().toISOString().split("T")[0];

    const attendanceRecords = students.map((student) => ({
      enrollment_id: student.enrollment_id,
      date: today,
      present: attendance[student.id] || false,
    }));

    const { error } = await supabase
      .from("attendance")
      .upsert(attendanceRecords, {
        onConflict: "enrollment_id,date",
      });

    if (error) {
      toast({
        title: "Erro ao salvar presença",
        description: error.message,
        variant: "destructive",
      });
    } else {
      toast({
        title: "Presença salva!",
        description: "Lista de chamada atualizada com sucesso.",
      });
      loadStudents();
      setAttendance({});
    }
  };

  const handleSendMessage = async () => {
    if (!newMessage.trim()) return;

    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) return;

    const { error } = await supabase.from("forum_messages").insert({
      class_id: id,
      user_id: user.id,
      message: newMessage,
    });

    if (error) {
      toast({
        title: "Erro ao enviar mensagem",
        description: error.message,
        variant: "destructive",
      });
    } else {
      setNewMessage("");
      loadMessages();
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <p className="text-xl">Carregando...</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-hero">
      <div className="container mx-auto px-4 py-8">
        <Button
          variant="ghost"
          onClick={() => navigate("/dashboard")}
          className="mb-6"
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          Voltar ao Dashboard
        </Button>

        <div className="mb-8">
          <h1 className="text-4xl font-bold">{classData?.activity}</h1>
          <p className="text-xl text-muted-foreground mt-2">
            {classData?.schedule} • {classData?.location}
          </p>
        </div>

        <Tabs defaultValue="attendance" className="space-y-6">
          <TabsList>
            <TabsTrigger value="attendance">
              <ClipboardList className="w-4 h-4 mr-2" />
              Lista de Chamada
            </TabsTrigger>
            <TabsTrigger value="forum">
              <MessageSquare className="w-4 h-4 mr-2" />
              Fórum
            </TabsTrigger>
          </TabsList>

          <TabsContent value="attendance" className="space-y-6">
            <Card className="shadow-soft">
              <CardHeader>
                <CardTitle>Presença de Hoje</CardTitle>
                <CardDescription>
                  Marque os alunos presentes na aula
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Aluno</TableHead>
                      <TableHead>Faltas</TableHead>
                      <TableHead>Presente</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {students.map((student) => (
                      <TableRow key={student.id}>
                        <TableCell>{student.email}</TableCell>
                        <TableCell>{student.absences}</TableCell>
                        <TableCell>
                          <Checkbox
                            checked={attendance[student.id] || false}
                            onCheckedChange={(checked) =>
                              setAttendance((prev) => ({
                                ...prev,
                                [student.id]: checked as boolean,
                              }))
                            }
                          />
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
                <Button onClick={handleAttendanceSubmit} className="w-full">
                  Salvar Presença
                </Button>
              </CardContent>
            </Card>

            <Card className="shadow-soft">
              <CardHeader>
                <CardTitle>Observações da Turma</CardTitle>
              </CardHeader>
              <CardContent>
                <Textarea
                  placeholder="Adicione observações sobre a turma..."
                  value={notes}
                  onChange={(e) => setNotes(e.target.value)}
                  rows={4}
                />
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="forum" className="space-y-6">
            <Card className="shadow-soft">
              <CardHeader>
                <CardTitle>Enviar Mensagem</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <Textarea
                  placeholder="Digite sua mensagem..."
                  value={newMessage}
                  onChange={(e) => setNewMessage(e.target.value)}
                  rows={3}
                />
                <Button onClick={handleSendMessage} className="w-full">
                  <Send className="w-4 h-4 mr-2" />
                  Enviar
                </Button>
              </CardContent>
            </Card>

            <div className="space-y-4">
              {messages.map((msg) => (
                <Card key={msg.id} className="shadow-soft">
                  <CardHeader className="pb-3">
                    <div className="flex justify-between items-start">
                      <CardTitle className="text-base">
                        {msg.profiles?.full_name || "Usuário"}
                      </CardTitle>
                      <span className="text-sm text-muted-foreground">
                        {format(
                          new Date(msg.created_at),
                          "dd/MM/yyyy 'às' HH:mm",
                          {
                            locale: ptBR,
                          }
                        )}
                      </span>
                    </div>
                  </CardHeader>
                  <CardContent>
                    <p className="text-sm">{msg.message}</p>
                  </CardContent>
                </Card>
              ))}
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
};

export default ClassManagement;
