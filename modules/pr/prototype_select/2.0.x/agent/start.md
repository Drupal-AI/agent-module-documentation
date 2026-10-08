<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prototype Select — agent start

Enhances native HTML `<select>` elements with an **accessible combobox** (multi-select), a
**search/filter box** for long lists, and selected-value **chips**, while the native select stays the
form-value source — selected values, `disabled`/`required` validation, reset, and bubbling `change`
events are preserved. Version **2.0.3** (dir `2.0.x`). Core `^11 || ^12`. No module dependencies, no PHP
constraint, no bundled external library. Package: Prototype.

**Accessibility-positive** front-end UI — enhances form select widgets; **no content model, entity, or
access role**. All behavior is client-side: a Drupal behavior (`Drupal.behaviors.prototypeSelect`) matches
selects by a configurable CSS selector and instantiates the module's own `PrototypeSelect` class (native
`<dialog>` popup with collision-aware flip placement, logical-property offsets, CSS custom props).

## How it wires up

- `hook_preprocess_select` adds the `data-prototype-select` attribute to selects and attaches the
  `prototype_select/prototype_select` library — only when enabled for the active theme (see `prototype_select_include`).
- `hook_page_attachments_alter` publishes all settings (selector, exclude selector, options, text strings)
  into `drupalSettings.prototype_select`; the JS reads them and applies per-select `data-prototype-select-*`
  overrides.
- Enablement gate is theme-based (`ThemeOptions::isThemeEnabled()`): everywhere / admin-theme-only / default-theme-only.

## Surface

- **One route / config form** — `/admin/config/user-interface/prototype_select`
  (route `prototype_select.admin`, `_permission: 'administer site configuration'`), plus a menu link
  under *System → User interface*. Full settings + per-select data-attribute API + JS API →
  [configure/prototype_select.md](configure/prototype_select.md)
- **Config**: single config object `prototype_select.settings` (typed schema provided). No permissions
  of its own, no Drush, no plugin types, no hooks for others to implement.
- **Upgrade from 1.x**: run DB updates — `prototype_select_update_20001()` rewrites configured
  `[data-select-a11y]` selector tokens to `[data-prototype-select]`, adds the missing `exclude_selector`
  default, and clears stale `disabled_themes` config. The old `select-a11y.js` library, `data-select-a11y`
  attribute, and `c-select-a11y__*` classes are gone; retheme to `c-prototype-select__*` /
  `data-prototype-select-*`.
