# panels — altering output & layouts

## Alter the rendered display: `hook_panels_build_alter()`

Declared in `panels.api.php`. Runs after a Panels display is fully built, giving you the
render array and the display object.

```php
use Drupal\panels\Plugin\DisplayVariant\PanelsDisplayVariant;

function mymodule_panels_build_alter(array &$build, PanelsDisplayVariant $panels_display) {
  $build['extra'] = ['#markup' => '<div>Some extra markup</div>'];
}
```

## Layouts & icons

Panels renders through core **Layout Discovery** — the layout is a standard core `Layout`
plugin, and its regions are the regions Panels fills. Panels ships preview PNGs under
`layouts/` and `panels_layout_alter()` (implements `hook_layout_alter`) attaches an icon
path to the core layouts (`layout_onecol`, `layout_twocol`, `layout_twocol_bricks`,
`layout_threecol_25_50_25`, `layout_threecol_33_34_33`) and a `no-layout-preview.png`
fallback to any layout with no icon. Define your own layouts the normal core way
(`mytheme.layouts.yml` / `@Layout`) and they become available to Panels.

## Per-display / per-pane wrappers

The `panels_variant` config schema exposes `css_classes` (sequence), `html_id` and
`css_styles`, and `panels_config_schema_info_alter()` adds the same three keys to every
`ctools.block_plugin.*` — so both the whole display and individual panes can carry wrapper
classes, an id, and inline styles that surface in the rendered markup.

## Title behavior constants (`panels.module`)

`PANELS_TITLE_FIXED` (0), `PANELS_TITLE_NONE` (1), `PANELS_TITLE_PANE` (2) — control whether
the page title is fixed, hidden, or taken from a specific pane.
