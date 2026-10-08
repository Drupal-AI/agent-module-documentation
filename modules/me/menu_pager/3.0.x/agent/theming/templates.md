<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: template, theme hook, CSS

## Theme hook
Declared in `menu_pager.module` via `hook_theme()`:
```
'menu_pager' => [
  'variables' => ['previous' => NULL, 'next' => NULL],
]
```
`previous` and `next` are render arrays (renderable `Link` elements) or an empty string when a side
has no neighbour.

## Template — `templates/menu-pager.html.twig`
```
<ul class="item-list">
  {% if previous %}
  <li class="menu-pager-previous">{{ previous }}</li>
  {% endif %}
  {% if next %}
  <li class="menu-pager-next"> {{ next }}</li>
  {% endif %}
</ul>
```
`{{ previous }}` / `{{ next }}` render the `Link` render arrays; Twig autoescaping plus the
render pipeline handle output — the link title (a plain-text menu title or the configured label) is
escaped, not treated as markup. Override this template in a theme to change the wrapper markup.

## CSS library — `menu_pager.libraries.yml`
```
menu_pager:
  version: 1.x
  css:
    theme:
      css/menu_pager.css: {}
```
Attached by the block via `#attached => ['library' => ['menu_pager/menu_pager']]`.
`css/menu_pager.css` removes list styling and floats `.menu-pager-previous` left and
`.menu-pager-next` right (the block wrapper carries the `clearfix` class).

## Wrapper classes
The block render array sets `#attributes => ['class' => ['menu-pager', 'clearfix']]`. Note the outer
`.menu-pager` wrapper is applied by the block system to the block, while the template itself emits
the inner `<ul class="item-list">`; CSS selectors are written as `.menu-pager .menu-pager-previous`
etc.
