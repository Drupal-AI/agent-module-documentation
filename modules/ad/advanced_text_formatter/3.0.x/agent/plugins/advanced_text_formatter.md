# The `advanced_text` FieldFormatter plugin

The module ships exactly one plugin and defines no plugin *types* of its own — it
implements core's `FieldFormatter` plugin type.

- **Class:** `Drupal\advanced_text_formatter\Plugin\Field\FieldFormatter\AdvancedTextFormatter`
  (extends `FormatterBase`).
- **Plugin id:** `advanced_text`  ·  **Label:** `Advanced Text`.
- **Field types:** `string`, `string_long`, `text`, `text_long`, `text_with_summary`.
- **quickedit editor:** `plain_text`.
- Injects `entity_type.manager` (used to label the "Link to the <entity>" option).

## Filter constants

```php
const FORMAT_DRUPAL    = 'drupal';      // run through a chosen named text format
const FORMAT_INPUT     = 'input';       // run through the item's own selected format
const FORMAT_NONE      = 'none';        // no filtering (raw)
const FORMAT_PHP       = 'php';         // deprecated; behaves like limit_html + warning
const FORMAT_LIMIT_HTML = 'limit_html'; // Xss::filter() to allowed_html list
```

## Render pipeline (`viewElements()`)

For each field item, in order:

1. **Choose source:** if `use_summary` and `$item->summary` is non-empty, use the summary; else `$item->value`.
2. **Token replace:** if `token_replace`, `\Drupal::token()->replace($output, [user, <entity_type> => entity])`.
3. **Filter** on `filter`:
   - `drupal` → `check_markup($output, $this->getSetting('format'), $item->getLangcode())`.
   - `php` → warning, then falls through to `limit_html`.
   - `limit_html` → `Xss::filter($output, allowed_html)`; then `_filter_autop()` if `autop`.
   - `input` → `check_markup($output, $item->format, $item->getLangcode())`.
   - `none` → unchanged.
4. **Trim:** if `trim_length > 0`, `advanced_text_formatter_trim_text($output, ['word_boundary','max_length','ellipsis'])`.
5. **Link:** if `link_to_entity`, render as a `#type => link` to the entity's `revision` URL (falls back to canonical); else `#markup`.

`advanced_text_formatter_trim_text()` (in `advanced_text_formatter.module`) is a
Views-derived truncation helper handling word boundaries, ellipsis, and HTML-aware
trimming.

## Implementing / configuring it

You don't subclass it — you *apply* it. See
[../configure/advanced_text_formatter.md](../configure/advanced_text_formatter.md) for
the setting keys, defaults, and the drush `setComponent()` recipe. The module also alters
the matching text/string field **widgets** (`hook_field_widget_*_form_alter` in the
`.module` file) to add third-party widget settings, but the display side is entirely this
one formatter.
