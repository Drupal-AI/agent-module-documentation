<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Theming: templates & libraries

## Templates (`templates/`)
- `cheeseburger-menu.html.twig` — theme hook `cheeseburger_menu`; variables include
  `#tree` (array of `CheeseburgerMenu` objects) and `#show_navigation`.
- `cheeseburger-menu-trigger.html.twig` — theme hook for the trigger button.

Override either by copying into your theme and adding a matching theme suggestion.

## Libraries (`cheeseburger_menu.libraries.yml`)
- `cheeseburger_menu.js` — `js/cheeseburger_menu.js`; depends on core `jquery`, `once`,
  `drupalSettings`, `drupal`. Attached when the block's `default_js` is TRUE.
- `cheeseburger_menu.css` — minified `css/cheeseburger_menu.css` (theme). Attached when
  `default_css` is TRUE.

## Styling without the default assets
Untick **Use default css** / **Use default js** on the menu block to suppress the module's
assets and style/behave the menu entirely from your theme. The color/opacity block settings
(left/right panel, trigger, scrollbar) are emitted as inline style values consumed by the
default CSS, so if you disable default CSS you own all presentation.

The module also color-styles via the per-block color settings rather than CSS files, so most
branding needs no template override — only structural changes do.
