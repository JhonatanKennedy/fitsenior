export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "13.0.5";
  };
  public: {
    Tables: {
      attendance: {
        Row: {
          created_at: string | null;
          date: string;
          enrollment_id: string;
          id: string;
          present: boolean | null;
        };
        Insert: {
          created_at?: string | null;
          date?: string;
          enrollment_id: string;
          id?: string;
          present?: boolean | null;
        };
        Update: {
          created_at?: string | null;
          date?: string;
          enrollment_id?: string;
          id?: string;
          present?: boolean | null;
        };
        Relationships: [
          {
            foreignKeyName: "attendance_enrollment_id_fkey";
            columns: ["enrollment_id"];
            isOneToOne: false;
            referencedRelation: "enrollments";
            referencedColumns: ["id"];
          }
        ];
      };
      classes: {
        Row: {
          activity: string;
          created_at: string | null;
          demand_id: string | null;
          description: string | null;
          id: string;
          location: string;
          max_students: number;
          price: number | null;
          professional_id: string;
          schedule: string;
        };
        Insert: {
          activity: string;
          created_at?: string | null;
          demand_id?: string | null;
          description?: string | null;
          id?: string;
          location: string;
          max_students: number;
          price?: number | null;
          professional_id: string;
          schedule: string;
        };
        Update: {
          activity?: string;
          created_at?: string | null;
          demand_id?: string | null;
          description?: string | null;
          id?: string;
          location?: string;
          max_students?: number;
          price?: number | null;
          professional_id?: string;
          schedule?: string;
        };
        Relationships: [
          {
            foreignKeyName: "classes_demand_id_fkey";
            columns: ["demand_id"];
            isOneToOne: false;
            referencedRelation: "demands";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "classes_professional_id_fkey";
            columns: ["professional_id"];
            isOneToOne: false;
            referencedRelation: "professionals";
            referencedColumns: ["id"];
          }
        ];
      };
      demands: {
        Row: {
          activity: string;
          created_at: string | null;
          id: string;
          location: string;
          neighborhood: string;
          num_interested: number;
          schedule: string;
        };
        Insert: {
          activity: string;
          created_at?: string | null;
          id?: string;
          location: string;
          neighborhood: string;
          num_interested?: number;
          schedule: string;
        };
        Update: {
          activity?: string;
          created_at?: string | null;
          id?: string;
          location?: string;
          neighborhood?: string;
          num_interested?: number;
          schedule?: string;
        };
        Relationships: [];
      };
      enrollments: {
        Row: {
          class_id: string;
          created_at: string | null;
          id: string;
          status: string | null;
          student_id: string;
        };
        Insert: {
          class_id: string;
          created_at?: string | null;
          id?: string;
          status?: string | null;
          student_id: string;
        };
        Update: {
          class_id?: string;
          created_at?: string | null;
          id?: string;
          status?: string | null;
          student_id?: string;
        };
        Relationships: [
          {
            foreignKeyName: "enrollments_class_id_fkey";
            columns: ["class_id"];
            isOneToOne: false;
            referencedRelation: "classes";
            referencedColumns: ["id"];
          }
        ];
      };
      forum_messages: {
        Row: {
          class_id: string;
          created_at: string | null;
          id: string;
          message: string;
          user_id: string;
        };
        Insert: {
          class_id: string;
          created_at?: string | null;
          id?: string;
          message: string;
          user_id: string;
        };
        Update: {
          class_id?: string;
          created_at?: string | null;
          id?: string;
          message?: string;
          user_id?: string;
        };
        Relationships: [
          {
            foreignKeyName: "forum_messages_class_id_fkey";
            columns: ["class_id"];
            isOneToOne: false;
            referencedRelation: "classes";
            referencedColumns: ["id"];
          }
        ];
      };
      payments: {
        Row: {
          amount: number;
          class_id: string;
          created_at: string | null;
          enrollment_id: string;
          id: string;
          payment_date: string | null;
          status: string | null;
        };
        Insert: {
          amount: number;
          class_id: string;
          created_at?: string | null;
          enrollment_id: string;
          id?: string;
          payment_date?: string | null;
          status?: string | null;
        };
        Update: {
          amount?: number;
          class_id?: string;
          created_at?: string | null;
          enrollment_id?: string;
          id?: string;
          payment_date?: string | null;
          status?: string | null;
        };
        Relationships: [
          {
            foreignKeyName: "payments_class_id_fkey";
            columns: ["class_id"];
            isOneToOne: false;
            referencedRelation: "classes";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "payments_enrollment_id_fkey";
            columns: ["enrollment_id"];
            isOneToOne: false;
            referencedRelation: "enrollments";
            referencedColumns: ["id"];
          }
        ];
      };
      professionals: {
        Row: {
          avatar_url: string | null;
          birth_date: string;
          cpf: string;
          created_at: string | null;
          cref: string;
          full_name: string;
          id: string;
          specialty: string;
          user_id: string;
        };
        Insert: {
          avatar_url?: string | null;
          birth_date: string;
          cpf: string;
          created_at?: string | null;
          cref: string;
          full_name: string;
          id?: string;
          specialty: string;
          user_id: string;
        };
        Update: {
          avatar_url?: string | null;
          birth_date?: string;
          cpf?: string;
          created_at?: string | null;
          cref?: string;
          full_name?: string;
          id?: string;
          specialty?: string;
          user_id?: string;
        };
        Relationships: [];
      };
      profiles: {
        Row: {
          created_at: string | null;
          full_name: string | null;
          id: string;
        };
        Insert: {
          created_at?: string | null;
          full_name?: string | null;
          id: string;
        };
        Update: {
          created_at?: string | null;
          full_name?: string | null;
          id?: string;
        };
        Relationships: [];
      };
      students: {
        Row: {
          address: string;
          avatar_url: string | null;
          birth_date: string;
          cpf: string;
          created_at: string | null;
          email: string;
          full_name: string;
          gender: string;
          health_certificate_url: string | null;
          id: string;
          phone: string;
          user_id: string;
        };
        Insert: {
          address: string;
          avatar_url?: string | null;
          birth_date: string;
          cpf: string;
          created_at?: string | null;
          email: string;
          full_name: string;
          gender: string;
          health_certificate_url?: string | null;
          id?: string;
          phone: string;
          user_id: string;
        };
        Update: {
          address?: string;
          avatar_url?: string | null;
          birth_date?: string;
          cpf?: string;
          created_at?: string | null;
          email?: string;
          full_name?: string;
          gender?: string;
          health_certificate_url?: string | null;
          id?: string;
          phone?: string;
          user_id?: string;
        };
        Relationships: [];
      };
      user_roles: {
        Row: {
          created_at: string | null;
          id: string;
          role: Database["public"]["Enums"]["app_role"];
          user_id: string;
        };
        Insert: {
          created_at?: string | null;
          id?: string;
          role: Database["public"]["Enums"]["app_role"];
          user_id: string;
        };
        Update: {
          created_at?: string | null;
          id?: string;
          role?: Database["public"]["Enums"]["app_role"];
          user_id?: string;
        };
        Relationships: [];
      };
    };
    Views: {
      [_ in never]: never;
    };
    Functions: {
      has_role: {
        Args: {
          _role: Database["public"]["Enums"]["app_role"];
          _user_id: string;
        };
        Returns: boolean;
      };
    };
    Enums: {
      app_role: "professional" | "student" | "admin";
    };
    CompositeTypes: {
      [_ in never]: never;
    };
  };
};

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">;

type DefaultSchema = DatabaseWithoutInternals[Extract<
  keyof Database,
  "public"
>];

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R;
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
      DefaultSchema["Views"])
  ? (DefaultSchema["Tables"] &
      DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
      Row: infer R;
    }
    ? R
    : never
  : never;

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I;
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
  ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
      Insert: infer I;
    }
    ? I
    : never
  : never;

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U;
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
  ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
      Update: infer U;
    }
    ? U
    : never
  : never;

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
  ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
  : never;

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals;
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals;
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
  ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
  : never;

export const Constants = {
  public: {
    Enums: {
      app_role: ["professional", "student", "admin"],
    },
  },
} as const;
