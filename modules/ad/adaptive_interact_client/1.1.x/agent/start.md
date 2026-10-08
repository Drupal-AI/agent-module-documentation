<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Interact client (adaptive_interact_client) — agent index

Drupal client for the hosted **Adaptive Interact** conversational AI search/chat platform. It renders a
widget container `<div>` and attaches an **external JavaScript loader** fetched from the admin-configured
Interact server (default `https://interact.adaptive.co.uk`); the remote script boots the chat widget in the
browser. The module itself makes **no server-side HTTP calls** and runs no AI. Package *Adaptive Interact*.
Core `^10 || ^11 || ^12`, PHP `>=8.1`, GPL-2.0-or-later. Version 1.1.4 (dir 1.1.x).

Dependencies: **none** beyond Drupal core (no contrib deps, no submodules, no Drush, no permissions of its
own, no config schema).

## What it provides (from source)

- **Block plugin** `adaptive_interact_client_chat_block` — `InteractWidgetBlock`
  (`src/Plugin/Block/InteractWidgetBlock.php`), admin label *"Interact Chat Block"*, category
  *Adaptive Interact*. Per-instance settings: widget_id, prompt, input_prompt_text, button_type,
  button_text, display_type.
- **Theme hook / render element** `adaptive_interact_client__widget` (registered in
  `adaptive_interact_client_theme()`), template `templates/adaptive-interact-client--widget.html.twig`.
  Variables `id` and `data` (a JSON string). Used by the block and available directly as `#type`.
- **Settings form** `SettingsForm` (`src/Form/SettingsForm.php`, form id
  `adaptive_interact_client_settings`) writing config object **`adaptive_interact_client.settings`**
  (`server_url`, `widget_id`, `avatar_field`).
- **Route** `adaptive_interact_client.settings` → `/admin/config/system/adaptive-interact-client`,
  permission `administer site configuration`; menu link under *Configuration → System*.
- **Dynamic library** `adaptive_interact_client/widget` — there is **no `.libraries.yml`**; the library is
  fabricated in `hook_library_info_alter()`, pointing its external JS at
  `{server_url}/interact-chat/widget-loader?v={Y-m-d-G}`.
- **Hooks & helper**: `hook_theme`, `hook_library_info_alter`, and `_adaptive_interact_client_get_avatar()`
  in `adaptive_interact_client.module`.

## Solution docs

- Settings form, the `adaptive_interact_client.settings` config object, the route, and the external
  widget-loader library mechanism → [config/settings.md](config/settings.md)
- The Interact Chat block, the `adaptive_interact_client__widget` render element, the Twig template, the
  avatar helper, and programmatic/Twig embedding → [blocks/interact-widget.md](blocks/interact-widget.md)
