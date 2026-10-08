<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `collapsible` render element

## Install & enable

```bash
composer require drupal/fapi_collapsible
drush en fapi_collapsible -y
```

Core-only; no dependencies, no permissions, no config, no admin page. Once enabled, the
`collapsible` render element is available to any module or theme.

## Minimal usage

```php
$form['author'] = [
  '#type' => 'collapsible',
  '#title' => $this->t('Author'),
];
$form['author']['name'] = [
  '#type' => 'textfield',
  '#title' => $this->t('Name'),
];
```

Child elements nested under the collapsible become its `#children` and render inside the
collapsible body. It works in any render array, not just forms.

## The element class

`Drupal\fapi_collapsible\Element\Collapsible` (`src/Element/Collapsible.php`), plugin id
`collapsible` (`@RenderElement("collapsible")`), **extends core `Fieldset`**. `getInfo()` starts from
`Fieldset::getInfo()` and adds:

| Property | Default | Set by `getInfo()` | Meaning |
|---|---|---|---|
| `#theme_wrappers` | `['collapsible']` | yes | Wraps output with the `collapsible` theme hook. |
| `#process[]` | `+ processCollapsible` | yes | Adds the process callback below (on top of Fieldset's). |
| `#expanded` | `FALSE` | yes | Start open (`TRUE`) or collapsed (`FALSE`). |
| `#name` | `'field'` | yes | Region name → drives `collapsible-<name>-*` CSS classes and ids. |
| `#id_collapsible` | `''` | yes | DOM id fragment for the content region (template supplies a random fallback if empty). |
| `#description` | `''` | yes | Optional description shown above `#children`. |
| `#description_attributes` | `[]` | yes | Attributes for the description wrapper (cast to `Attribute`). |
| `#title` | (from Fieldset) | inherited | Header text, rendered inside the toggle button. |

`processCollapsible(&$element, FormStateInterface $form_state, &$complete_form)` does one thing:
`$element['#attached']['library'][] = 'fapi_collapsible/collapsible';` and returns the element. There
is **no `#pre_render`** added by this module and **no `Markup::create()` / `#markup`** built from any
value — inherited Fieldset behavior aside, the element only carries the developer's own render arrays.

## Theming (`hook_theme` + preprocess)

`fapi_collapsible_theme()` (`.module`) registers:

```php
'collapsible' => ['render element' => 'element'],
```

`fapi_collapsible_preprocess_collapsible(&$variables)` maps element properties into template
variables and derives `close`:

| Variable | Source |
|---|---|
| `children` | `$element['#children']` |
| `name` | `$element['#name']` |
| `title` | `$element['#title']` |
| `id_collapsible` | `$element['#id_collapsible']` |
| `expanded` | `$element['#expanded']` |
| `close` | `!$element['#expanded']` |
| `description.content` | `$element['#description']` |
| `description.attributes` | `new Attribute($element['#description_attributes'])` |

## Template (`templates/collapsible.html.twig`)

Structure produced:

- Outer `<div data-collapsible-close="{{ close|default('true') }}">` with classes
  `js-collapsible`, `collapsible-<name>`, and `is-expanded` when `expanded`.
- A toggle `<button type="button" class="js-collapsible-cta collapsible-<name>-cta"
  aria-controls="collapsible-<name>-<id_collapsible>" aria-expanded="{{ expanded|default('false') }}">`
  containing `{{ title }}` — accessible expand/collapse control.
- A content region `<div id="collapsible-<name>-<id_collapsible>"
  class="js-collapsible-content collapsible-<name>-content">` holding an inner wrapper with the
  optional `{{ description.content }}` (class `description`) and then `{{ children }}`.
- `name` defaults to `'demo'`; `id_collapsible` defaults to `now|date('su') ~ random(range(0,999))`
  when empty, so pass `#id_collapsible` when you need a stable, predictable id.
- All dynamic values (`title`, `children`, `description.content`, attributes) are emitted through Twig
  auto-escaping / `Attribute` — the template uses **no `|raw`**.

Override the markup by copying `collapsible.html.twig` into your theme's `templates/` directory.

## Behavior (`js/collapsible.js`, library `fapi_collapsible/collapsible`)

`Drupal.behaviors.collapsible` (attached by `processCollapsible`; library deps `core/jquery`,
`core/jquery.once`, `core/drupal`) binds once to `body`:

- Click on `.js-collapsible-cta` toggles the closest `.js-collapsible`: flips the button's
  `aria-expanded`, toggles the `is-expanded` class, and triggers a `collapsible-open` or
  `collapsible-close` jQuery event on the element.
- **Accordion groups**: if the wrapper has `data-collapsible-rel="<group>"`, opening one collapsible
  first closes every other `is-expanded` element sharing that `rel`. (You add this attribute yourself,
  e.g. via `#attributes` — the element does not set it.)
- **Outside-click auto-close**: on any `click`/`focusin` outside an open collapsible, elements whose
  `data-collapsible-close === 'true'` are closed. `data-collapsible-close` comes from the `close`
  variable (`!#expanded`), so a collapsed-by-default element auto-closes; pass `#expanded => TRUE`
  (or override the attribute) to keep it open.

## Notes / gotchas

- No config schema and no admin form — nothing to export; behavior is entirely per-element via
  properties and the two `data-*` attributes.
- `#name` is not sanitized into a machine name; keep it CSS/attribute-safe (it becomes part of class
  names, ids and an `aria-controls` value).
- The library still lists the deprecated `core/jquery.once` dependency, and the JS calls the global
  `once()` helper — functional on Drupal 9–11 but relies on core's compatibility shim.
- Pass a unique `#id_collapsible` per element on a page; the random fallback can collide and it
  changes between requests (breaks stable JS/CSS targeting).
