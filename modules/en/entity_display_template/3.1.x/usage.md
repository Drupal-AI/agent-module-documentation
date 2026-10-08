<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Display Template adds a Twig code editor to each entity view display's "Manage Display" page so an admin can replace the default field rendering of a view mode with a custom inline template.
---
The module implements `hook_form_entity_view_display_edit_form_alter()` to add a CodeMirror "Display Template options" section (an `enabled` checkbox and a `twig` textarea) to every Manage Display form; the values are stored as third-party settings (`entity_display_template.enabled` / `.twig`) on the EntityViewDisplay config entity. At render time `hook_entity_display_build_alter()` checks the `enabled` flag and, if set, replaces the build with a single `#type => inline_template` element whose `#template` is the stored Twig and whose `#context` is a set of helper variables (link, entity_id, active_theme, base_path, current_language, user_is_admin, user_is_logged_in) merged with the rendered field build arrays, so field machine names can be printed as `{{ field_name }}`.

**Security (SSTI, by design):** the stored Twig is rendered through Drupal's `inline_template` in `entity_display_template.module` (`entity_display_template_entity_display_build_alter()` — the `#type => 'inline_template'` / `#template => $twig` element). Whoever can edit an entity view display can therefore inject arbitrary Twig that executes for every visitor viewing that view mode. Twig's sandbox is not applied to `inline_template`, so this is effectively arbitrary server-side template execution (SSTI). It is **not anonymous** — writing the template requires the core display-admin permissions (e.g. `administer <entity_type> display` / access to the Manage Display form), which are already site-builder / trusted-admin level. There is no user-facing form field, callback, or route that feeds untrusted input into the template; the input surface is the admin config form only. Treat the display-admin permission as trusted (equivalent to PHP access) on sites using this module.
---
- Override a content type's default rendering with custom Twig per view mode.
- Print specific fields in a chosen order via `{{ field_name }}` in the template.
- Build a bespoke teaser layout without adding a theme template file.
- Rapidly template many block types / view modes from the admin UI.
- Enable the custom template per view mode with a single checkbox.
- Edit templates in a CodeMirror editor on the Manage Display page.
- Access contextual variables like link, entity_id, and active_theme in Twig.
- Branch template output on user_is_admin or user_is_logged_in.
- Localize output using the current_language context variable.
- Keep the created/uid render pieces available alongside the custom output.
- Prototype display markup quickly for non-programmers.
- Disable the custom template to fall back to default field rendering.
- Reference base_path and active_theme_directory for asset URLs.
- Apply different templates to full vs teaser vs custom view modes.
- Store the template in config so it deploys with the display entity.
- Restrict template editing to trusted admins (treat as PHP-equivalent access).
- Combine field output with static markup in one inline template.
- Use the front-page context flag to vary rendering on the home page.