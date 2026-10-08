# easy_email — agent start

HTML email system. Two entities: `easy_email_type` (config template — subject/body/cc/bcc/
attachments/tokens/logging) and `easy_email` (revisionable content entity = one email, a bundle
of its template). The `easy_email.handler` service creates/previews/sends. Needs an HTML mailer
(Symfony Mailer / Symfony Mailer Lite). Depends on core `text`, `token`, `jquery_ui_resizable`.
Templates: **Admin → Structure → Email templates** (`entity.easy_email_type.collection`, the
`configure` route). Email log: **Admin → Reports → Email log**.

- Create/manage templates, settings, routes, config keys → [configure/easy_email.md](configure/easy_email.md)
- Generate, preview & send an email in code (handler + entity API + events) → [api/easy_email.md](api/easy_email.md)
- Permissions (templates, email entities, settings, revisions) → [permissions/easy_email.md](permissions/easy_email.md)
- Submodules: `easy_email_commerce` (Commerce order emails), `easy_email_override` (override core/contrib emails) — see their nested docs.
