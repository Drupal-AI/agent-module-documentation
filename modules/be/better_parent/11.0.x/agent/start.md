<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Parent (better_parent) — agent index

Front-end-only enhancement: progressively enhances the core menu "Parent item" `<select>`
(`#edit-menu-menu-parent`) on the node add/edit form, turning the long flat dropdown into a
collapsible, browsable `<ul>` tree. Pure client-side JS/CSS attached via a single
`hook_form_alter()`; the underlying `<select>` still holds the value, so no menu data or core
behavior changes. Enabling the module is the entire setup — nothing to configure.

Trivial module: no config page (`configure` null), no routes, no services, no permissions, no
config schema, no plugin types, no Drush, no PHP API. Only one hook. Core `^10 || ^11`. No
`package`, no info.yml dependencies; the asset library depends only on core `jquery`.

- **How the enhancement is wired, the library, and the JS/DOM behavior** →
  [frontend/menu-parent-browser.md](frontend/menu-parent-browser.md)

## Key facts (real machine names)
- **Hook:** `better_parent_form_alter()` in `better_parent.module:15` — implements
  `hook_form_alter()` with NO form-id restriction. Appends `better_parent/better_parent` to
  `$form['scheduler_settings']['#attached']['library']` (it targets the `scheduler_settings`
  element key, autovivifying it if absent; `#attached` still bubbles up on render, so the library
  loads on rendered forms and the JS then no-ops unless the target select is present).
- **Library:** `better_parent/better_parent` (`better_parent.libraries.yml`) =
  `js/better_parent.menu.js` + `css/better_parent.css` (component), dependency `core/jquery`.
- **JS behavior (`js/better_parent.menu.js`):** finds `#edit-menu-menu-parent`; if present, inserts a
  `#better_parent_item_toggle` "(browse)"/"(select)" link that hides the native select and renders a
  nested `#better_parent_item` `<ul>` tree built from the option labels' leading dashes (core's
  indentation). Selecting a tree node writes the value back to the hidden `<select>`.
- **CSS/assets:** `css/better_parent.css` styles `#better_parent_item`;
  `images/menu-{leaf,collapsed,expanded}.gif` are the tree icons.
- No-ops when `#edit-menu-menu-parent` is not on the page. `data.json` boolean flags are all false;
  `configure` is null.
