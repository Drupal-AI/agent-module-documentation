<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Jump menu block, widget additions and JS

## Install & enable

```bash
drush en advanced_header_field_navigation -y
```

Ships inside the `advanced_header_field` project (enable that first — it is the declared
dependency). No composer entry of its own.

## Editor workflow

1. On any Advanced Header Field value, open **Header Options** and tick **Show in Jump Menu**
   (add a **Short Title** if the heading text is too long for a menu label).
2. Place the **Advanced Header Field Jump Menu** block (category *Navigation*) somewhere on the same
   page via *Structure → Block layout*.
3. On render, the block outputs an empty `<nav id="jump-menu">` and its JS fills it with anchor
   links to the opted-in headings.

## Block plugin `ahf_navigation_jump_menu`

`src/Plugin/Block/JumpMenu.php` (`JumpMenu extends BlockBase`), admin label *Advanced Header Field
Jump Menu*, category *Navigation*. `build()` returns:

```php
[
  '#theme' => 'ahf_navigation_jump_menu',
  '#attached' => ['library' => ['advanced_header_field_navigation/jump-menu']],
];
```

No block configuration form. Template `templates/ahf-navigation-jump-menu.html.twig` renders
`<nav {{ attributes.addClass(base_class) }}></nav>`; `preprocessThemeAhfNavigationJumpMenu()` sets
`base_class = 'jump-menu'` and forces the element id to `jump-menu` (the JS looks up that exact id,
so do not change it).

## Widget additions (hook)

`AdvancedHeaderFieldNavigationHooks::fieldWidgetSingleElementFormAlter()` implements
`hook_field_widget_single_element_advanced_header_field_form_alter()`. It appends to the parent
widget's Header Options:

- `show_in_jump_menu` — checkbox (`options['show_in_jump_menu']`).
- `short_title` — textfield (`options['short_title']`), shown via `#states` only when the checkbox is
  ticked.

It also opens the Header Options details when either is set, and registers
`validateFormNavigationOptions()`, which writes `short_title` and `show_in_jump_menu` into the
value's `options` array (only when a heading title is present).

## Rendering bridge

These two options are consumed by the **parent** HTML formatter/preprocess, not by this submodule's
block. `AdvancedHeaderFieldHtmlFormatter::viewElement()` passes `#show_in_jump_menu` and
`#short_title`, and the parent's `preprocessThemeAdvancedHeaderField()` adds
`data-in-jump-menu="true"` and `data-short-title="…"` to the heading's `<header>` wrapper (whose
`id` is the anchor id). Parent docs:
[../../../../3.0.x/agent/fields/header-field.md](../../../../3.0.x/agent/fields/header-field.md)

## JavaScript `js/advanced-header-field-jump-menu.js`

On `DOMContentLoaded`:

- selects `document.querySelectorAll('header[data-in-jump-menu]')`; exits if none, or if
  `#jump-menu` is absent;
- derives list/item classes from the nav's class (`jump-menu__list`, `jump-menu__list-item`);
- for each header, finds its first `h2..h6`, creates an `<li><a>`; the link `href` is
  `#<header.id>` and the link text is `data-short-title` or the heading's trimmed `textContent`
  (set via `element.textContent`, not `innerHTML`);
- appends the assembled `<ul>` into `#jump-menu`.

Because the menu is built entirely client-side from the rendered DOM, only headings that are both
opted in and actually present on the page appear, and there are no extra server routes or queries.

## Service

`advanced_header_field_navigation.helper` → `AdvancedHeaderFieldNavigationHelper` only stores the
module logger channel; it exposes `getLogger()` and is not otherwise used by the block, hooks or JS.
