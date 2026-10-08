<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Call Now Button (call_now_button) — agent index

A floating, mobile-only **click-to-call (`tel:`) button** fixed to the bottom of the front-end. No
dependencies beyond Drupal core. Package `Other`. Core `^8 || ^9 || ^10 || ^11`. Version 1.0.2.
License GPL-2.0-or-later.

- **The settings form, config keys, permission, route, and the attach mechanism** →
  [config/settings.md](config/settings.md)

## What it actually is

- **One config form:** `CallNowButtonConfigForm` (`src/Form/CallNowButtonConfigForm.php`, extends
  `ConfigFormBase`), form id `call_now_button_config_form`, editing config object
  **`call_now_button.settings`**.
- **One route:** `call_now_button.settings_form` → `/admin/config/user-interface/call-now-button`,
  gated by permission **`administer call now button`** (`call_now_button.routing.yml`,
  `call_now_button.permissions.yml`). Menu link under *Configuration → User interface*
  (`call_now_button.links.menu.yml`).
- **One permission:** `administer call now button` — the only permission defined.
- **One template + one library:** theme hook `call_now_button_theme`
  (`templates/call-now-button-theme.html.twig`) and library `call_now_button/global-styling`
  (`css/call_now_button.css`, `js/call_now_button.js`; depends on core jQuery/drupal/drupalSettings/jquery.once).
- **No entities, no plugins, no services, no Drush, no config schema, no submodules, no external APIs.**

## Mechanism (from source, `call_now_button.module`)

- `hook_page_attachments()` returns early on admin routes (`router.admin_context->isAdminRoute()`).
  Otherwise, when config `call_now_button_status` is on, it renders the `call_now_button_theme` template
  (phone number, button text, position) to a string via `renderer->renderRoot()`, stores that string in
  `drupalSettings.call_now_button`, and attaches the `global-styling` library.
- `js/call_now_button.js` (`Drupal.behaviors.callNowButton`) reads `settings.call_now_button` and
  appends it into `<body>` (`$("body").once().append(...)`).
- Twig renders `<a href="tel:{{ phone_number }}">` plus an optional `{{ button_text }}` label; CSS keeps
  `.call-now-button-wrapper` `display:none` except under `@media (max-width:767px)`.
- `hook_help()` provides the module's help text; `hook_theme()` declares the template variables
  (`phone_number`, `button_text`, `button_color` [declared but unused], `position`).

## Config keys (`call_now_button.settings`)

`call_now_button_status` (checkbox), `call_now_button_phone_number` (numeric, required),
`call_now_button_text` (textfield label), `call_now_button_popup_position`
(`right_corner` | `left_corner` | `center_bottom` | `full_bottom`). Details in
[config/settings.md](config/settings.md).
