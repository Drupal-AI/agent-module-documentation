<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable HTML embed on a text format

The module has **no settings page** (`configure: null`). You enable it per text format by adding its
toolbar button to that format's CKEditor 5 toolbar.

## Via the UI

1. *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) → configure a format that uses **CKEditor 5** (e.g. Full HTML).
2. In **Available buttons**, drag **HTML embed** into the **Active toolbar**.
3. If **"Limit allowed HTML tags and correct faulty HTML"** is enabled, add the tags/attributes you
   want editors to be able to embed (the module itself declares `<div>` and
   `<div class="raw-html-embed">`).
4. Save.

## Where it is stored

CKEditor toolbars/plugins live on the **editor** config entity, not the filter format:

`editor.editor.<format_id>`:

```yaml
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - italic
      - htmlEmbed        # <-- this enables the HTML embed button
  plugins:
    # plugin-specific settings keyed by CKEditor 5 plugin id (htmlEmbed has no Drupal settings form)
```

Adding `htmlEmbed` to `settings.toolbar.items` is what activates the feature.

Read it back:

```bash
drush cget editor.editor.full_html settings.toolbar.items
```

## Programmatic enable (drush php:eval)

```php
$editor = \Drupal\editor\Entity\Editor::load('full_html'); // must already use ckeditor5
$settings = $editor->getSettings();
if (!in_array('htmlEmbed', $settings['toolbar']['items'], TRUE)) {
  $settings['toolbar']['items'][] = 'htmlEmbed';
}
$editor->setSettings($settings)->save();
```

## What the module contributes (from `ckeditor_html_embed.ckeditor5.yml`)

- **Drupal plugin id**: `ckeditor_html_embed_html_embed`.
- **CKEditor 5 JS plugin**: `htmlEmbed.HtmlEmbed`.
- **Toolbar item**: `htmlEmbed` (label "HTML Embed").
- **CKEditor config**: `htmlEmbed.showPreviews: false` — the editor shows the raw HTML source, not
  a rendered preview. This is static (no Drupal UI to change it).
- **Elements**: `<div>` and `<div class="raw-html-embed">` (declared so allowed-tags handling knows
  what the plugin outputs).
- **Libraries**: editor library `ckeditor_html_embed/htmlEmbed` (the bundled build), admin library
  `ckeditor_html_embed/admin.htmlEmbed` (toolbar icon CSS).

## Security note

Embedded HTML can include `<script>`/iframes. Only add the **HTML embed** button to formats used by
**trusted roles**, and rely on the format's allowed-HTML filter to constrain what can be embedded on
less-trusted formats.
