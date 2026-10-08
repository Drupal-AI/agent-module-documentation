<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Claro Extras — agent start

Admin-theme UX module for Claro. Settings form at `/admin/appearance/settings/claro_extras`
(route `claro_extras.claro_extras_settings_form`, `_permission: access administration pages`).

- Config `claro_extras.settings`: `node_form_meta` (+`node_form_meta_types`), `node_breadcrumbs`, `enhance_paragraph_titles`.
- `hook_form_node_form_alter` applies changes only when `system.theme` admin == `claro`; attaches the matching libraries.
- No Drush/permissions of its own beyond the route permission. Only a cosmetic/admin effect; standard ConfigFormBase (CSRF-safe).
- Key files: `claro_extras.module`, `src/Form/ClaroExtrasSettingsForm.php`, `claro_extras.routing.yml`.
- See ../usage.md.
