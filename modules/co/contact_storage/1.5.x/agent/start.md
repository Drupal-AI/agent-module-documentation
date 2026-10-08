# contact_storage — agent start

Makes core Contact's `contact_message` entities storable, fieldable, and editable (core
normally emails and discards them). Adds an admin message list, per-contact-form extras, and
an enable/disable toggle. Depends on core `contact`, `views`, `options`, `filter`, and contrib
`token`. Admin: **Admin → Structure → Contact** (`/admin/structure/contact`); message list at
`/admin/structure/contact/messages` (`configure` route `entity.contact_message.collection`).

- Message list, per-form settings, enable/disable, global `send_html` → [configure/settings.md](configure/settings.md)
- Query/create stored `contact_message` entities in code → [api/api.md](api/api.md)
- Access & the permission that gates messages → [permissions/permissions.md](permissions/permissions.md)
