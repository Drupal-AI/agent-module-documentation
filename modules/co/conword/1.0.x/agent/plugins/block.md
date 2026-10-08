<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conword — language-picker block & UI

## `ConwordBlock` (`src/Plugin/Block/ConwordBlock.php`)

- `#[Block(id: "conword", admin_label: "Conword")]`, extends `BlockBase` implements
  `ContainerFactoryPluginInterface`; `create()` injects `config.factory`.
- **This is an optional replacement for the vendor's built-in language switcher.** Place it in a
  region to render the module's own popover language picker.
- `build()` — returns a render array `#theme => 'conword'`, attaches library `conword/conword_ui`,
  and sets `#cache.tags` = `conword.settings` config cache tags.
- `access(AccountInterface $account)` — reads `conword.settings:conwordConfig.disable_language_switcher`.
  Returns `AccessResult::allowed()` only when that flag is TRUE, otherwise `AccessResult::forbidden()`.
  So the block only appears when you have disabled Conword's default switcher. **Note:** this access
  gate ignores `$account` — it is a config-driven on/off, not a per-user permission; the block itself
  carries no permission of its own (standard core "administer blocks" governs placing it).

## Template `templates/conword.html.twig`

Renders an accessible popover: a trigger button (`aria-label` "Translation selection",
`popovertarget="conword__modal"`), a `popover` modal with a close button, a headline
"Select language", an empty `<ul class="conword__languages">` populated by JS, and a standing notice
"Automatic translation, no guarantee of accuracy." All visible strings pass through `|t`. Only inline
SVG icons and static markup — no dynamic/user data is printed by the template.

## JS behavior

- `js/conword.js` (library `conword`) — copies `drupalSettings.conword.conwordConfig` to
  `window.conword_config` for the vendor script.
- `js/conword_ui.js` (library `conword_ui`, depends on `conword/conword`) — on `DOMContentLoaded`
  calls the **vendor** global `Conword.get_available_languages()` and `Conword.get_current_language()`
  to build the `<li>` list, and on a language button click calls `Conword.translate(langCode)` then
  hides the popover and re-renders. The language names/codes come from the vendor's own JS API (not
  from Drupal-side user input). Requires the external Conword script (added by
  `hook_library_info_alter`) to have loaded and defined the `Conword` global.
- `js/conword.admin.js` (library `conword.admin`) — `Drupal.behaviors.conwordSettingsSummary`
  provides vertical-tab summaries for the visibility conditions on the settings form only.

## CSS

`css/conword.css` (theme group, via `conword_ui`) styles the picker/popover.
