<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure ckeditor5_template (per text format)

There is **no admin settings form and no `configure` route**. The Template button is turned
on and configured per text format, on the CKEditor 5 toolbar screen, and persisted on the
format's **`editor` config entity** (id = the text format's id, e.g. `full_html`).

## Enable via the UI

1. Go to `/admin/config/content/formats` and edit a format whose editor is CKEditor 5
   (e.g. Full HTML).
2. In **Toolbar configuration**, drag the **Template** button from *Available buttons* into
   the *Active toolbar*.
3. A **Template** vertical tab appears under the toolbar. Set:
   - **Template file location** (`file_path`, required) — path (from Drupal root, leading `/`)
     to the JSON templates file, e.g.
     `/modules/contrib/ckeditor5_template/template/ckeditor5_template.json.example`.
     Validated with `file_exists(DRUPAL_ROOT . $file_path)` — a missing file blocks save.
   - **Show title in toolbar?** (`show_toolbar_text`, checkbox 0/1).
   - **Toolbar label** (`custom_toolbar_text`, only shown when the checkbox is on; blank ⇒ `Template`).
4. Save.

## Config shape on the editor entity

The button is a toolbar item id `template`; its settings live under
`settings.plugins.ckeditor5_template_template`:

```yaml
# editor.editor.full_html.yml
settings:
  toolbar:
    items:
      - bold
      - italic
      - template          # <-- the toolbar item
  plugins:
    ckeditor5_template_template:
      file_path: '/modules/contrib/ckeditor5_template/template/ckeditor5_template.json.example'
      custom_toolbar_text: 'Template'
      show_toolbar_text: 1
```

`defaultConfiguration()` supplies `file_path` (the bundled example),
`custom_toolbar_text: 'Template'`, `show_toolbar_text: 1` if you omit them.

## Enable via drush (config, no UI)

Append the `template` item to the toolbar and add the plugin config, then save:

```bash
drush php:eval '
$e = \Drupal\editor\Entity\Editor::load("full_html");   // any CKEditor 5 format id
$s = $e->getSettings();
if (!in_array("template", $s["toolbar"]["items"], TRUE)) { $s["toolbar"]["items"][] = "template"; }
$s["plugins"]["ckeditor5_template_template"] = [
  "file_path" => "/modules/contrib/ckeditor5_template/template/ckeditor5_template.json.example",
  "custom_toolbar_text" => "Template",
  "show_toolbar_text" => 1,
];
$e->setSettings($s);
$e->save();
'
```

Read it back:

```bash
drush php:eval '$s=\Drupal\editor\Entity\Editor::load("full_html")->getSettings();
print in_array("template",$s["toolbar"]["items"],TRUE)?"button on\n":"button off\n";
print json_encode($s["plugins"]["ckeditor5_template_template"] ?? "none")."\n";'
```

To remove: drop `template` from `settings.toolbar.items` and unset
`settings.plugins.ckeditor5_template_template`.

## The template JSON file (`file_path`)

A JSON array; each entry is one selectable template. See
[../plugins/ckeditor5_template.md](../plugins/ckeditor5_template.md) for the field shape.
Point `file_path` at your own file (in a custom module or the codebase) to ship a custom set.
