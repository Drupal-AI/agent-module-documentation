# How it works (mechanism)

Two pieces: a `hook_views_data_alter()` that injects the synthetic fields, and a proxy Views
filter plugin that computes the option set.

## 1. `views_selective_filters_views_data_alter()`

For every entry in the Views data that has a `filter` handler (and isn't already selective,
and isn't an `_i18n` / `_format` / `delta` helper), it clones the field definition to
`<field>_selective` and rewrites its filter handler:

```php
$selective['title']              = t('@title (selective)', ['@title' => $title]);
$selective['filter']['id']       = 'views_selective_filters_filter';   // our plugin
$selective['filter']['proxy']    = $field_info['filter']['id'];        // the original handler
$selective['filter']['field']    = $field_name;
$selective['filter']['field_base'] = $real_field;
unset($selective['argument'], $selective['field'], $selective['relationship'], $selective['sort']);
$data[$table][$field . '_selective'] = $selective;
```

So each filterable field gains a twin whose filter is our plugin but which remembers the
original handler in `proxy`.

## 2. The `Selective` filter plugin (`views_selective_filters_filter`)

`Drupal\views_selective_filters\Plugin\views\filter\Selective`:

- `init()` instantiates the **proxy** (original) filter so it behaves like it for query
  building; `query()` delegates so filtering still works normally.
- `getValueOptions()` is the heart: it builds a **copy of the view**
  (`getViewCopy()`), runs it to collect the **distinct values actually present**
  (`getOids()` / `getOriginalOptions()`), and returns only those as the exposed options —
  optionally sorted (`selective_display_sort`) and labelled from `selective_display_field`.
- `validate()` enforces that the selective filter and its field are base-compatible
  (`baseFieldCompatible()`); a mismatch is the common "improperly matched filter and field"
  error.
- `selective_items_limit` (default 100) aborts if a field yields more distinct values than the
  cap — a guard against turning a high-cardinality field into a giant select.

`defineOptions()` declares the option defaults; `buildOptionsForm()` renders the settings shown
in [../configure/selective-filter.md](../configure/selective-filter.md). There is **no** plugin
type defined for others to extend — the module ships this one views filter plugin.
