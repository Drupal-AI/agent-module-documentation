Advanced Datalayer builds the JavaScript `window.dataLayer` object (as used by Google Tag Manager) from configurable, plugin-defined "tags", with per-page-type defaults and token-driven values, and pushes it into the page head on every supported route.

---

The module defines two plugin types — **datalayer tags** (`@AdvancedDatalayerTag`, discovered in `Plugin/AdvancedDatalayer/Tag`, manager `plugin.manager.advanced_datalayer.tag`) and **datalayer groups** (`@AdvancedDatalayerGroup`, manager `plugin.manager.advanced_datalayer.group`) that organize tags into a nested structure. Each tag plugin declares a machine `id`, `label`, `group`, and flags like `global`, `required`, `show_empty`, `translatable`, and `weight`; a tag's value is usually a string containing **tokens** which the `advanced_datalayer.manager`/`advanced_datalayer.token` services resolve (via `token` + `token.entity_mapper`) against the current route entity. Site builders assign values to tags through **`advanced_datalayer_defaults`** config entities — one per page context (`global`, `front`, `node`, `taxonomy_term`, `403`, `404`, `login`, `register`, `pass`), each holding a `tags` map — managed at `/admin/config/search/advanced-datalayer/page-variables` (list, add, edit, delete forms) plus a settings form, all gated by the `administer advanced datalayer defaults settings` permission. At request time `hook_page_attachments()` checks the route is supported, collects the applicable tags (global + page-type + entity-field-provided), fires `hook_advanced_datalayer_alter()` and `hook_advanced_datalayer_attachments_alter()`, then injects `var dataLayer_tags = {…}` and `window.dataLayer.push(dataLayer_tags)` as head scripts. A field type/widget/formatter (`advanced_datalayer`) lets individual entities carry their own datalayer tag values. The `example_advanced_datalayer` submodule ships ready-made tag/group plugins; `context_advanced_datalayer` exposes datalayer configuration as a Context reaction. The module itself defines no tags — you get them from the example submodule or your own plugins.

---

- Populate Google Tag Manager's `dataLayer` with structured page variables without custom code on every template.
- Push a `pageCategory` / `pageName` variable computed from the current node's fields via tokens.
- Set a global site-wide datalayer variable (e.g. `siteName`, environment) on every page.
- Emit different datalayer values on the front page vs. node pages vs. 404/403 pages.
- Add analytics variables to login, registration, and password-reset pages specifically.
- Define a custom datalayer tag plugin (`@AdvancedDatalayerTag`) for a bespoke variable.
- Group related datalayer variables under a nested object using a group plugin (`@AdvancedDatalayerGroup`).
- Drive tag values from entity tokens (e.g. `[node:title]`, `[node:field_category]`).
- Let editors set per-node datalayer values with the `advanced_datalayer` field type/widget.
- Mark a tag as `required` so it is always present in the dataLayer.
- Include tags with empty values when needed (`show_empty`) or omit them by default.
- Control tag output order with the plugin `weight`.
- Make a datalayer value translatable so each language pushes localized content.
- Configure page-variable defaults through the admin UI at /admin/config/search/advanced-datalayer/page-variables.
- Restrict who can edit datalayer defaults with the 'administer advanced datalayer defaults settings' permission.
- Alter the final datalayer array before it is attached via `hook_advanced_datalayer_alter()`.
- Post-process rendered datalayer tags before injection via `hook_advanced_datalayer_attachments_alter()`.
- Use the example submodule's tags (event, siteName, pageName, pageCategory, responseCode, gaClientID) as a starting point.
- Configure datalayer output per Context (route/path/role) using the context_advanced_datalayer submodule.
- Emit a `responseCode` datalayer variable so analytics can see 404/403 hits.
- Provide a `gaClientID` datalayer value populated client-side.
- Standardize GTM data collection across a multisite by shipping tag plugins in a custom module.
- Keep marketing/analytics variables in configuration (exportable) rather than hard-coded in the theme.
- Feed structured e-commerce or content metadata into GTM triggers and tags.
