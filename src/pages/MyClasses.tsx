import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Switch } from "@/components/ui/switch";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { MapPin, Clock, Users, Bell, BellOff } from "lucide-react";

const MyClasses = () => {
  const navigate = useNavigate();
  const { toast } = useToast();
  const [loading, setLoading] = useState(true);
  const [enrolledClasses, setEnrolledClasses] = useState<any[]>([]);
  const [notifications, setNotifications] = useState<{
    [key: string]: boolean;
  }>({});

  useEffect(() => {
    fetchEnrolledClasses();
  }, []);

  const fetchEnrolledClasses = async () => {
    try {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) throw new Error("Usuário não autenticado");

      const { data: enrollments, error: enrollError } = await supabase
        .from("enrollments")
        .select(
          `
          id,
          class_id,
          classes (
            id,
            activity,
            schedule,
            location,
            max_students,
            description
          )
        `
        )
        .eq("student_id", user.id)
        .eq("status", "active");

      if (enrollError) throw enrollError;

      const classesData =
        enrollments?.map((e: any) => ({
          enrollmentId: e.id,
          ...e.classes,
        })) || [];

      setEnrolledClasses(classesData);

      // Initialize notifications state
      const notifState: { [key: string]: boolean } = {};
      classesData.forEach((cls: any) => {
        // For now, all notifications are enabled by default
        notifState[cls.id] = true;
      });
      setNotifications(notifState);
    } catch (error: any) {
      toast({
        title: "Erro ao carregar turmas",
        description: error.message,
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const toggleNotifications = (classId: string) => {
    setNotifications((prev) => {
      const newState = { ...prev, [classId]: !prev[classId] };

      toast({
        title: newState[classId]
          ? "Notificações ativadas"
          : "Notificações desativadas",
        description: newState[classId]
          ? "Você receberá avisos desta turma"
          : "Você não receberá mais avisos desta turma",
      });

      return newState;
    });
  };

  if (loading) {
    return <div className="container py-12">Carregando...</div>;
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-primary/5 to-background py-12 px-4">
      <div className="container max-w-6xl mx-auto">
        <div className="mb-8">
          <h1 className="text-4xl font-bold mb-2">Minhas Turmas</h1>
          <p className="text-muted-foreground">
            Turmas em que você está matriculado
          </p>
        </div>

        {enrolledClasses.length === 0 ? (
          <Card>
            <CardContent className="py-12 text-center">
              <p className="text-muted-foreground mb-4">
                Você ainda não está matriculado em nenhuma turma
              </p>
              <button
                onClick={() => navigate("/buscar-aulas")}
                className="text-primary hover:underline"
              >
                Encontrar turmas disponíveis
              </button>
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {enrolledClasses.map((classItem) => (
              <Card
                key={classItem.id}
                className="cursor-pointer hover:shadow-lg transition-all duration-200"
                onClick={() => navigate(`/turma-aluno/${classItem.id}`)}
              >
                <CardHeader>
                  <CardTitle className="flex items-start justify-between">
                    <span className="hover:text-primary transition-colors">
                      {classItem.activity}
                    </span>
                    <div className="flex items-center gap-2 ml-2">
                      {notifications[classItem.id] ? (
                        <Bell className="h-5 w-5 text-primary" />
                      ) : (
                        <BellOff className="h-5 w-5 text-muted-foreground" />
                      )}
                    </div>
                  </CardTitle>
                  <CardDescription className="line-clamp-2">
                    {classItem.description || "Sem descrição"}
                  </CardDescription>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex items-center gap-2 text-sm">
                    <Clock className="h-4 w-4 text-muted-foreground" />
                    <span>{classItem.schedule}</span>
                  </div>
                  <div className="flex items-center gap-2 text-sm">
                    <MapPin className="h-4 w-4 text-muted-foreground" />
                    <span>{classItem.location}</span>
                  </div>

                  <div className="pt-4 border-t">
                    <div className="flex items-center justify-between">
                      <Label
                        htmlFor={`notif-${classItem.id}`}
                        className="text-sm cursor-pointer"
                      >
                        Notificações
                      </Label>
                      <Switch
                        id={`notif-${classItem.id}`}
                        checked={notifications[classItem.id]}
                        onCheckedChange={() =>
                          toggleNotifications(classItem.id)
                        }
                      />
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default MyClasses;
