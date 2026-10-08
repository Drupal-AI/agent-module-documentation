# moderation_sidebar — agent start

Adds a "Tasks" toolbar tab that opens an off-canvas sidebar with quick Content Moderation
actions (publish, create draft, discard draft, view latest/live, edit, translate) for the
entity you are viewing. Depends on core `content_moderation`. The tab loads
`ModerationSidebarController::sideBar()` via AJAX; quick transitions come from
`QuickTransitionForm`. Settings UI: **Admin → Config → User interface → Moderation Sidebar**
(`/admin/config/user-interface/moderation-sidebar`, route `moderation_sidebar.settings`).

- The toolbar tab, sidebar buttons & disabling transitions → [configure/moderation_sidebar.md](configure/moderation_sidebar.md)
- Permissions (`use moderation sidebar`, `administer moderation sidebar`) → [permissions/moderation_sidebar.md](permissions/moderation_sidebar.md)
- Alter the sidebar build via hook → [hooks/moderation_sidebar.md](hooks/moderation_sidebar.md)
