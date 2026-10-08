# `views_vvjp` — Views Vanilla JavaScript Parallax style plugin

The module's whole surface is one Views style (format) plugin. Class
`Drupal\vvjp\Plugin\views\style\Parallax` extends `Drupal\vvj_core\Plugin\views\style\VvjStylePluginBase`
(from the `vvj_core` dependency). It is registered with the `#[ViewsStyle]` attribute:

```php
#[ViewsStyle(
  id: 'views_vvjp',
  title: new TranslatableMarkup('Views Vanilla JavaScript Parallax'),
  help: new TranslatableMarkup('Render items in Parallax using vanilla JavaScript.'),
  theme: 'views_view_vvjp',
  display_types: ['normal'],
)]
```

Slug/tag overrides: `getModuleSlug(): 'vvjp'`, `getCustomElementTag(): 'vvjp-parallax'`,
`supportsDeeplinking(): FALSE`. Enable-CSS description is overridden to parallax-specific wording.

## How to configure a view (the two hard requirements)

There is no admin settings page. In the Views UI:

1. Set **Format** to *Views Vanilla JavaScript Parallax*, **Show** to *Fields*.
2. **First field** must be an image field using the **"URL to image" (`image_url`) formatter** — its
   rendered URL becomes the parallax `background-image`. `validate()` (`Parallax.php:459`) enforces
   this: it errors if there is no field, or if `reset($fields)['type'] !== 'image_url'`
   (`VvjpConstants::REQUIRED_FIELD_TYPE`). Until met, `buildWarningMessage()` shows an error linking to
   the `vvjp_example` view's edit form.
3. Place a **`<div class="vvjp-separator"></div>`** field (e.g. a Custom text field) between the image
   URL field and the foreground content fields. The main template splits the rendered row on this
   marker: `split[0]` (striptags + trim) → background URL; `split[1]` → foreground content.

## Option keys, defaults, bounds

`definePatternOptions()` (`Parallax.php:67`) adds these to the base plugin's options. The form is
grouped into `#type: details` sections (`buildPatternSections()`); `submitOptionsForm()` flattens the
section-nested values back to a flat option array via `flattenFormValues()`, and re-injects
`enable_css` (from the base `advanced_section`) and `unique_id`.

| Option key | Form section | Type | Default | Notes / bounds |
|---|---|---|---|---|
| `available_breakpoints` | responsive | select | `all` | `all`/`576`/`768`/`992`/`1200`/`1400`; picks which `vvjp__<bp>` CSS library loads |
| `section_height` | dimensions | `{value:int, unit:string}` | `{75, vh}` | unit ∈ `vw`/`vh`/`px`/`%`/`em`/`rem`; rendered as `{value}{unit}` in preprocess |
| `max_width` | dimensions | number | `0` | px; `0` = 100% (no max). `#min: 0` |
| `parallax_speed` | parallax | number | `0.3` | range `0.1`–`2.0`, step `0.1` |
| `background_position` | background | select | `center` | 18 CSS `background-position` values (see below) |
| `bg_animation_speed` | background | number | `0.5` | range `0.1`–`2.0`, step `0.1` (used as `{n}s`) |
| `bg_animation_easing` | background | select | `ease` | `ease`/`ease-in`/`ease-out`/`ease-in-out`/`linear` |
| `scroll_effect` | effects | select | `fade` | foreground effect; 11 values (see below) |
| `overlay_color` | overlay | color | `#ffffff` | hex; converted to rgba with opacity in preprocess |
| `overlay_opacity` | overlay | range | `0.7` | range `0.0`–`1.0`, step `0.1` |
| `over_content_only` | overlay | checkbox | `FALSE` | overlay only under `.parallax-content`, not full row |
| `disable_overlay` | overlay | checkbox | `FALSE` | drop the overlay entirely |
| `enable_css` | advanced (base) | checkbox | `TRUE` | include the plugin CSS libraries |
| `unique_id` | — | int | generated | per-instance id, preserved on resubmit |

Enumerations (constants in `Drupal\vvjp\VvjpConstants`):

- **Scroll effects** (`scroll_effect`): `none`, `fade`, `scale`, `rotate`, `fade-scale`, `three-d`,
  `shadow`, `glow`, `smooth`, `hover`, `combined`. The value becomes both a CSS class
  `{value}-effect` on `.parallax-row` **and** the `data-parallax-effect` attribute.
- **Background positions** (`background_position`): `center`, `top`, `bottom`, `left`, `right`,
  `top left`, `top right`, `bottom left`, `bottom right`, `center top`, `center bottom`, `50% 50%`,
  `0% 0%`, `100% 100%`, `30% 70%`, `10px 20px`, `100px 50%`, `left 10%`.

## Rendering pipeline (templates + preprocess)

- Theme hooks are declared in `VvjpThemeHook`: `views_view_vvjp` (→ `templates/views-view-vvjp.html.twig`)
  and `views_view_vvjp_fields` (→ `templates/views-view-vvjp-fields.html.twig`).
- `views-view-vvjp-fields.html.twig` renders the first field, then emits the `vvjp-separator` div,
  then the remaining fields.
- `VvjpPreprocessHooks::preprocessViewsViewVvjp()` computes `background_rgb` = `rgba(r,g,b, opacity)`
  from `overlay_color` + `overlay_opacity` (`hexToRgb()` handles 3- and 6-char hex), formats
  `section_height` as `{value}{unit}`, and rewrites each row's `#theme` suggestion
  `views_view_fields` → `views_view_vvjp_fields`.
- `preprocessViewsView()` adds a legacy `vvj-parallax` class to the outer `views_view` wrapper (v1
  contract preservation).
- The main template outputs `<vvjp-parallax class="vvjp br-{breakpoint} vvjp-{id}">` → `.vvjp-inner` →
  one `.parallax-row` per row, each with `.parallax-background` (inline `background-image: url(...)`),
  optional `.parallax-overlay`, and `.parallax-content > .parallax-content-inner`. Overlay placement:
  full-row `.parallax-overlay` when `background_rgb && !disable_overlay && !over_content_only`;
  content-scoped `--bg-parallax-content` when `over_content_only`.
- CSS class contract (preserved from v1): `.vvjp`, `.vvjp-inner`, `.parallax-row`,
  `.parallax-background`, `.parallax-overlay`, `.parallax-content`, `.parallax-content-inner`.

## Front-end behavior (`<vvjp-parallax>` custom element)

`js/vvjp-parallax-element.js` defines `customElements.define('vvjp-parallax', …)` extending
`Drupal.Vvj.ElementBase` (from `vvj_core`). On hydrate it listens (RAF-throttled, AbortController
`signal`) for `scroll`/`resize` and, per `.parallax-row`:

- Reads `data-breakpoint`, `data-parallax-speed`, `data-parallax-effect`.
- **Mobile bypass:** when `data-breakpoint != all` and viewport ≤ breakpoint px, hides
  `.parallax-background` and inserts a plain `<img class="vvjp-fallback-img">` (URL extracted from the
  inline `background-image`). Above the breakpoint, restores the background and removes the fallback.
- **Effect transform** (`_applyEffect`) recognizes `blur`, `opacity`, `scale`, `rotate`, and defaults
  everything else to `translateY(offset)`. (The CSS `{value}-effect` class handles the visual
  foreground effects like `fade`; `.parallax-content` gets a `visible` class when in viewport.)
- `reducedMotion` (from base) forces `offset = 0`.

`js/vvjp.js` is a compat shim exposing `Drupal.behaviors.VVJParallax`.

## Libraries

`buildLibraryList()` calls the parent then appends `vvjp/vvjp__{available_breakpoints}`. Declared in
`vvjp.libraries.yml`:

- `vvjp` — `js/vvjp-parallax-element.js`, `js/vvjp.js`, `css/vvjp.css`; deps `core/drupal`,
  `core/drupal.ajax`, `core/drupalSettings`, `core/once`, `vvj_core/tokens`, `vvj_core/base`,
  `vvj_core/a11y`, `vvj_core/element-base`.
- `vvjp-style` — `css/vvjp-style.css`.
- `vvjp__all` / `vvjp__576` / `vvjp__768` / `vvjp__992` / `vvjp__1200` / `vvjp__1400` — breakpoint CSS.

## Config schema

`config/schema/vvjp.schema.yml` types `views.style.views_vvjp` (`type: views_style`). `section_height`
is a nested mapping (`value: integer`, `unit: string`); `available_breakpoints` is typed as a
`sequence` of strings (the form uses a single-value select — treat the persisted shape per the sample
`views.view.vvjp_example`, which stores it as a one-element list).
