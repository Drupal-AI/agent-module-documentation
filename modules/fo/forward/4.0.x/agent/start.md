<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forward — agent index

"Email this page to a friend" for any entity: a Forward form + field formatters that mail a rendered
view of an entity to recipients, with tokens, flood control, and forward statistics. Global settings at
`/admin/config/user-interface/forward`. Depends on core `field`.

- **Global settings form + config keys, the Forward form route, view modes, filter formats** →
  [configure/settings.md](configure/settings.md)
- **The four permissions and what they gate (incl. the two restricted ones)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Hooks it invites (`forward.api.php`) + Rules/Symfony events** → [hooks/hooks.md](hooks/hooks.md)
- **Services, field formatters/type/widget, tokens, Views, mail plugin** → [api/api.md](api/api.md)

Key facts:
- Form route `forward.form` = `/forward/{entity_type}/{entity}`, `_permission: access forward`
  + `_entity_access: entity.view`. Renders the entity as **anonymous** (account switch) before mailing.
- Config object `forward.settings` (subject/body tokens, flood limit default 10/hr, max recipients
  default 1, filter formats, bypass-access flag).
- Formatters: `forward_link` (link) and `forward_form` (inline form); field type `forward`.
- Tables `forward_log` + `forward_statistics`; Views `forward_logs`, `forward_statistics`.
