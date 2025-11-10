import { Button } from "@/components/ui/button";
import { Heart, Menu, X } from "lucide-react";
import { Link, useLocation } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { useEffect, useMemo, useState } from "react";

const Header = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isAuth, setIsAuth] = useState(false);
  const [role, setRole] = useState(null);
  const location = useLocation();

  const fetchUserRole = async (userId: string) => {
    const { data } = await supabase
      .from("user_roles")
      .select("role")
      .eq("user_id", userId)
      .single();

    return data?.role ?? null;
  };

  useEffect(() => {
    // Verifica sessão inicial
    supabase.auth.getSession().then(async ({ data: { session } }) => {
      if (session?.user) {
        const role = await fetchUserRole(session.user.id);
        setRole(role);
        setIsAuth(true);
      }
    });

    // Escuta mudanças de autenticação
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange(async (_event, session) => {
      if (session?.user) {
        const role = await fetchUserRole(session.user.id);
        setRole(role);
        setIsAuth(true);
      } else {
        setRole(null);
        setIsAuth(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const navItemsUnauth = [
    { path: "/", label: "Início" },
    {
      path: "/auth",
      label: "Login",
    },
  ];

  const navItemsStudents = [{ path: "/buscar-aulas", label: "Buscar Aulas" }];
  const navItemsProfessionals = [
    { path: "/cadastrar-aulas", label: "Para Profissionais" },
    {
      path: "/dashboard",
      label: "Dashboard",
    },
  ];

  const navRole = role === "student" ? navItemsStudents : navItemsProfessionals;

  const navItems = isAuth ? navRole : navItemsUnauth;

  const isActive = (path: string) => location.pathname === path;

  const homePath = useMemo(() => {
    if (!isAuth) return "/";
    if (role === "professional") return "/dashboard";
    if (role === "student") return "/minhas-turmas";
    return "/";
  }, [isAuth, role]);

  return (
    <header className="sticky top-0 z-50 bg-background/95 backdrop-blur-sm border-b shadow-soft">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          <Link to={homePath} className="flex items-center gap-2 group">
            <div className="w-10 h-10 rounded-xl bg-gradient-primary flex items-center justify-center group-hover:scale-110 transition-transform">
              <Heart className="w-6 h-6 text-primary-foreground" />
            </div>
            <span className="text-2xl font-bold">
              Fit<span className="text-primary">Sênior</span>
            </span>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center gap-1">
            {navItems.map((item) => (
              <Link key={item.path} to={item.path}>
                <Button
                  variant={isActive(item.path) ? "default" : "ghost"}
                  className="text-base"
                >
                  {item.label}
                </Button>
              </Link>
            ))}
          </nav>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden p-2"
            onClick={() => setIsMenuOpen(!isMenuOpen)}
            aria-label="Toggle menu"
          >
            {isMenuOpen ? (
              <X className="w-6 h-6" />
            ) : (
              <Menu className="w-6 h-6" />
            )}
          </button>
        </div>

        {/* Mobile Navigation */}
        {isMenuOpen && (
          <nav className="md:hidden py-4 space-y-2 border-t">
            {navItems.map((item) => (
              <Link
                key={item.path}
                to={item.path}
                onClick={() => setIsMenuOpen(false)}
              >
                <Button
                  variant={isActive(item.path) ? "default" : "ghost"}
                  className="w-full justify-start text-base"
                >
                  {item.label}
                </Button>
              </Link>
            ))}
          </nav>
        )}
      </div>
    </header>
  );
};

export default Header;
