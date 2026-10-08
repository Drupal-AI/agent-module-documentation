# mimemail — agent start

Mail backend that sends MIME-encoded HTML email with embedded images/attachments and
inlined CSS. Used via the **Mail System** module (select the `mime_mail` plugin). Config UI:
**Admin → Config → System → Mime Mail** (`/admin/config/system/mimemail`, route
`mimemail.settings`). Submodule: `mimemail_example` (demo, not documented separately).

- Settings (sender, textonly, image embedding, per-user opt-out) → [configure/settings.md](configure/settings.md)
- Make it the active mailer (Mail System) → [configure/activate.md](configure/activate.md)
- Theme emails (templates, suggestions) → [theming/templates.md](theming/templates.md)
- Format helper API (`MimeMailFormatHelper`) → [api/format-helper.md](api/format-helper.md)
- The `mime_mail` Mail plugin → [plugins/mail-plugin.md](plugins/mail-plugin.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
