<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chatlio (chatlio) — agent index

Integrates the third-party **Chatlio.com** live-chat widget (Slack-connected support chat).
An admin pastes the vendor JS embed code once; the module injects it into the bottom of every
page via `hook_page_bottom()`, gated by Drupal **condition plugins** (path/role/bundle/language).
Package `Chatlio`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.1.0. **No** entities,
permissions, Drush, or plugin types of its own; no external module dependencies.

- **Settings form, config object + schema, visibility conditions, tokens, install/enable** →
  [config/settings.md](config/settings.md)
- **Render pipeline, services, cache, and the JS behavior** →
  [api/services.md](api/services.md)

## What it actually is (from source)

- One config object **`chatlio.settings`** (schema in `config/schema/chatlio.schema.yml`, defaults
  in `config/install/chatlio.settings.yml`). Keys: `chatlio_enable`, `chatlio_enable_admin`,
  `chatlio_mobile`, `chatlio_code` (the pasted vendor snippet), `user_identify`, `show_user_name`,
  `user_name`, `show_user_email`, `user_email`, and `visibility` (a sequence of condition-plugin
  configs).
- One settings form **`ChatlioSettings`** (`src/Form/ChatlioSettings.php`, extends `ConfigFormBase`)
  at route **`chatlio.settings`** → `/admin/config/services/chatlio`, permission
  **`administer site configuration`**. Menu link under *Configuration → Web services*
  (`chatlio.links.menu.yml`).
- **`hook_page_bottom()`** (`chatlio.module`) calls `chatlio.embed_render` on every page.
- Three services (`chatlio.services.yml`):
  - `chatlio.embed_render` → `ChatlioEmbedRender` — builds the render array (or NULL).
  - `chatlio.condition_plugins_handler` → `ChatlioConditionPluginsHandler` — evaluates the
    visibility conditions (`ConditionAccessResolverTrait`, `and` logic).
  - `chatlio.cache_manager` → `ChatlioCacheManager` — aggregates cache tags/contexts.
- Library **`chatlio/integration`** (`chatlio.libraries.yml`) attaches `js/chatlio.js`
  (`Drupal.behaviors.chatlio`): hides the widget on mobile when configured and (attempts to) call
  `window._chatlio.identify(...)`.

## Consumes (does not provide) plugin types

- Core **condition plugins** only, restricted in the form to: `request_path`, `user_role`,
  `entity_bundle:node`, `entity_bundle:taxonomy_term`, and `language` (multilingual sites only).
