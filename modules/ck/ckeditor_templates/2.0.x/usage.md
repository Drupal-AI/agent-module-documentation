<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Templates adds a **Templates** toolbar button to CKEditor 5 that opens a dialog of predefined HTML snippets — each with a label, description and thumbnail — which the editor can insert into, or use to replace, the current content.

---

Templates are `ckeditor_templates` **config entities** managed at
`/admin/config/content/ckeditor-templates`; each one stores a label, machine id, description, an uploaded thumbnail (`thumb`, a managed file id) or an alternative image path (`thumb_alternative`), the HTML body (`code`, a `text_format` value/format pair), the list of text `formats` it is offered on, a `status` flag and a `weight`. On top of that the module defines its own plugin type: `@CkeditorTemplate` annotated classes in `Plugin/CkeditorTemplate/`, managed by `plugin.manager.ckeditor_template`, with the interface `CkeditorTemplateInterface` (`label()`, `getDescription()`, `getThumb()`, `allowedFormats()`, `getHtml()`) and base class `CkeditorTemplatePluginBase` — so a module or theme can supply templates in code instead of config. The bundled `config_template` plugin uses a deriver (`ConfigTemplateDeriver`) to turn every **enabled** config entity into a plugin derivative `config_template:<id>`, sorted by weight. In the editor, the CKEditor 5 plugin `ckeditor_templates_plugin` (toolbar item `ckeditorTemplates`, defined in `ckeditor_templates.ckeditor5.yml`) opens a Drupal modal at `/admin/config/content/ckeditor-templates/template-selector/{editor}`; `CKEditorTemplatesDialogForm` lists only the templates whose `allowedFormats()` contains the current format, and returns the chosen HTML through an `EditorDialogSave` AJAX command, optionally replacing the existing content. The per-format setting `replace_content` controls whether the dialog's "Replace actual contents" checkbox starts ticked. Two permissions (`administer ckeditor templates`, `insert ckeditor templates`) separate managing templates from using them. CKEditor 4 sites do not migrate their templates — a `CKEditor4To5Upgrade` plugin only maps the old `Templates` button and the `replace_content` setting.

---

- Give editors a library of ready-made page layouts to drop into a body field.
- Provide a standard "two-column call to action" block of HTML for marketing pages.
- Insert a pre-styled table skeleton without editors hand-writing the markup.
- Offer a branded hero-banner snippet that always uses the approved classes.
- Supply an accessible FAQ / accordion markup pattern editors cannot get wrong.
- Restrict a template to the Full HTML format only, so restricted formats do not see it.
- Show different template sets to different editorial teams by scoping templates per format.
- Illustrate each template with a thumbnail image so editors pick visually.
- Use an external or theme-hosted icon path instead of uploading a thumbnail.
- Order the template list with the weight field so the most used one is first.
- Temporarily retire a template by unchecking *Enabled* instead of deleting it.
- Make "Replace actual contents" default to on for a format used to start pages from scratch.
- Let editors replace a whole draft with a fresh template in one click.
- Ship templates as code from a custom module by implementing a `@CkeditorTemplate` plugin.
- Generate templates dynamically (e.g. from an API) with a custom plugin deriver.
- Alter or remove other modules' templates through `hook_ckeditor_template_info_alter()`.
- Let a "template manager" role edit templates while ordinary editors can only insert them.
- Export the template library as configuration and deploy it between environments.
- Keep landing-page markup consistent across a large editorial team.
- Reduce copy/paste-from-Word markup by giving editors a sanctioned starting point.
- Bootstrap a new content type's body with a documented structure.
- Provide legal/compliance boilerplate (disclaimer blocks) as a single insertable snippet.
- Onboard new editors faster by making the correct markup discoverable in the toolbar.
- Give a design system's components a CKEditor-friendly entry point.
- Migrate from CKEditor 4 Templates by recreating the templates as config entities.
