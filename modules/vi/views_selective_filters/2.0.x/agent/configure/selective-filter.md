# Adding a selective exposed filter

There is no admin settings page — you configure per view, in the Views UI (or view config).

## In the Views UI

1. **Add the field** you want to filter on to the view (e.g. *Content: Type*, or a taxonomy
   term reference). Configure its output; tick **"Hidden from display"** if you don't want it
   shown in rows.
2. **Add a filter** and choose the entry ending in **"(selective)"** — e.g.
   *"Type (selective)"*. These are the `<field>_selective` entries the module injects.
3. In the filter settings, **expose** it and set the options below.
4. If the selective filter is not offered / errors with a match problem, the filter's base
   field and the field from step 1 are not compatible — pick the matching pair.

## Options (stored on the filter handler)

| Option | Default | Meaning |
|---|---|---|
| `selective_display_field` | '' | Which added view field supplies the option **labels** |
| `selective_display_sort` | `ASC` | Option order: `ASC`/`DESC` (asort), `KASC`/`KDESC` (ksort), `NONE`, `ORIG` (as the original filter) |
| `selective_aggregated_fields` | '' | Extra fields aggregated when collecting values |
| `selective_entity_type` | '' | Target entity type to resolve options against |
| `selective_items_limit` | `100` | If the field has more than this many distinct values, it is rejected as unsuitable for a selective filter |

## In view config (`views.view.<id>`)

The placed filter looks like a normal Views filter but with the selective plugin:

```yaml
display:
  default:
    display_options:
      filters:
        type_selective:
          id: type_selective
          table: node_field_data
          field: type_selective
          plugin_id: views_selective_filters_filter
          exposed: true
          # ... selective_* options above ...
```

The presence of `plugin_id: views_selective_filters_filter` on a filter is the signal that a
selective filter is in use.

## When to use it

Best on **low-cardinality** exposed filters (content type, a small vocabulary, status). It
re-runs a copy of the view to gather the distinct values, so avoid it on high-cardinality
free-text fields; the `selective_items_limit` guard exists for exactly that reason.
