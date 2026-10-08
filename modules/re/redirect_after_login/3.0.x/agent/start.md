# redirect_after_login — agent start

Redirects a user to a configured internal URL after login, chosen **per role**. Core-only
(no contrib deps). On `hook_user_login` it rewrites the request `destination` query param
from a per-role map in the `redirect_after_login.settings` config object. Config UI:
**Admin → Config → People → Redirect After Login** (`/admin/config/people/redirect`);
settings route `redirect_after_login.admin_settings`. Simpler, per-role-only alternative to
Login Destination.

- Set post-login destination per role, priority, exclude list, the settings → [configure/redirect_after_login.md](configure/redirect_after_login.md)
- Permission that gates the settings form → [permissions/redirect_after_login.md](permissions/redirect_after_login.md)
