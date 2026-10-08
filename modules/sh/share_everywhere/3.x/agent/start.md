<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Share Everywhere — agent index

Themeable **social share buttons** (Facebook like/share, X/Twitter, LinkedIn, Messenger, Viber,
WhatsApp, Copy URL). One config object `share_everywhere.settings`; one settings form; one
permission; a service, a Block plugin, a Views field, and theme templates. Depends on
`path_alias` (Commerce & Markdown optional). No plugin types of its own; no Drush.

- **All settings keys, the 4 ways to place buttons (extra field / links / block / views field),
  per-entity mode, config route** → [configure/settings.md](configure/settings.md)
- **Theme hooks & templates, disabling the bundled CSS/JS** → [theming/templates.md](theming/templates.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts: config `share_everywhere.settings`; form route `share_everywhere.config_form`
(`/admin/config/services/share_everywhere`, perm "administer share everywhere"); buttons render
as the extra field `share_everywhere` on node/commerce_product displays, via block
`share_everywhere_block`, or Views field `share_everywhere_field`; service `share_everywhere.service`.
