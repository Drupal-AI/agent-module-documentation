<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Speedboxes (speedboxes) — agent index

Client-side UX helper that lets an admin tick/untick a run of checkboxes by dragging a rubber-band
selection rectangle over them. Version **2.0.1**, package **Administration**. Purely front-end: it
attaches one asset library (`speedboxes/speedboxes`) to exactly two admin forms — the core
**Permissions** form (`user_admin_permissions`) and the Group module's **group permissions** form
(`group_admin_permissions`) — via `hook_form_FORM_ID_alter`. The JS behavior `Drupal.behaviors.speedboxes`
binds `mousedown`/`mousemove`/`mouseup` on `<body>`, draws a selection box, collects the visible enabled
checkboxes inside it, and shows a small popup toolbar with **Check all / Uncheck all / Reverse selection**
that toggles those checkboxes in the DOM.

There is no server-side surface at all: no routes, no controllers, no services (only the OOP-hook flag
parameter `speedboxes.skip_procedural_hook_scan`), no permissions, no config, no plugins, no drush. The
selection and toggling happen entirely in the browser; the underlying form is still submitted through
Drupal's normal FAPI, which keeps its own access check and CSRF token. Toggling uses jQuery
`.attr('checked', …)`/`.removeAttr('checked')` on the matched inputs.

- Depends on: core only (`speedboxes.info.yml` declares no `dependencies:`; the library pulls `core/drupal`, `core/jquery`).
- Core: `^11.2 || ^12` (`core_version_requirement` in info.yml).
- Package: `Administration`.
- Settings page / configure route: **none**. Permissions: **none**. Drush: **none**. Plugin types: **none**. Config schema: **none**. Routes: **none** (only the `help.page.speedboxes` help text).
- No security surface: no server-side code path; the two enhanced forms enforce their own access and CSRF.

## What you'd do → where
Trivial module. Full integration detail: [agent/integration/attach-to-forms.md](integration/attach-to-forms.md).

- Where it activates: only the two permission grids. To make it apply elsewhere, add another
  `#[Hook('form_<FORM_ID>_alter')]` that attaches `speedboxes/speedboxes` (see `src/Hook/FormAlter.php`).
- Tune JS behavior: edit `js/speedboxes.js` — `Drupal.speedboxes.config` holds
  `ignore_elements: ['input','select']` and the three localized toolbar labels.
- Restyle the selection box / popup: `css/speedboxes.css`.

## Key facts (real machine names)
- **Library:** `speedboxes/speedboxes` (`speedboxes.libraries.yml`) — `css/speedboxes.css`, `js/speedboxes.js`; deps `core/drupal`, `core/jquery`.
- **Hooks (OOP, attribute-based):**
  - `src/Hook/FormAlter.php` → `#[Hook('form_user_admin_permissions_alter')]` and `#[Hook('form_group_admin_permissions_alter')]`; both do `$form['#attached']['library'][] = 'speedboxes/speedboxes';`.
  - `src/Hook/Help.php` → `#[Hook('help')]`, case `help.page.speedboxes`.
- **Services file:** `speedboxes.services.yml` defines no services — only the parameter `speedboxes.skip_procedural_hook_scan: true`.
- **JS namespace:** `Drupal.behaviors.speedboxes` (attach) and the `Drupal.speedboxes.*` helpers (`createSelectionContainer`, `createEditingPopup`, `getSelectionRectangle`, `updateSelectedCheckboxes`, `updateEditingPopup`, `performAction`). Config: `Drupal.speedboxes.config.ignore_elements`, `Drupal.speedboxes.config.localization.{check_all,uncheck_all,reverse}`.
- **Toolbar actions (data attr `speedboxes-action`):** `check_all`, `uncheck_all`, `reverse`.
- **CSS classes:** `speedboxes-selection`, `speedboxes-selected`, `speedboxes-popup`, `speedboxes-action`, `speedboxes-action-check-all`, `speedboxes-action-uncheck-all`, `speedboxes-action-reverse`, `speedboxes-active-action`.
- **Checkbox targeting:** JS selects `input:checkbox:enabled:visible` whose offset falls inside the drag rectangle.
