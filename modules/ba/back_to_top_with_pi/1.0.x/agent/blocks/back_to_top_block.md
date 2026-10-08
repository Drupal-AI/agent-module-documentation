<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BackToTopBlock — the block, settings, and render/JS behavior

Source: `src/Plugin/Block/BackToTopBlock.php`, `back_to_top_with_pi.module`,
`templates/back-to-top-with-pi.html.twig`, `js/custom.js`, `back_to_top_with_pi.libraries.yml`.

## Install / enable / place

1. `composer require drupal/back_to_top_with_pi` then enable (`drush en back_to_top_with_pi -y`).
   Core **Block** is a hard dependency (`back_to_top_with_pi.info.yml`).
2. Place the block: *Block layout* (`/admin/structure/block`) → **Place block** → choose
   *"Back to top with progress scrollbar"* (id `back_to_top_with_pi`) into a region. Placement/config
   requires the core **`administer blocks`** permission. There is no module settings route — all
   options live on the per-block configuration form.

## Plugin

- Class `Drupal\back_to_top_with_pi\Plugin\Block\BackToTopBlock extends BlockBase`.
- Annotation: `@Block(id="back_to_top_with_pi", admin_label=@Translation("Back to top with progress
  scrollbar"))`. No `category`, no context, no config dependencies declared.
- `defaultConfiguration()` returns parent config + `['back_to_top_with_pi' => []]` (the real defaults
  are the `?? ...` fallbacks in `blockForm`/`build`, not a schema).

## Configuration form (`blockForm` / `blockSubmit`)

Fields (all under a `back_to_top` fieldset in the form; stored flat on `$this->configuration`):

| Key | #type | Default | Effect |
| --- | --- | --- | --- |
| `circle_stroke_color` | color | '' | SVG progress path `stroke` color |
| `progress_box_shadow` | color | '' | inset box-shadow of the container (converted to `rgba(...,0.1)`) |
| `icon_color` | color | '' | arrow/percentage text color (`::after`) |
| `icon_hover_color` | color | '' | hover background (`::before`) |
| `scroll_bar_position` | select | `right` | `left` or `right` viewport side |
| `has_shadow` | checkbox | false | enable outer drop shadow on hover |
| `shadow_color` | color | `#212121` | drop-shadow color (→ `rgba(...,0.35) 0px 5px 15px`); shown only when `has_shadow` |
| `has_fill_color` | checkbox | false | fill ring background once scrolled past threshold |
| `fill_color` | color | `#000000` | fill color; shown only when `has_fill_color` |
| `scrollbar_type` | select | `icon` | `icon` (arrow) or `percentage` (live %) |
| `created_at` | textfield | `time()` | hidden (`#access => FALSE`); seeds unique element ids |

`blockSubmit()` copies every value from `$form_state->getValues()['back_to_top']` onto
`$this->configuration[...]`. (Note: it reads `$values['back_to_top']` directly; the hidden
`created_at` persists the first placement's timestamp.)

## Rendering (`build()` + Twig)

- `build()` reads `$this->getConfiguration()`. For `progress_box_shadow` and `shadow_color`, if the
  value contains `#`, it parses RGB with `sscanf($val, "#%02x%02x%02x")` and builds an `rgba(...)`
  string (inset shadow at 0.1 alpha; drop shadow at 0.35 alpha). It then builds `$back_to_top_data`
  and returns `#theme => 'back_to_top_with_pi'` with `#back_to_top_data`, adds the block class
  `back-to-top-with-pi-block`, and attaches library `back_to_top_with_pi/back_to_top_with_pi`.
- Theme hook `back_to_top_with_pi` is registered in `back_to_top_with_pi_theme()` with the single
  variable `back_to_top_data`.
- The template `back-to-top-with-pi.html.twig` outputs one `<div id="progress-bar-{{ created_at }}"
  data-scroll-type="…" class="bttwpi-progressbar-container left-scrollbar|right-scrollbar"
  data-attr="…CSS…">` containing an SVG `<path>` for the circle. The `data-attr` value is a block of
  CSS rules (targeting `#progress-bar-…`, its `svg path`, `::before`, `::after`, `.active-progress`)
  built from the color/flag values; percentage mode adds `content: attr(data-before)` rules.

## JavaScript behavior (`js/custom.js`)

- `Drupal.behaviors.backtotop_scrollbar`, gated with `once('backtotop_scrollbar', 'body')`.
- For each `.bttwpi-progressbar-container`: appends `data-attr` as a `<style>` into `<head>` (then
  removes the attribute), measures the SVG path with `getTotalLength()`, and on window `scroll` sets
  `strokeDashoffset = pathLength - scroll*pathLength/height` so the ring fills with scroll progress.
- Adds `.active-progress` once `scrollTop() > 500` (control appears); on container click it
  `preventDefault()` and `animate({scrollTop:0}, 850)` to scroll to top. When `data-scroll-type ==
  'percentage'`, it writes `Math.round(percent)+'%'` into `data-before` on scroll.

## Assets

- Library `back_to_top_with_pi/back_to_top_with_pi`: theme CSS `css/unicons.css` (bundled unicons icon
  font under `css/fonts/`) + `css/custom.css`; JS `js/custom.js`; deps core/jquery, core/drupal.ajax,
  core/drupal, core/drupalSettings, core/once.

## Customization

- Copy `templates/back-to-top-with-pi.html.twig` into your theme to change the markup/layout, and
  override `css/custom.css` / the unicons glyph to use FontAwesome, Flaticon, or a custom icon (per
  the project description). Available Twig variable is `back_to_top_data` (the array documented above).

## Notes / caveats

- All styling comes from **block configuration**, editable only with **`administer blocks`** — there
  is no separate settings page and no per-user or anonymous input path into the rendered output.
- No config schema ships, so the block config is not validated against a schema and the settings are
  not translatable via config; export appears as raw block config.
- `js/custom.js` line 44 `return FALSE;` (uppercase) is a latent bug — `FALSE` is undefined in JS —
  but the preceding `event.preventDefault()` already stops default anchor behavior, so scrolling still
  works.
