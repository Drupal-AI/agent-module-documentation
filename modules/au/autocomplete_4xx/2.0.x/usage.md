<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autocomplete 4xx turns core's 403/404 site-information path fields into autocomplete widgets backed by a node- and route-search endpoint.

---

Autocomplete 4xx is a small site-building utility. It implements `hook_form_system_site_information_settings_alter()` to attach an autocomplete route to the *Default 403 (access denied) page* and *Default 404 (not found) page* fields on `/admin/config/system/site-information`, so instead of typing an internal path by hand a site builder can type a few characters and pick a match. The suggestions come from a JSON controller that searches published node titles (returning `/node/{nid}` values) and, when enabled, system route paths. A single admin settings form at `/admin/config/system/autocomplete_4xx` (config object `autocomplete_4xx.settings`) toggles whether routes, parameterized routes and unpublished nodes are included and restricts the node search to chosen content types. It ships no fields, entities, plugins, permissions or Drush commands, requires nothing outside Drupal core, and supports Drupal 10 and 11.

---

- Make the 404 "page not found" path field on Site information an autocomplete instead of a bare text field.
- Make the 403 "access denied" path field on Site information an autocomplete.
- Let a site builder pick an existing node for the error page by typing its title rather than its `/node/NID` path.
- Suggest node paths as `/node/{nid}` with the node title (and id) shown as the label.
- Search node titles with a case-insensitive CONTAINS match, newest-created first.
- Restrict which content types are searched for suggestions (bundle filter).
- Optionally include system route paths (like `/admin`, `/user`) among the suggestions.
- Optionally include parameterized routes (paths containing `{...}` placeholders) in the suggestions.
- Optionally include unpublished nodes in the suggestions.
- Configure all of the above from one form at `/admin/config/system/autocomplete_4xx`.
- Give editors a faster way to wire a friendly node to the 404 response.
- Point 403 responses at a custom "access denied" node chosen from a list.
- Avoid memorizing internal node ids when setting error pages.
- Keep error-page configuration entirely within core's Site information form.
- Deploy the resulting `system.site` 403/404 values through normal config export.
- Use on Drupal 10 or 11 with no extra module dependencies.
- Provide autocomplete only where it is needed (the two error-page fields), not site-wide.
- Narrow noisy suggestion lists on large sites by limiting content types.
- Let admins expose route-based error targets (e.g. a controller path) when nodes are not enough.
- Serve suggestions as JSON at `/admin/autocomplete_4xx/source?q=...` for the autocomplete widget.
- Manage the feature's behavior from the Configuration > System menu group.
