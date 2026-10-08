# workbench — agent start

A personalized **My Workbench** dashboard for editors at `/admin/workbench`: a toolbar tab
plus sub-tabs (My edits, All recent content, Create content) whose regions are all rendered
from Views. Depends on core `image`, `node`, `toolbar`, `user`, `views`. Region→View mapping
is configured at **Admin → Config → Workflow → Workbench** (`/admin/config/workflow/workbench`,
route `workbench.admin`) and stored in `workbench.settings`.

- The dashboard, its tabs, the shipped Views, and mapping Views to regions → [configure/dashboard.md](configure/dashboard.md)
- Alter regions / add a custom tab-content or block via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions (`access workbench`, `administer workbench`) → [permissions/permissions.md](permissions/permissions.md)
