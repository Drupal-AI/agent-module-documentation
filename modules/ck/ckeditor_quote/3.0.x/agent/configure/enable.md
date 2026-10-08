# Enabling the Quote button on a text format

CKEditor Quote has no settings of its own. You enable it by adding its toolbar item to a text
format that uses the CKEditor 5 editor.

## In the UI

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) and edit a format whose editor is **CKEditor 5**.
2. In the toolbar configuration, drag the **Quote** button (tooltip "Quote Dialog") from *Available
   buttons* into the *Active toolbar*.
3. Save. If the format uses *Limit allowed HTML tags* (filter_html), CKEditor 5 auto-adds the tags
   the plugin declares (`<p>`, `<div>`, `<div class="author">`, `<blockquote>`).

## What it stores (config)

The active toolbar lives on the editor config entity `editor.editor.<format>`:

```yaml
# editor.editor.<format>
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - italic
      - Quote          # <-- this enables CKEditor Quote (note the capital Q)
  plugins: {}
```

The plugin id in `ckeditor_quote.ckeditor5.yml` is `ckeditor_quote_quote`; its `toolbar_items` key
is `Quote`, which is the string that must appear in `settings.toolbar.items`. There is no separate
`settings.plugins.*` entry needed — this plugin has no configurable options.

## Setting it programmatically

```php
$editor = \Drupal\editor\Entity\Editor::load('basic_html');
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'Quote';
$editor->setSettings($settings);
$editor->save();
```

## Produced markup

Inserting a quote and saving yields:

```html
<blockquote>
  <div class="quote"><p>Only when we are brave enough…</p></div>
  <div class="author">Brene Brown</div>
</blockquote>
```

Existing `<blockquote>` content is up-cast into the editable widget on load; a child
`<div class="author">` or `<cite>` becomes the author, so plain blockquotes without an author still
work.
