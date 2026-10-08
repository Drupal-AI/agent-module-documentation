# Advanced Datalayer — agent index

Builds the GTM `window.dataLayer` from plugin-defined **tags** with per-page-type **defaults**
and token-resolved values, injected into the page head on every supported route. Depends on
`field` + `token`. Permission: `administer advanced datalayer defaults settings`. Defines two
plugin types. Ships no tags itself (see the example submodule).

- **Assign values to datalayer tags per page context (`advanced_datalayer_defaults` config,
  admin routes, settings form)** → [configure/defaults.md](configure/defaults.md)
- **Define your own tag / group plugins (`@AdvancedDatalayerTag`, `@AdvancedDatalayerGroup`)** →
  [plugins/tags-and-groups.md](plugins/tags-and-groups.md)
- **Services & how the dataLayer is generated and injected (manager, token, page_attachments)** →
  [api/manager.md](api/manager.md)
- **Alter hooks (`hook_advanced_datalayer_alter`, `..._attachments_alter`)** →
  [hooks/alter.md](hooks/alter.md)

Key facts:
- Plugin types: **tags** in `Plugin/AdvancedDatalayer/Tag` (annotation `@AdvancedDatalayerTag`,
  manager `plugin.manager.advanced_datalayer.tag`, alter `advanced_datalayer_tags`); **groups**
  in `Plugin/AdvancedDatalayer/Group` (`@AdvancedDatalayerGroup`,
  `plugin.manager.advanced_datalayer.group`).
- Config entity `advanced_datalayer_defaults` — one per context: `global`, `front`, `node`,
  `taxonomy_term`, `403`, `404`, `login`, `register`, `pass` — each with a `tags` map
  (`tag_id => value`).
- Admin at `/admin/config/search/advanced-datalayer/page-variables` (routes
  `entity.advanced_datalayer_defaults.*` + `advanced_datalayer.settings`).
- Output: `hook_page_attachments()` injects `var dataLayer_tags = {…}` then
  `window.dataLayer.push(dataLayer_tags)` as head scripts.
- Submodules: `example_advanced_datalayer` (sample tags/groups),
  `context_advanced_datalayer` (datalayer as a Context reaction).
