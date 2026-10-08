# Block: Accessibility menu

`src/Plugin/Block/AccessibilityMenu.php` — `@Block(id = "accessibility_menu", admin_label =
"Accessibility menu")`, extends `BlockBase`, `ContainerFactoryPluginInterface`. Renders a floating
button + slide-up panel. Place it via Block Layout, or let `hook_preprocess_html` inject it
site-wide (see [../configure/settings.md](../configure/settings.md)).

## build()

- `#theme => 'accessibility_menu'` (template `templates/accessibility-menu.html.twig`; theme hook
  registered in `accessibility_menu_theme()` with variables `info`, `show_mobile`).
- `#info['items']` = `\Drupal::service('accessibility_menu')->getSettings()` — the feature/option
  list (see below).
- `#show_mobile` from `accessibility_menu.settings:show_mobile`.
- Always attaches library `accessibility_menu/css`.
- JS delivery depends on config `inline`:
  - `inline` true → reads `misc/accessibility_menu.js` with `file_get_contents()` and inlines it as
    an `html_head` `<script>` via `Markup::create()` (keyed `accessibility_js`). The file read is a
    fixed module asset, not user input.
  - `inline` false → attaches library `accessibility_menu/js`.
- Cacheable: adds `accessibility_menu.settings` as a cacheable dependency.

## Service `accessibility_menu`

Class `Drupal\accessibility_menu\AccessibilityMenu` (autowired, `accessibility_menu.services.yml`).
Method `getSettings()` returns an array keyed by feature; each entry has a translated `title`, an
`access` flag (the matching `plugins.<feature>` config value — falsy hides it in the template), and
an `options` list. Options define how many "steps" each control cycles through:

| Feature key | `title` | Options (steps) |
| --- | --- | --- |
| `contrast` | Contrast settings | High contrast, Inversion, White, Comfort (4 themes) |
| `font_size` | Font size | 4 steps |
| `letter_spacing` | Letter spacing | Increased, Moderate, Wide (3) |
| `line_height` | Line height | 1.5x, 1.75x, 2x (3) |
| `images` | Images | Grayscale, Disabled (2) |
| `font_style` | Font | Serif, Sans serif (2) |
| `cursor` | Big cursor | 1 (on/off) |
| `reading_line` | Reading line | 1 (on/off) |

## Client-side behavior (`misc/accessibility_menu.js`)

Plain IIFE, no jQuery/Drupal.behaviors. On `DOMContentLoaded` it instantiates one
`AccessibilityMenu` bound to `.js-accessibility-menu`.

- **Persistence:** state is stored in `localStorage` under key `accessibility_menu` (a JSON map of
  `feature => stepIndex`). There is no cookie and nothing is sent to the server — it is per-browser
  and re-applied on load via `refresh()`. `Reset the settings` clears the key.
- **How controls work:** clicking a feature tile advances its step (`itemClick`), highlights the
  active links, then `refresh()` re-applies all styles. `refresh()` walks `body *`, records each
  element's initial `fontSize`/`lineHeight`/`letterSpacing`/`fontFamily`, and multiplies by
  coefficients: `fontSize [1.15,1.35,1.55,1.7]` (capped at `fontSizeLimit = 30px`), `lineHeight
  [1.25,1.5,1.75]`, `letterSpacing [1.25,1.75,2.25]`, `fontFamily [serif, sans-serif]`.
- **Body classes / attributes it toggles:** `images-grayscale`, `images-none`, `am-big-cursor`, a
  reading line element `.am-reading-line` that tracks the mouse, and `data-am_theme="theme_0..3"`
  for the four contrast themes. Elements marked `.am-skip` (the widget's own markup) are excluded
  from theming.

## Assets & template

- Libraries (`accessibility_menu.libraries.yml`): `css` = `misc/accessibility_menu.css` +
  `misc/accessibility_menu_mobile.css`; `js` = `misc/accessibility_menu.js`. The SCSS source
  (`misc/accessibility_menu.scss`) is compiled ahead of time — restyle by editing the SCSS and
  recompiling, or override the library. Colors are driven by CSS var `--accessibility-menu-color`
  (default `#1e90ff`); icons come from an embedded `accessibility-icons` web font.
- **Mobile:** below 1200px the button/panel are `display:none` unless `show_mobile` adds the
  `am-mobile-visible` class, which `accessibility_menu_mobile.css` re-enables (with tuned sizing at
  ≤1199px and ≤480px).
- Template classes are hooks for the JS: `.js-accessibility-btn` (open), `.js-accessibility-close`,
  `.js-accessibility-reset`, `.js-accessibility-link`; each tile carries `data-type` and
  `data-title`. Translated strings ("Accessibility menu", "Reset the settings", feature titles) are
  emitted through Twig auto-escaping.
