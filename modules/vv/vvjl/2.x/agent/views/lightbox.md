<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VVJL lightbox Views style — setup, options, tokens

Everything vvjl adds is a single Views **style plugin**. There is no admin settings form, no route,
and no permission of its own — it is configured per view display in the Views UI.

## Install / enable

```bash
composer require drupal/vvjl:^2.0   # pulls drupal/vvj_core automatically
drush en vvjl
```

Deps (`vvjl.info.yml`): `drupal:views`, `drupal:filter`, `vvj_core:vvj_core`. On a 1.x → 2.x upgrade,
`vvjl_update_10001` (in `vvjl.install`) calls `module_installer->install(['vvj_core'])` so `drush updb`
enables the new foundation automatically (throws an actionable `UpdateException` if vvj_core isn't on disk).

## Add it to a view

1. Create/edit a View. Set **Format = "Views Vanilla JavaScript Lightbox"**, **Show = Fields**.
2. **The first field MUST be an image.** Add more fields for caption / overlay text (optional).
3. Configure the grid, animation, and overlay in the format settings, then Save.

The optional demo `config/optional/views.view.vvjl_example.yml` (id `vvjl_example`) imports a working
node/`field_image` view. The plugin suppresses its "first field must be an image" warning for that view id.

## The plugin

`Drupal\vvjl\Plugin\views\style\Lightbox` — `#[ViewsStyle(id: 'views_vvjl', theme: 'views_view_vvjl',
display_types: ['normal'])]`, extends `Drupal\vvj_core\Plugin\views\style\VvjStylePluginBase`. Overrides:

- `getModuleSlug()` → `'vvjl'`, `getCustomElementTag()` → `'vvjl-lightbox'`.
- `supportsDeeplinking()` → `FALSE` (modal state is transient), `supportsEnableCss()` → `FALSE`
  (no separate `vvjl-style` library; CSS/JS live in the `vvjl/vvjl` library).
- `definePatternOptions()` sets the option defaults; `getAnimationPresets()` lists the six animations;
  `buildPatternSections()` renders three `details` sections (grid, animation, overlay).
- `submitOptionsForm()` → `flattenFormValues()` collapses the sectioned form values back into the flat
  persisted shape and preserves/generates `unique_id` (via inherited `generateUniqueId()`).

## Style options (persisted keys + defaults)

Defaults are `Drupal\vvjl\VvjlConstants`. Config schema: `views.style.views_vvjl` in
`config/schema/vvjl.schema.yml`.

| Key | Type | Default | Notes |
| --- | --- | --- | --- |
| `grid_image_width` | integer | `330` | px; form min `50` (`MIN_GRID_IMAGE_WIDTH`), required |
| `grid_image_gap` | integer | `24` | px; form min `0`, required |
| `overlay_color` | string | `#ffffff` | HTML color input; converted to rgba in preprocess |
| `overlay_opacity` | float | `0.7` | range slider `0.0`–`1.0`, step `0.1`; live readout via `#suffix`/`oninput` |
| `disable_overlay` | boolean | `FALSE` | disables the overlay color/opacity inputs (`#states`) |
| `animation` | string | `a-bottom` | one of the presets below |
| `unique_id` | integer | generated | per-instance id (from `VvjStylePluginBase`) |

**Animation values** (`VvjlConstants`): `none`, `a-zoom`, `a-top`, `a-right`, `a-bottom` (default), `a-left`.
Reduced-motion users get no animation regardless of this setting.

## Rendering path

- `VvjlPreprocessHooks::preprocessViewsViewVvjl()` (hook `preprocess_views_view_vvjl`): copies flattened
  options into `data-grid-image-width` / `data-grid-image-gap` / `data-disable-overlay` / `data-animation`
  list attributes; computes `background_rgb` via `hexToRgb()` + opacity → `rgba(r,g,b,o)`; rewrites each row's
  `#theme` from `views_view_fields` → `views_view_vvjl_fields`; then delegates to
  `ViewsThemeHooks::preprocessViewsViewUnformatted()`.
- `preprocessViewsViewVvjlFields()` delegates to core `preprocessViewsViewFields()`.
- `preprocessViewsView()` adds the legacy `vvj-lightbox` class (vvj_core adds the universal `vvj-component`/`vvj-vvjl`).
- Template `views-view-vvjl.html.twig` emits `<vvjl-lightbox role="region">` containing the grid + a
  `role="dialog"` modal (close/prev/next SVG buttons, counter). Each row is split on
  `<div class="vvjl-separator"></div>` (emitted by `views-view-vvjl-fields.html.twig`) into image vs.
  foreground field; both halves pass through vvj_core's `safe_html` Twig filter, which marks the
  **renderer-produced, already-sanitized** Views field markup as safe.
- JS: `<vvjl-lightbox>` (`js/vvjl-lightbox-element.js`) extends `Drupal.Vvj.ElementBase` (from vvj_core),
  lazily hydrates via IntersectionObserver, wires grid clicks / prev-next / close / Escape with
  AbortController-scoped listeners, traps focus (`Drupal.Vvj.trapFocus`), and clones the clicked row into
  the modal content. Behavior key `Drupal.behaviors.vvjLightbox`.

## Tokens (Views header/footer/empty text, first row)

Defined in `src/Hook/VvjlTokenHooks.php` (`hook_token_info` / `hook_tokens`), namespace `vvjl`,
`needs-data: view`. Only fire when the view's style plugin is `Lightbox`. Actual resolution is
`vvj_core.token_resolver` (`TokenResolver::resolve`), reading the **first result row**:

- `[vvjl:FIELD]` → field's `advancedRender()` output, passed through `Xss::filterAdmin()`.
- `[vvjl:FIELD:plain]` → same, but `strip_tags()` + `Html::decodeEntities()`.

Use these instead of `{{ title }}` in a Global: Text area / Unfiltered text with "Use replacement tokens
from the first row" enabled. Token service is injected nullable (`@?vvj_core.token_resolver`) so the
container compiles during the upgrade window before vvj_core is enabled.

## Help

`src/Hook/VvjlHelpHook::help()` serves README.md at `/admin/help/vvjl` — Markdown-rendered when the
`markdown` module is enabled, otherwise HTML-escaped inside `<pre>`.

## v1 → v2 upgrade (drop-in)

`composer update drupal/vvjl && drush updb && drush cr`. Preserved: plugin id `views_vvjl`, theme hook
`views_view_vvjl`, template names, all option keys, library `vvjl/vvjl`, behavior key
`Drupal.behaviors.vvjLightbox`, CSS class names, SVG paths. Only rendered change: outer wrapper
`<div>` → `<vvjl-lightbox>` (selectors on `.vvjl` still match; `div.vvjl` does not).
