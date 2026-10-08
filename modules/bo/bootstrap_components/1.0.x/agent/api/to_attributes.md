<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `to_attributes` Twig filter/function

The module's only PHP: `src/Twig/AttributesToolTwigExtension.php` (class `Drupal\bootstrap_components\Twig\AttributesToolTwigExtension`), registered as service `bootstrap_components.twig.attributes_tool` with tag `twig.extension` in `bootstrap_components.services.yml`. Method `toAttributes($value = NULL): Attribute` is exposed BOTH as a filter and a function named `to_attributes` (`getFilters()` / `getFunctions()`). It always returns a `Drupal\Core\Template\Attribute`.

## Normalization rules (in `toAttributes()`)
- `Attribute` instance → returned as-is.
- **string** → split on `/\s+/`, trimmed, empties dropped → `Attribute(['class' => [...]])` (empty `Attribute()` if blank).
- **sequential/list array** (`array_is_list`) → each element `strval`'d, empties dropped → class list `Attribute`.
- **associative array** → per key:
  - `class`: accepts an `Attribute` (kept), a string (split on whitespace) or an array → filtered `strval` class list.
  - any other key: only `NULL`/`FALSE` skipped; scalars and objects with `__toString` are cast to string; complex values (arrays/objects without `__toString`) are dropped.
- anything else (`NULL`, etc.) → empty `Attribute()`.

## Usage
```twig
<div{{ 'alpha beta'|to_attributes }}></div>                     {# class="alpha beta" #}
<div{{ ['alpha','beta']|to_attributes }}></div>                 {# class="alpha beta" #}
<div{{ { class: ['a','b'], id: 'x', 'data-role': 'dialog' }|to_attributes }}></div>
{% set attrs = to_attributes({ class: 'card' }) %}{{ attrs.addClass('shadow') }}
```
Because the result is a real `Attribute`, you can chain `.addClass()` / `.setAttribute()`. Used internally by templates (e.g. `modal.twig`, `alert.twig`) to pass a normalized `{ 'data-bs-dismiss': 'modal' }|to_attributes` into the included `close_button`. Output goes through Drupal's `Attribute` value escaping and normal Twig auto-escaping; there is no `|raw` path.
