# mailsystem — agent start

Picks which mail **formatter** and **sender** plugin core uses, site-wide / per-module / per
mail-key, plus the mail render theme. Extends core `MailManager` as `MailsystemManager`.
Config UI: **Admin → Config → System → Mail System** (`/admin/config/system/mailsystem`,
route `mailsystem.settings`). Requires core `filter`.

- Configure default/per-module/per-key backends + mail theme → [configure/settings.md](configure/settings.md)
- Resolve/override backends programmatically (the manager & config keys) → [api/manager.md](api/manager.md)
- Permission that gates the UI → [permissions/permissions.md](permissions/permissions.md)
