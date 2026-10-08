<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig UI Templates — agent index

Create/manage Twig templates from the admin UI. Each template is a **`twig_template` config
entity** (`config_prefix: template` → config name `twig_ui.template.<id>`). When enabled, the
`twig_ui.template_manager` service writes the code to `public://twig_ui/<theme>/<suggestion>.html.twig`
(underscores → dashes) and `hook_theme()` registers it, overriding the file-based template with the
same **theme suggestion** for the selected **theme(s)**. No plugin types, no Drush, no hook API file.

- **Create/edit/clone templates, entity fields, the settings form, config schema** →
  [configure/templates.md](configure/templates.md)
- **`TemplateManager` service API (query which override applies, write/delete files, paths)** →
  [api/template-manager.md](api/template-manager.md)
- **The three permissions and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity fields (`config_export`): `status`, `id`, `label`, `theme_suggestion`,
  `template_code`, `themes` (array of theme machine names).
- Global settings config object: `twig_ui.settings` (`allowed_themes` = `all`|`selected`,
  `allowed_theme_list`, `default_selected_themes`, `codemirror_config`).
- Only **one enabled** template is allowed per `theme_suggestion` + `theme` (form validation).
- Admin UIs: templates `/admin/structure/templates`, settings `/admin/config/system/twig_ui`.
  `info.yml` has no `configure` key, so `configure: null` in data.json.
- Saving/disabling/deleting a template flushes caches and rebuilds the kernel.
