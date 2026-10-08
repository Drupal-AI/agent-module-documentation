<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates: the config entity and the toolbar button

## Routes

| Route | Path | Permission |
|---|---|---|
| `entity.ckeditor_templates.collection` | `/admin/config/content/ckeditor-templates` | `administer ckeditor templates` |
| `entity.ckeditor_templates.add_form` | `…/ckeditor-templates/add` | `administer ckeditor templates` |
| `entity.ckeditor_templates.edit_form` | `…/ckeditor-templates/{ckeditor_templates}` | `administer ckeditor templates` |
| `entity.ckeditor_templates.delete_form` | `…/{ckeditor_templates}/delete` | `administer ckeditor templates` |
| `ckeditor_templates.selector` | `…/ckeditor-templates/template-selector/{editor}` | `insert ckeditor templates` |

The last one is the modal the toolbar button opens; `{editor}` is the text-format/editor id.

## The `ckeditor_templates` config entity

Config name: `ckeditor_templates.ckeditor_templates.<id>`

```yaml
id: promo_banner
label: 'Promo banner'
status: true                 # disabled templates are skipped by the deriver
description: 'Two-column promo with CTA'
thumb: {  }                  # sequence of managed file IDs (from a managed_file upload)
thumb_alternative: ''        # or a path/URL: public://icon.png, /themes/x/icon.png, //cdn/…
code:
  value: '<div class="promo"><h2>Title</h2></div>'
  format: full_html          # the text_format used when editing the snippet
formats:                     # text formats this template is offered on
  full_html: full_html
weight: 0                    # ordering in the dialog (auto = max + 1 on create)
```

`config_export` keys: `id, label, status, description, thumb, thumb_alternative, code,
formats, weight`. `admin_permission` is `administer ckeditor templates`. Saving or deleting a
template clears the `plugin.manager.ckeditor_template` definition cache automatically.

### Create one from the CLI

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("ckeditor_templates")->create([
    "id" => "promo_banner",
    "label" => "Promo banner",
    "status" => TRUE,
    "description" => "Two-column promo with CTA",
    "thumb" => [],
    "thumb_alternative" => "",
    "code" => ["value" => "<div class=\"promo\"><h2>Title</h2></div>", "format" => "full_html"],
    "formats" => ["full_html" => "full_html"],
    "weight" => 0,
  ])->save();
'
drush cget ckeditor_templates.ckeditor_templates.promo_banner
drush config:status | grep ckeditor_templates          # list what exists
```

`formats` is stored as the raw value of a `checkboxes` element, i.e. `{id: id}` for checked
formats (unchecked entries are `0`). Only text formats whose editor is **ckeditor5** are
offered.

## Turning the button on for a text format

`ckeditor_templates.ckeditor5.yml` defines plugin `ckeditor_templates_plugin` with toolbar
item `ckeditorTemplates`, JS plugin `ckeditorTemplates.CKEditorTemplates`, dialog settings
(`height: 75%`, class `ckeditor-templates-widget-modal`, title "Content Templates") and the
configurable class `…\Plugin\CKEditor5Plugin\CKEditorTemplatesDialog`.

```yaml
# editor.editor.<format>
settings:
  toolbar:
    items: [ ..., ckeditorTemplates ]
  plugins:
    ckeditor_templates_plugin:
      replace_content: true      # default value of "Replace actual contents" in the dialog
```

Schema: `ckeditor5.plugin.ckeditor_templates_plugin` (single boolean `replace_content`,
`NotNull` constrained, default `FALSE`).

```bash
drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("full_html");
  $s = $e->getSettings();
  if (!in_array("ckeditorTemplates", $s["toolbar"]["items"], TRUE)) {
    $s["toolbar"]["items"][] = "ckeditorTemplates";
  }
  $s["plugins"]["ckeditor_templates_plugin"] = ["replace_content" => TRUE];
  $e->setSettings($s)->save();
'
```

At runtime `CKEditorTemplatesDialog::getDynamicPluginConfig()` injects
`ckeditorTemplates.dialogUrl` = the `ckeditor_templates.selector` URL for that editor.

## Gotchas

- A template with `status: false` never reaches the dialog (`ConfigTemplateDeriver` queries
  `status = 1`).
- If no template lists the current format, the dialog shows
  *"There is no template available for the &lt;format&gt; text format."*
- The `code` HTML is still subject to the format's filters/allowed tags — restrictive
  formats will strip template markup.
- Upgrading from CKEditor 4 does **not** migrate templates; only the `Templates` button →
  `ckeditorTemplates` and `replace_content` are mapped.
