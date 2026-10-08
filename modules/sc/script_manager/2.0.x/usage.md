Script Manager lets a trusted administrator register arbitrary HTML/JavaScript snippets (e.g. analytics, tag-manager, or tracking code) as `script` config entities and have them injected into the top or bottom of the page, optionally limited by visibility conditions.

---

The module defines a `script` config entity managed at `/admin/structure/scripts` (menu label *JavaScript Snippets*) behind the `administer scripts` permission (`restrict access: true`). Each script has a label, a machine id, a free-text `snippet`, a `position` (`top`, `bottom`, or `hidden`), and a set of core condition-plugin *visibility* rules (request path, roles, language, etc.), configured with the same UI/mechanics as core block visibility. On every non-admin page, `hook_page_top()` / `hook_page_bottom()` call `ScriptPlacementManager::getRenderedScriptsForPosition()`, which loads scripts for that position, evaluates each script's visibility conditions via a dedicated access control handler (the `view` operation), and emits the raw snippet as `#markup` through `FormattableMarkup($snippet, [])` — i.e. **the snippet is output verbatim, unescaped, by design** so real `<script>`/analytics tags run. Output is skipped entirely on admin routes. Rendering carries the `config:script_list` cache tag plus each script's own cache metadata, and a `hook_script_manager_scripts_alter` alter hook lets other modules mutate the render array. A `script_entity` field formatter additionally renders a referenced script entity's snippet wherever an `entity_reference` field targets the `script` entity type. Because the snippet is emitted raw, the `administer scripts` permission is effectively equivalent to site-wide script injection and should only be granted to fully trusted roles.

---

- Add a Google Analytics / GA4 / gtag tracking snippet to the bottom of every page.
- Inject a Google Tag Manager container `<script>` into the page head (top position).
- Add a Meta/Facebook Pixel or other marketing pixel to all front-end pages.
- Load a third-party chat/support widget script site-wide.
- Insert a cookie-consent or consent-management platform bootstrap script.
- Add a hotjar/heatmap/session-recording snippet.
- Place a snippet only in the page top (head) vs page bottom (before `</body>`).
- Temporarily disable a snippet without deleting it by setting its position to *Not shown* (`hidden`).
- Restrict a script to specific request paths using the Request Path visibility condition.
- Restrict a script to specific user roles using the User Role visibility condition.
- Restrict a script to specific languages using the Language visibility condition.
- Negate a visibility condition (e.g. run everywhere *except* the admin section paths).
- Keep tracking scripts out of the admin UI automatically (admin routes are skipped).
- Manage several independent snippets side by side from one admin listing.
- Reference a specific script entity from a content entity via an entity-reference field and render it with the *Script Formatter*.
- Let another module post-process or conditionally drop rendered scripts via `hook_script_manager_scripts_alter`.
- Add A/B-testing or experiment framework loader scripts.
- Add verification/meta snippets for search consoles or ad networks.
- Centralise all custom `<script>` inclusions in config instead of editing theme templates.
- Deploy snippets as configuration (export/import via config sync) across environments.
- Restrict which visibility condition plugins are offered by setting `enabled_visibility_plugins` in `script_manager.settings`.
