<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `book_tree` theme hook and template override

`book_tree_menu.module` implements `hook_theme()`:

```php
function book_tree_menu_theme() {
  return [
    'book_tree' => [
      'template' => 'book-tree',
    ],
  ];
}
```

This re-declares the **`book_tree`** theme hook (also defined by core Book) and points it at this
module's `templates/book-tree.html.twig`, so the module's template replaces core Book's
`book-tree.html.twig` when the book navigation tree is rendered.

## Template variables (same contract as core `book_tree`)

- `items` — nested list of book items; each item has `title`, `url` (a `\Drupal\Core\Url`), `below`
  (child items), `attributes`, and the booleans `is_expanded`, `is_collapsed`, `in_active_trail`.
- `attributes` — HTML attributes for the wrapping `<ul>`.

## What the override template renders

It defines a recursive Twig macro `book_links(items, attributes, menu_level, classes)` (calling itself
for each `below`) and builds a nested `<ul>`/`<li>` menu with Bootstrap-flavored classes:

- Top-level `<ul>` gets `classes`; nested `<ul>`s get `dropdown-menu`.
- An `<li>` gets `expanded` when `is_expanded and below`, `dropdown` at the top level when it has
  children or `is_collapsed`, and `active open` when `in_active_trail`.
- A top-level item that has children renders its label as
  `<a class="dropdown-toggle" data-toggle="dropdown">…​ <span class="caret"></span></a>` — a toggle
  affordance rather than a plain link, matching the module's goal of expanding a submenu without
  navigating to the parent page. Leaf/other items render with Twig's `link(item.title, item.url)`.

Output is built through `Url`/`link()` and `Attribute` objects with normal Twig autoescaping — titles
come from `bookLinkTranslate()` (the node label), not from raw user input in the template.

## Re-theming in your own theme

- To restyle without changing markup, target the emitted classes (`dropdown`, `dropdown-menu`,
  `dropdown-toggle`, `caret`, `expanded`, `active open`) or supply the Bootstrap JS behavior your theme
  expects for `data-toggle="dropdown"`.
- To change the markup, override the `book_tree` theme hook again from your theme (copy the module's
  `book-tree.html.twig` into your theme's `templates/`), or provide a `book-tree--…​` template
  suggestion. A template defined by a theme wins over this module's module-level template.
- The default class list passed to the top-level `<ul>` is whatever core Book supplies as `classes`;
  a commented example in the template shows `['menu', 'nav', 'osc-sidebar-menu']`.
