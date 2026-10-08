# easy_email_override — agent start

Submodule of **easy_email**. Replaces core/contrib emails with Easy Email templates by
decorating `plugin.manager.mail`: a `MailManager` decorator intercepts each `mail()` and, if an
`easy_email_override` config entity matches the mail's module + key, sends an Easy Email instead.
Overridable emails are declared as plugins via `{module}.emails.yml` (managed by
`DeclaredEmailManager` / `plugin.manager.easy_email_override`). Depends on `easy_email`. Manage at
**Admin → Structure → Email templates → Overrides** (`entity.easy_email_override.collection`, the
`configure` route). Access gated by core `administer site configuration` (no own permissions).
Part of the `easy_email` project.

- Create an override mapping a core/contrib email to a template → [configure/easy_email_override.md](configure/easy_email_override.md)
- Declare your module's email as overridable (emails.yml plugin) → [api/easy_email_override.md](api/easy_email_override.md)
