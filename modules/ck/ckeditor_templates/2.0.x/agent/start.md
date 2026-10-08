<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Templates — agent index

A **Templates** button for CKEditor 5 that opens a dialog of predefined HTML snippets.
Templates are `ckeditor_templates` **config entities**; the module also defines its own
`@CkeditorTemplate` plugin type so templates can come from code.

- **Create/read templates, wire the toolbar button, `replace_content`, routes** →
  [configure/templates.md](configure/templates.md)
- **The `@CkeditorTemplate` plugin type, the config deriver, writing one in code** →
  [plugins/ckeditor-template.md](plugins/ckeditor-template.md)
- **The two permissions and what they gate** →
  [permissions/ckeditor-templates.md](permissions/ckeditor-templates.md)

Key facts:

- Config entity type id `ckeditor_templates`, config prefix
  `ckeditor_templates.ckeditor_templates.<id>`; admin UI at
  `/admin/config/content/ckeditor-templates` (no `configure` key in info.yml).
- CKEditor 5 plugin id `ckeditor_templates_plugin`, toolbar item **`ckeditorTemplates`**,
  one setting: `settings.plugins.ckeditor_templates_plugin.replace_content` (bool).
- A template is only offered on a format listed in its `formats` key **and** only if
  `status: true` (the deriver filters on `status = 1`).
- Plugin manager service `plugin.manager.ckeditor_template`; alter hook
  `hook_ckeditor_template_info_alter()`.
