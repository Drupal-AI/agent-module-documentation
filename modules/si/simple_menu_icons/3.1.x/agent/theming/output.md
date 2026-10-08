<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How icons are rendered (generated CSS + classes)

Simple Menu Icons paints icons purely with CSS — it adds no markup to menu templates.

## Per-item classes

`hook_preprocess_menu()` (`simple_menu_icons_preprocess_menu`) adds two classes to every menu
item (recursively, so submenus work), keyed by the menu link's entity id (`mlid`):

- `menu-icon`
- `menu-icon-<mlid>`

These are added to all items that resolve to a `menu_link_content` entity, whether or not an
icon is set — so you can also target them for custom styling.

## The generated CSS file

`simple_menu_icons_css_generate()` builds the stylesheet from the
`simple_menu_icons_css_item` theme hook (template
`templates/simple-menu-icons-css-item.html.twig`). For each menu link that has a loadable
`menu_icon.fid`, it emits a rule like:

```css
a.menu-icon-<mlid>,
ul.links li.menu-icon-<mlid> a,
ul.menu li.menu-icon-<mlid> a {
  background-image: url(<file url>);
  padding-left: <icon width>px;   /* icon's real pixel width */
  background-repeat: no-repeat;
  background-position: left center;
}
```

The file is written to `public://simple_menu_icons_css/menu_icons_<suffix>.css`, where
`<suffix>` is a `time()` timestamp saved in **State** key `simple_menu_icons_css_suffix`
(older file is deleted first). If no links have icons, the file is removed.

## Getting the file onto the page

`hook_css_alter()` (`simple_menu_icons_css_alter`) looks up the State suffix, and if the
generated file exists, adds it to the page's CSS (aggregatable, weight `CSS_COMPONENT`).

## Regeneration triggers

- Saving a menu link via the icon form (`simple_menu_icons_menu_link_content_form_submit`).
- `hook_rebuild()` (`simple_menu_icons_rebuild`) — e.g. on a full cache rebuild — so icons
  survive `drush cr`.
- Calling `simple_menu_icons_css_generate()` directly from code.

## Theme hook

```php
// simple_menu_icons_theme()
'simple_menu_icons_css_item' => [
  'variables' => ['icons' => NULL],   // array of ['mlid','path','width']
  'template' => 'simple-menu-icons-css-item',
];
```

Override the template in your theme to change the generated CSS rules.
