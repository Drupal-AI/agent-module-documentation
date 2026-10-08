# mailer_transport — agent start

Transport configuration UI for Mailer Plus. A `mailer_transport` **config entity** (built from
a **TransportUI** plugin) defines how email is sent (SMTP/Sendmail/native/DSN/null); one is
the default. Part of the `symfony_mailer` project (hard dependency of Mailer Plus). Config UI:
**Config → System → Mailer Plus → Transport** (`/admin/config/system/mailer/transport`, route
`entity.mailer_transport.collection`, permission `administer mailer`).

- Create transports & set the default → [configure/transports.md](configure/transports.md)
- TransportUI plugin type & built-ins → [plugins/transport-ui.md](plugins/transport-ui.md)
- Alter transport definitions → [hooks/hooks.md](hooks/hooks.md)
