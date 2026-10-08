<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin: accessibility_block (AccessibilityTools)

File: `src/Plugin/Block/AccessibilityTools.php`. Class `AccessibilityTools extends BlockBase`.
Annotation `@Block(id = "accessibility_block", admin_label = "Accessibility Tools Block")`.
No custom `blockAccess()` — inherits BlockBase, so placement/config is gated by core's
`administer blocks` permission and normal block visibility conditions.

## Install / place
1. Enable: `drush en accessibility_block` (no dependencies).
2. Structure → Block layout → place "Accessibility Tools Block" in a region.
3. Configure the instance (see below), save.

## Configuration form (`blockForm` / `blockSubmit`)
Stored on the block instance `configuration` array (no separate config entity, no config schema
shipped). Keys and form elements:

| Config key | Form element | Title | Meaning |
|---|---|---|---|
| `dark_mode` | checkbox | "Disable Dark Mode" | when TRUE, the Dark Mode group is hidden |
| `font_resize` | checkbox | "Disable Font Resize" | when TRUE, the Font Resize group is hidden |
| `accessibility_small` | number | "Small Font Size" | px value for the Small button |
| `accessibility_medium` | number | "Medium Font Size" | px value for the Medium button |
| `accessibility_large` | number | "Large Font Size" | px value for the Large button |
| `accessibility_very_big` | number | "X-Large Font Size" | px value for the X-Large button |

Note the checkboxes are worded as *Disable* toggles: unchecked (FALSE) = the group is shown. The
number `#default_value` falls back to `FALSE` when unset. `blockSubmit` copies each `$values[...]`
straight into `$this->configuration[...]`.

## build()
Returns a render array with:
- `#theme => 'accessibility_block'` and the six config values plus `#module_path`
  (`extension.list.module`→`getPath('accessibility_block')`) as theme variables.
- `#attached.library => ['accessibility_block/accessibility']`.
- `#attached.drupalSettings.accessibility` carrying the four pixel sizes
  (`accessibility_small`/`_medium`/`_large`/`_very_big`) for the JS to read.

The `dark_mode` / `font_resize` booleans reach the template but are NOT put in drupalSettings.

## Theme + template
`accessibility_block_theme()` (`accessibility_block.module`) registers the `accessibility_block`
hook with those seven variables; template `templates/accessibility-block.html.twig`. The template:
- renders a launcher `.acc-tools-click` (icon `{{ module_path }}/assets/images/accessibility.svg`)
  and an overlay `.acc-tools` with a close button;
- shows the Dark Mode group (`.colored-click`, `.greyscale-click`) only `{% if not dark_mode %}`;
- shows the Font Resize group only `{% if not font_resize %}`, with four links carrying
  `targetfor="accessibility_small|_medium|_large|_very_large"`.
- All labels run through Twig `|t`. All `img src` values are the module path (system-derived), not
  config, so nothing user/remote is interpolated into markup.

## Client behavior (`assets/js/main.js`)
`Drupal.behaviors.accessibility_block`:
- Launcher click adds `.active` to `.acc-tools`; close button / outside click removes it.
- Grayscale: click sets `localStorage.appearance = "greyscale"` and toggles the `greyscale` class
  on `document.documentElement`; Colored click reverses it. On attach it restores from
  `localStorage.getItem("appearance")`.
- Font resize: `changeSize(Size)` reads the matching px number from
  `drupalSettings.accessibility.*`, `.concat("px")`, and assigns it to `document.body.style.fontSize`
  and to every `<p>`; it also adds the size id as a class on `<html>`. The chosen `targetfor` is
  saved in `localStorage.FontSize` and restored on attach.
- Note: the X-Large link's id/targetfor is `accessibility_very_large`, matched in JS, but the
  drupalSettings key it reads is `accessibility_very_big` — the mapping is handled inside
  `changeSize`.

## Operate / theme integration
There is nothing server-side to tune beyond the six block-config values. To actually restyle the
page for grayscale or a given size, target the classes the JS sets on `<html>` (`greyscale`,
`accessibility_small`, etc.) or the inline `font-size` it writes, from your theme CSS. Restyle the
widget itself by overriding `assets/css/style.css` or the Twig template.
