# Views style plugin — `views_fs` (submodule `views_fs`)

The more generally useful half. Enabling the **`views_fs`** submodule adds a Views **style** plugin
so a view's result rows become animated FractionSlider slides — inheriting the view's filtering,
sorting, access checking and language handling. It requires the base `fractionslider` module (for the
library) and core **Views**.

- Class: `modules/views_fs/src/Plugin/views/style/ViewsFs.php`, `#[ViewsStyle]` id **`views_fs`**,
  title "Views Fractionslider", `help` "Render a Fractionslider.", `theme = "views_view_views_fs"`,
  `display_types = {"normal"}`.
- `protected $usesFields = TRUE;` and `protected $usesRowPlugin = TRUE;` — the plugin renders each
  row's **fields** and supports a row plugin.
- Extends `Drupal\views\Plugin\views\style\StylePluginBase`; only overrides `buildOptionsForm()`.

Choose it under a view display's **Format → "Views Fractionslider"**. Each result row is wrapped in a
`<div class="slide">` and the fields inside a slide animate independently.

## Render path

`template_preprocess_views_view_views_fs()` (in `views_fs.theme.inc`) copies each row into
`rows[id].content` and stashes the general options in `drupalSettings.view_fs_fractionslider`:

```php
$configs = [
  'controls'   => $options['controls'],
  'pager'      => $options['pager'],
  'dimensions' => $options['views_dimensions'],
  'fullwidth'  => $options['views_fullwidth'],
  'responsive' => $options['views_responsive'],
  'increase'   => $options['views_increase'],
];
$vars['#attached']['drupalSettings']['view_fs_fractionslider'] = $configs;
```

The template `views-view-views-fs.html.twig` attaches `fractionslider/global-styles-and-scripts` and
emits `.slider-wrapper > .responisve-container > .slider`, looping `rows` into `.slide` divs.
`js/fractionslider.js` matches `.view .slider-wrapper .slider` and calls `.fractionSlider()` (note:
for the view path `pauseOnHover` is hardcoded `false`).

A second preprocess, **`views_fs_preprocess_views_view_fields()`**, only acts when
`$view->style_plugin->getPluginId() == 'views_fs'`. It rebuilds each field object and — crucially —
stamps the per-field animation `data-*` attributes onto the field wrapper from the style options
(see the per-field option keys below), and adds the `slide-in` class. `Xss::filterAdmin()` is applied
to the row separator; field content is rendered by Views' own field handlers.

## Options form (`buildOptionsForm`)

**General Settings** fieldset:

| Option key | Type | Default | Meaning |
|---|---|---|---|
| `class` | textfield | `''` | Extra class on the div (added alongside `slide`). |
| `pager` | select true/false | `'true'` | Pager dots. |
| `controls` | select true/false | `'true'` | Prev/next arrows. |
| `views_dimensions` | textfield | `'1000, 400'` | Base `width, height`. |
| `views_fullwidth` | select false/true | `'false'` | Transition over full window width. |
| `views_responsive` | select false/true | `'true'` | Responsive scaling. |
| `views_increase` | select false/true | `'true'` | Allow growth past base dimensions. |

**Fields Settings** fieldset — a nested `details` per view field (keyed by the field id), each with the
per-field animation controls mapped to FractionSlider `data-*` layer attributes:

| Per-field option key | Type | Default | FractionSlider attribute |
|---|---|---|---|
| `data-in` | select | (empty) | in-animation: `left`,`fade`,`none`,`right`,`top`,`bottom`,`bottomLeft`,`bottomRight`,`topLeft`,`topRight` |
| `data-out` | select | (empty) | out-animation: `fade`,`none`,`left`,`right`,`top`,`bottom`,`bottomLeft`,`bottomRight`,`topLeft`,`topRight` |
| `data-step` | select 0–9 | (empty) | grouping/sequence step; elements of a step animate together, next step waits |
| `data-ease-in` | select | (empty) | jQuery-UI easing for the in-animation |
| `data-ease-out` | select | (empty) | jQuery-UI easing for the out-animation |
| `data-time` | textfield | `'1000'` | ms to complete the element's animation |
| `space` | textfield | `'30'` | field spacing top (→ first half of `data-position`) |
| `lspace` | textfield | `'30'` | field spacing left (→ second half of `data-position`) |

`space` and `lspace` are combined as `data-position="{space},{lspace}"` on the field wrapper.

## Requirements / gotchas

- The submodule `.info.yml` declares only `fractionslider:fractionslider` as a dependency; it does
  **not** list `drupal:views`, yet the style plugin only works with core Views enabled.
- `ViewsFs.php` imports `use Drupal\core\form\FormStateInterface;` (lower-case `core\form`). PHP
  namespace resolution is case-insensitive so it resolves to `Drupal\Core\Form\FormStateInterface`
  and works, but it is non-canonical.
- The submodule's `hook_theme()` registers a bare `views_fs` theme hook, but rendering goes through
  the plugin's `theme = "views_view_views_fs"` key and `views-view-views-fs.html.twig`.
