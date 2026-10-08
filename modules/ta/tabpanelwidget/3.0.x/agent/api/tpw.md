<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Tpw` builder API

`Drupal\tabpanelwidget\Tpw` (`src/Tpw.php`) is the builder that every consumer uses to turn a list
of title/content pairs into a tab/accordion render array. `Drupal\tabpanelwidget\TpwItem`
(`src/TpwItem.php`) is one panel.

## Install & enable

```bash
composer require drupal/tabpanelwidget
drush en tabpanelwidget -y
```

No Drupal module dependencies. The **front-end library must be installed separately** at
`/libraries/tabpanelwidget/dist/tabpanelwidget.min.js` and `.min.css` (README recommends
asset-packagist: `composer require tabpanelwidget/tabpanelwidget:^3.0`). The module supports library
1.x and 3.x, **not 2.x**. Without the library the markup renders but is unstyled/non-interactive.

## Service vs. `new Tpw()`

`tabpanelwidget.services.yml` registers `tabpanelwidget.tpw` (`class: Tpw`,
`arguments: ['@config.factory']`). **However**, `Tpw::__construct()` ignores injected arguments and
does `$this->configFactory = \Drupal::service('config.factory')` itself, and both submodules build
it with `new Tpw()` rather than the service. Either way of obtaining an instance works.

`__construct()` loads `$this->options = configFactory->getEditable('tabpanelwidget.settings')` and
`$this->items = []`. Note it uses **getEditable** and the setters below call `->set()` on that
object (without `->save()`) — so a `Tpw` mutates an in-request copy of the settings config; it does
not persist changes. Call `reset()` to reload fresh options and clear items (the Views plugin does
this because Views may reuse one plugin instance across a page).

## Building a tabset (typical flow)

```php
use Drupal\tabpanelwidget\Tpw;

$tpw = new Tpw();
$tpw->setElements('h3');          // header/tab element: h2|h3|h4|h5
$tpw->setBehavior('responsive');  // responsive|tabpanel|accordion
$tpw->setTabStyle('pills');       // standard|fancy|pills|bar
$tpw->setTabOptions(['centered' => TRUE, 'rounded' => FALSE]);
$tpw->setAccordionOptions(['disconnected' => TRUE, 'animate' => TRUE]);

// $content is a render array (not a string).
$tpw->addItem('Overview', $overview_render_array, TRUE); // TRUE = default/open item
$tpw->addItem('Details',  $details_render_array);

return $tpw->build();
```

### Methods

| Method | Effect |
|---|---|
| `setElements(string $elements)` | Sets `options['elements']` (`h2`–`h5`), the header element for each item. |
| `setBehavior(string $behavior)` | `responsive` (tabs→accordion when they don't fit), `tabpanel` (always tabs), `accordion` (always accordion). |
| `setTabStyle(string $tab_style)` | `standard` / `fancy` / `pills` / `bar` (ignored in forced-accordion mode). |
| `setTabOptions(array $tab_options)` | Keys `centered`, `rounded`; run through `normalizeOptions()` → coerced to strict booleans. |
| `setAccordionOptions(array $accordion_options)` | Keys `disconnected`, `icons_at_the_end`, `chevrons_east_south`, `plus_minus`, `animate`; coerced to booleans. |
| `addItem(string $title, array $content, bool $default = FALSE)` | Appends a `TpwItem`; `$content` **must be a render array**. |
| `getItems()` / `getOptions()` | Accessors. |
| `reset()` | Reloads options from config and empties items (use when reusing an instance). |

## What `build()` produces

`build()` returns:

```php
[
  '#attributes' => ['class' => ['tpw-wrapper']],
  'widget' => [
    '#theme' => 'tpw',
    '#attributes' => ['class' => ['tpw-widget', ...]],
    '#items' => [ ['#markup' => <rendered item html>], ... ],
    '#attached' => ['library' => ['tabpanelwidget/tabpanelwidget.default', ...]],
  ],
]
```

CSS classes are appended from config, all **hard-coded literals** (no user string is injected as a
class):

- Forced mode: `tpw-tabpanel` (behavior `tabpanel`) or `tpw-accordion` (behavior `accordion`).
- Tab styling (unless behavior is `accordion`): `tpw-fancy` / `tpw-pills` / `tpw-bar`, plus
  `tpw-centered`, `tpw-rounded` from tab options.
- Accordion styling (unless behavior is `tabpanel`): `tpw-disconnected`, `tpw-icons-at-the-end`,
  `tpw-chevrons-east-south`, `tpw-plus-minus`, `tpw-animate` from accordion options.

Each item is rendered eagerly: `foreach getItems()` → `$item->build($options['elements'])` →
`renderer->render()` → stored as `#markup`. The `tabpanelwidget/tabpanelwidget.default` library is
always attached; `tabpanelwidget/tabpanelwidget.polyfill` is attached when the `polyfill` setting is
on.

## `TpwItem`

- `setTitle(string $title)` → `Html::decodeEntities($title)` then strips HTML comments
  (`preg_replace('/<!--(.|\s)*?-->/', '', …)`, to drop Twig-debug comments). Stored as the title.
- `setContent(array $content)` → stores a render array. `setDefault(bool)` marks the open item.
- `build(string $element = 'h2')` returns
  `['#theme' => 'tpw_item', '#element' => $element, '#attributes' => [...], '#title' => ['#markup' => $title], '#content' => $content]`,
  adding class `tpw-selected` when this is the default item.

The title is placed as `#markup`, so at render Drupal applies `Xss::filterAdmin()` to it; the
content is a passed-through render array rendered by the normal pipeline, so field/entity access is
enforced by whatever built that content.

## Theme hooks & templates

`tabpanelwidget_theme()` defines:

- `tpw` — variables `attributes`, `items`. `templates/tpw.html.twig`: `<div {{ attributes }}>` then
  `{% for item in items %}{{ item }}{% endfor %}`.
- `tpw_item` — variables `element` (default `h2`), `attributes`, `title`, `content`.
  `templates/tpw-item.html.twig`: `<{{ element }}{{ attributes }}>{{ title }}</{{ element }}>` then
  `{{ content }}`.

Override either template in your theme to change the per-item markup.

## Libraries (`tabpanelwidget.libraries.yml`)

- `tabpanelwidget.global` — `/libraries/tabpanelwidget/dist/tabpanelwidget.min.js` +
  `js/tabpanelwidget_autoinstall.js` (calls `Tabpanelwidget.autoinstall()`).
- `tabpanelwidget.default` — the min.css (theme) and depends on `.global`. Attached by every
  `build()`.
- `tabpanelwidget.polyfill` — `js/tabpanelwidget_polyfill.js`; injects a ResizeObserver polyfill for
  IE10/11 and older browsers. Only attached when the `polyfill` setting is enabled.
