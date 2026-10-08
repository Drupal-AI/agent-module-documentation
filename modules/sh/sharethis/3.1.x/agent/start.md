# ShareThis — agent index

Adds social-sharing buttons to nodes (as a content field or per view mode) or via blocks,
using the hosted ShareThis widget. One settings form, config `sharethis.settings`, permission
`administer sharethis`, a manager service, two blocks, a Views field, one alter hook.

- **Settings form + every `sharethis.settings` key (location, node_types, services, widget,
  view modes) and the permission** → [configure/settings.md](configure/settings.md)
- **The two blocks (`sharethis_block`, `sharethis_widget_block`) and the Views field
  (`sharethis_node`)** → [plugins/blocks-and-views.md](plugins/blocks-and-views.md)
- **The `sharethis.manager` service (`getOptions()`, `renderSpans()`)** →
  [api/manager.md](api/manager.md)
- **`hook_sharethis_render_alter()` to rewrite button attributes/options** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config UI route: `sharethis.configuration_form` (`/admin/config/services/sharethis`).
- Permission: `administer sharethis`.
- `location` = `content` (node display field) | `links` (per view mode) | anything else
  (use the blocks). Default is `content`.
- `node_types` selects which content types get buttons; `sharethisnodes.<bundle>.<mode>`
  selects view modes when `location: links`.
- Buttons come from ShareThis's external JS (`sharethis.com`) — an external service.
