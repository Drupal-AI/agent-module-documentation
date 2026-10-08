# Configure — put a view's exposed form in a layout

There is **no** module settings page. You configure VEFL per view, in the view's *Exposed form*
section.

## Site-builder steps (Views UI)

1. Edit the view → *Exposed form* → **Exposed form style** → choose **"Basic (with layout)"**
   (plugin `vefl_basic`). (For Better Exposed Filters use **"Better Exposed Filters (with
   layout)"** from the `vefl_bef` submodule.)
2. Open the exposed form **Settings**. A **"Layout settings"** fieldset appears.
3. Pick a **Layout** and click **Change** (rebuilds the region selects).
4. For each exposed widget (every filter, plus *Sort by*, *Sort order*, *Items per page*,
   *Offset*, *Submit button*, *Reset button*, and any exposed operator) choose which **region**
   it goes into.
5. **Apply**.

## Where it is stored (view config)

Under the display's `display_options.exposed_form`:

```yaml
exposed_form:
  type: vefl_basic
  options:
    # ...core Basic options (submit_button, reset_button, etc.)...
    layout:
      layout_id: vefl_onecol          # the chosen layout plugin id
      regions: {}                     # runtime-computed, usually empty in config
      widget_region:                  # widget id -> region id
        title: middle
        sort_by: middle
        submit: middle
```

- `layout.layout_id` — id of a Layout API layout (default `vefl_onecol`, region `middle`).
- `layout.widget_region` — the important map: each exposed widget id → the region it renders in.
  Widget ids are the filters' exposed identifiers and the action ids from
  `Vefl::getFormActions()` (`sort_by`, `sort_order`, `items_per_page`, `offset`, `submit`,
  `reset`); exposed operators use their `operator_id`.

Set it programmatically by editing that config (e.g. via `\Drupal::configFactory()
->getEditable('views.view.<id>')` or the view entity) — set `exposed_form.type` to `vefl_basic`
and populate `exposed_form.options.layout.layout_id` + `.widget_region`.
