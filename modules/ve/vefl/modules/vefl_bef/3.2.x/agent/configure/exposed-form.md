# Configure — BEF exposed form in a layout

Prerequisite: enable `vefl_bef` (pulls in `vefl` + `better_exposed_filters`).

## Steps (Views UI)

1. Edit the view → *Exposed form* → **Exposed form style** → **"Better Exposed Filters (with
   layout)"** (plugin `vefl_bef`).
2. In the exposed form **Settings** you now have BEF's normal per-widget options **and** a
   **"Layout settings"** fieldset (identical to vefl_basic): pick a layout, click **Change**,
   then assign each widget to a region.
3. **Apply**.

## Config shape

Under the display's `display_options.exposed_form`:

```yaml
exposed_form:
  type: vefl_bef
  options:
    # ... standard BEF options ...
    bef: { ... }                      # Better Exposed Filters settings tree
    layout:
      layout_id: vefl_onecol
      widget_region:                  # widget id -> region id
        title: middle
        sort_by: middle
        secondary: middle             # BEF-only (see below)
```

## What vefl_bef adds over vefl_basic

Same `layout_id` / `widget_region` mechanism, but the region-assignment list also includes two
BEF-specific pseudo-widgets (from `VeflBef::getRegionElements()`):

| Widget id | Label | Shown when |
|---|---|---|
| `secondary` | Secondary exposed form options | BEF `general.allow_secondary` is checked |
| `sort_bef_combine` | Combine sort order with sort by | BEF `sort.advanced.combine` is checked |

Everything else (filters by exposed identifier, the actions `sort_by`, `sort_order`,
`items_per_page`, `offset`, `submit`, `reset`, and exposed operators) matches the base VEFL
plugin. Set it programmatically the same way: `exposed_form.type = vefl_bef` and populate
`exposed_form.options.layout.layout_id` + `.widget_region`.
