# Configure — the Flipped Table style

No module settings. You "configure" it by choosing it as a view's **Format**.

## In the Views UI

Edit a view → **Format** → change the style to **Flipped Table** → apply. Under the style's
settings you get the standard core **Table** options (columns, sortable, separators, caption,
sticky header, empty-table) **plus** one extra checkbox:

- **Show the first field as the table header** (`flipped_table_header_first_field`, default on)
  — renders the first field's flipped row inside `<th>` header cells (scope=row/col headers)
  instead of `<td>`.

The core Table "row class" / "default row class" options are hidden (`#access = FALSE`) because
they don't map cleanly onto a flipped layout.

## In a view's config (YAML / config entity)

The style lives at `display.<display_id>.display_options.style`:

```yaml
style:
  type: flipped_table
  options:
    # ... all inherited core Table options (columns, info, sticky, caption, ...) ...
    flipped_table_header_first_field: true
```

`FlippedTable::defineOptions()` adds only `flipped_table_header_first_field` (default TRUE);
every other option is inherited from the core Table style, so an existing table view can be
switched to `flipped_table` by only changing `style.type` (the inherited options stay valid).

## Setting it programmatically

```php
use Drupal\views\Entity\View;
$view = View::load('my_view');
$display = &$view->getDisplay('default');
$display['display_options']['style']['type'] = 'flipped_table';
$display['display_options']['style']['options']['flipped_table_header_first_field'] = FALSE;
$view->save();
```

## Notes

- `provides_config_schema` is false — the plugin relies on the core Table style's schema plus
  the single boolean option.
- `views_flipped_table_post_update_boolean_values()` migrates old integer option values
  (`override`, `sticky`, `empty_table`, `flipped_table_header_first_field`, and per-field
  `sortable`/`empty_column`) to real booleans on existing views.
