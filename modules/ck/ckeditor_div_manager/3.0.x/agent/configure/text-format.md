<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable Div Manager on a text format

There is no module settings page. You enable the button **per text format** on
`/admin/config/content/formats/manage/<format>` (Text formats and editors), which uses a
CKEditor 5 editor. Drag **Div Manager** from *Available buttons* into the *Active toolbar*.

## Where it is stored

The toolbar lives on the `editor.editor.<format>` config entity (module: `editor`):

```yaml
# editor.editor.full_html.yml
format: full_html
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - italic
      - DivManager        # <-- this enables the plugin
  plugins: {  }
```

The toolbar item id is exactly **`DivManager`** (the key under `drupal.toolbar_items` in
`ckeditor_div_manager.ckeditor5.yml`). Adding it to `settings.toolbar.items` enables the
Drupal CKEditor 5 plugin `ckeditor_div_manager_plugin`.

## Allowed HTML (filter_html)

If the format has *Limit allowed HTML tags and correct faulty HTML* (`filter_html`) enabled,
the allowed-tags string must permit the container tag or the button's markup is stripped:

- Minimum: `<div>`.
- For the dialog's class/id/title fields to survive: `<div class id title>`.

The plugin's `elements` declaration (`<div>`, `<div class="simple-box-description">`) is what
Drupal's CKEditor 5 "smart default"/validation uses to reconcile with filter_html.

## Scripted enable (drush)

```bash
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("editor")->load("full_html");
  $s = $e->getSettings();
  if (!in_array("DivManager", $s["toolbar"]["items"], TRUE)) {
    $s["toolbar"]["items"][] = "DivManager";
    $e->setSettings($s)->save();
  }
'
```

Only formats whose editor is `ckeditor5` can use it (on this site: basic_html, full_html,
rich_text, webform_default). There are **no per-instance plugin settings** to configure.
