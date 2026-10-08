# Enable Gutenberg & configure it

Gutenberg has **no global settings page** (`configure` is null). It is turned on per content
type, backed by the `gutenberg` text format.

## Enable Gutenberg on a content type

On the content-type add/edit form (`node_type_edit_form` / `node_type_add_form`) Gutenberg adds an
**"Enable Gutenberg experience"** checkbox (`enable_gutenberg_experience`). Saving runs
`_gutenberg_node_type_form_submit()`, which stores the flag in the `gutenberg.settings` config
object under the key `<node_type>_enable_full`:

```yaml
# config: gutenberg.settings
article_enable_full: true        # Article uses the Gutenberg editor
page_enable_full: false
```

`GutenbergContentTypeManager::isContentTypeSupported($type)` simply returns
`gutenberg.settings:<type>_enable_full`, and the node form is swapped for the full-screen block
editor when that is truthy.

```bash
drush cget gutenberg.settings                       # see all *_enable_full flags
drush cset gutenberg.settings article_enable_full true -y     # enable on Article
drush cset gutenberg.settings article_enable_full false -y    # disable
```

```php
\Drupal::configFactory()->getEditable('gutenberg.settings')
  ->set('article_enable_full', TRUE)->save();
```

## Related per-content-type keys (in `gutenberg.settings`)

| Key | Meaning |
|---|---|
| `<type>_enable_full` | Enable the Gutenberg editor for that content type. |
| `<type>_template` | JSON Gutenberg block template used to prefill new content. |
| `<type>_template_lock` | Template lock mode (`all` / `insert` / `false`) restricting structural edits. |
| `<type>_allowed_image_styles` | Image styles offered in the editor for that content type. |

Gutenberg-editable body fields must be single-value text/`text_long`/`text_with_summary`
(`GutenbergContentTypeManager::getGutenbergCompatibleFields()`).

## The text format & editor

- `filter.format.gutenberg` — text format "Gutenberg Blocks text format" (`format: gutenberg`)
  with the required `gutenberg` filter enabled (`TYPE_TRANSFORM_REVERSIBLE`); its
  `processor_settings.oembed` holds the oEmbed provider patterns and `maxwidth`.
- `editor.editor.gutenberg` — binds the `gutenberg` Editor plugin to that format, with
  `image_upload` settings (scheme `public`, directory `inline-images`).

Both are shipped as `config/install` and enforced by the module. The Editor plugin
(`@Editor id = "gutenberg"`) supports content filtering, targets `textarea` elements, and is not
XSS-safe by itself (the filter/processors sanitize on render).

## Field formatter

`gutenberg_text` (`@FieldFormatter`, for `text` / `text_long` / `text_with_summary`) renders a
value through a Gutenberg text format. Default settings: `format: gutenberg`, `content_only: true`.
