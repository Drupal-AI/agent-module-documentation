<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Empty Fields — agent index

Renders a placeholder for an **empty** field instead of hiding it. You pick an EmptyField
**handler plugin** on a field's formatter; the choice is stored as a third-party setting on the
field's display component. No configure route, no permissions, no Drush.

- **Set the "Empty value behavior" handler + settings on a field (UI + drush)** →
  [configure/handler.md](configure/handler.md)
- **The `empty_fields` plugin type: write your own EmptyField plugin** →
  [plugins/empty-field.md](plugins/empty-field.md)

Key facts: stored at
`core.entity_view_display.<entity>.<bundle>.<mode>` →
`content.<field>.third_party_settings.empty_fields.handler` (+ `.settings`). Shipped plugins:
`nbsp` (non-breaking space), `text` (custom token-aware text), and a hidden `broken` fallback.
Rendering happens in `hook_entity_display_build_alter()`.
