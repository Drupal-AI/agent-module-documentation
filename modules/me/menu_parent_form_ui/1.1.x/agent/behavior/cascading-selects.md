<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Parent Form UI — cascading parent selects (how it works)

Replaces core's single indented parent-menu `<select>` with cascading dropdowns. Entirely
client-side once the form renders; no AJAX/server round-trips while cascading.

![Cascading parent-menu selects on the menu link add form](../../../../../../../screenshots/menu_parent_form_ui/1.1.x/menu-link-add-cascading.png)

## Server side — `src/Hook/MenuParentFormUiHooks.php`

- `#[Hook('form_node_form_alter')]` → `formNodeFormAlter()` appends `nodeFormAfterBuild` to
  `$form['#after_build']`. In the after-build it only proceeds if the Menu settings section is
  accessible (`$form['menu']['#access']` is not FALSE / not `AccessResultForbidden`) and the parent
  element is a plain, non-disabled select; then calls `parseMenuTrail()` on
  `$form['menu']['link']['menu_parent']['#default_value']`.
- `#[Hook('form_menu_link_content_form_alter')]` → `formMenuLinkContentFormAlter()` calls
  `parseMenuTrail()` on `$form['menu_parent']['#default_value']` (when it is a string).
- `parseMenuTrail(&$form, $menu_parent)`: splits `"<menu_name>:<plugin_id>"`, and when a parent is
  set, builds the active trail with `MenuLinkManagerInterface::getParentIds()` (injected
  `plugin.manager.menu.link`), removing the selected item itself. It then:
  - `$form['#attached']['library'][] = 'menu_parent_form_ui/menu_parent_form_ui.base';`
  - `$form['#attached']['drupalSettings']['active_set'] = <trail>;`
  - attaches the two configured wrapper selectors (see
    [../config/settings.md](../config/settings.md)).

  Because the library is attached only inside `parseMenuTrail()`, the enhancement engages only when
  the parent element carries a string default value.

The `.module` file exposes `#[LegacyHook]` procedural wrappers that delegate to the autowired
service (`services.yml`, `skip_procedural_hook_scan: true`).

## Client side — `js/`

- `menu_parent_form_ui.js` — `Drupal.behaviors.menu_parent_form_ui`, guarded by `core/once`.
  Detects the form: if `drupalSettings.menu_link_content_form_wrapper_selector` exists it targets
  original select `#edit-menu-parent`; else if `node_form_wrapper_selector` exists it targets
  `#edit-menu-menu-parent`. Instantiates `SelectExtractor` with that original select, the wrapper
  container, and `drupalSettings.active_set`.
- `js/libs/select_extractor.js` — the `SelectExtractor` class (original by Jim Keller, 2018).
  - `select_options_extract()` reads the native `<select>` options and rebuilds the tree by counting
    the leading-dash prefix (`option_level_prefix` default `--`) via
    `select_option_determine_level_by_text()`. **This is the documented brittleness**: it depends on
    Drupal continuing to indent options with dashes.
  - `select_box_create()` renders one `<select>` per level into the wrapper (each with a
    `-Choose-`/`_none` empty option), pre-selecting entries in `active_set` / the current value.
  - On change (`select_handle_change` → `select_option_apply`), it removes deeper selects, spawns the
    child-level select, and `select_original_sync()` writes the deepest chosen value back into the
    hidden native select so the form submits the correct `menu_parent`.
  - The native select is visually hidden (`select_box_original_hide`); a "Currently Selected Parent"
    label is shown (`select_box_change_link_initialize`).

## Operating notes

- No configuration is needed for the default (Claro) admin theme. For other themes, set the wrapper
  selectors — [../config/settings.md](../config/settings.md).
- Applies to every node type that exposes Menu settings and to all menu-link add/edit forms; there
  is no per-bundle toggle.
- Nested menu items must exist for the cascade to have more than one level to show.
