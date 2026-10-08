<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure iframe embedding per text format

There is **no global settings page** (`configure` route is `null`). You enable the Iframe
Embed button for each text format at `/admin/config/content/formats/manage/<format>`.
Everything persists on the `editor.editor.<format>` config entity. The format's editor must
be **CKEditor 5** (this is a CKEditor 5 plugin).

## UI

1. Go to `/admin/config/content/formats`, edit a CKEditor 5 format (e.g. Full HTML).
2. Drag **Iframe Embed** from *Available buttons* into the active toolbar.
3. Open the plugin's vertical tab (**Allowed optional attributes**) and tick the iframe
   attributes editors may use beyond the always-required `src`. Options are `align`,
   `frameborder`, `height`, `width`, `longdesc`, `name`, `scrolling`, `tabindex`, `title`,
   `allowfullscreen`. Four are labelled *(deprecated)* — `align`, `frameborder`,
   `longdesc`, `scrolling` — and are off by default.
4. Save. With CKEditor 5 you do **not** have to hand-edit the "Limit allowed HTML tags"
   string: the plugin declares its own allowed-elements subset (`<iframe src …>` plus the
   ticked attributes), so `filter_html` is updated automatically.

## Where it is stored

- Toolbar item id in `settings.toolbar.items`: **`iframeEmbed`**.
- Attribute choices in
  `settings.plugins.ckeditor_iframe_embed_iframeembed.enabled_optional_attributes`
  (a sequence of attribute-name strings).
- Default when the button is added but never configured: all non-deprecated attributes
  (`height`, `width`, `name`, `tabindex`, `title`, `allowfullscreen`).

## Drush / config

Read the current state:

```bash
drush config:get editor.editor.full_html settings.toolbar.items
drush config:get editor.editor.full_html settings.plugins.ckeditor_iframe_embed_iframeembed
```

Add the button (and set the allowed attributes) programmatically:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $items = $c->get("settings.toolbar.items") ?: [];
  if (!in_array("iframeEmbed", $items, TRUE)) { $items[] = "iframeEmbed"; }
  $c->set("settings.toolbar.items", $items);
  $c->set("settings.plugins.ckeditor_iframe_embed_iframeembed.enabled_optional_attributes",
    ["height", "width", "title", "allowfullscreen"]);
  $c->save();
'
drush cr
```

## CKEditor 4 / restrictive filters (legacy note)

The bundled `README.txt` describes CKEditor 4 usage. On CKE4 (or if a format uses a very
restrictive filter and you are *not* relying on the CKE5 plugin's element subset) you must
either uncheck *Limit allowed HTML tags and correct faulty HTML* or add
`<iframe src longdesc name scrolling title align height frameborder width>` to the allowed
tags manually. On Drupal 11 with CKEditor 5, prefer the automatic subset above.

Config schema for the stored settings lives in
`config/schema/ckeditor_iframe.schema.yml`
(`ckeditor5.plugin.ckeditor_iframe_embed_iframeembed`, a mapping with one sequence
`enabled_optional_attributes`).
