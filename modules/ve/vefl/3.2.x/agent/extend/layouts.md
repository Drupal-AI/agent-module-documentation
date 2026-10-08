# Extend — custom layouts & the helper service

## Any Layout API layout works

VEFL's layout dropdown is populated from the **core layout plugin manager**
(`plugin.manager.core.layout`) via `Vefl::getLayoutOptions()`, grouped by each layout's category.
That means **any** layout registered through `layout_discovery` is selectable — the shipped
`vefl_onecol`, core's own layouts, Display Suite layouts (ids starting `ds_` get default `div`
region wrappers automatically), and Panels layouts.

## Define your own layout

Add a `*.layouts.yml` in any module (exactly as VEFL does in `vefl.layouts.yml`):

```yaml
mymodule_twocol:
  label: 'Two column filter bar'
  category: 'VEFL'
  path: layouts/twocol
  template: mymodule-twocol
  regions:
    left:
      label: Left
    right:
      label: Right
```

Each `regions` key becomes a region a site builder can assign exposed widgets to. Provide the
matching Twig template. No code is required — VEFL will list it automatically.

## The `vefl.layout` service (`Drupal\vefl\Vefl`)

Injected into the exposed form plugins; useful if you extend them:

- `getLayouts()` — all layout definitions (cached statically).
- `getLayoutOptions($layouts = [])` — layouts as a grouped `#options` array (optgroup per category;
  flattened when only one group).
- `getFormActions()` *(static)* — the action widgets VEFL can place in regions:
  `sort_by`, `sort_order`, `items_per_page`, `offset`, `submit`, `reset`.

## Extending the exposed form plugin

`VeflBasic` extends core `Basic` and pulls its behavior from `VeflTrait`
(`defineOptions()` adds the `layout` option tree; `buildOptionsForm()` renders the layout +
per-widget region selects; `exposedFormAlter()` writes `$form['#vefl_configuration']`). To make a
new variant (as `vefl_bef` does for Better Exposed Filters), subclass the relevant core exposed
form plugin and `use VeflTrait`.
