<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Placeholder (dynamic_placeholder) — agent index

Dependency-free Drupal 10/11 UI module that rotates the `placeholder` text of one CSS-targeted text input through an admin-configured list. Pure config + client-side JS; no entities, fields, plugins, services, permissions, or config schema of its own.

## What it provides
- **Config object:** `dynamic_placeholder.settings` (site-wide, simple config; no `config/install` default and **no `config/schema`** shipped — keys are written by the settings form only).
- **Settings form:** `Drupal\dynamic_placeholder\Form\DynamicPlaceholderSettingsForm` (extends `ConfigFormBase`, form id `dynamic_placeholder_settings_form`).
- **Route:** `dynamic_placeholder.settings` → `/admin/config/user-interface/dynamic-placeholder`, requirement `_permission: 'administer site configuration'` (a core permission — the module defines none).
- **Menu link:** `dynamic_placeholder.settings` under `system.admin_config_ui`.
- **Hook:** `dynamic_placeholder_page_attachments()` in `dynamic_placeholder.module` — attaches the library + `drupalSettings.dynamicPlaceholder` when enabled and configured; adds cache tag `config:dynamic_placeholder.settings`.
- **Library:** `dynamic_placeholder/dynamic_placeholder` (`js/dynamic-placeholder.js`, `css/dynamic-placeholder.css`; depends on `core/drupal`, `core/drupalSettings`, `core/once`).
- **Behavior:** `Drupal.behaviors.dynamicPlaceholder` — rotates `input.placeholder` via `setInterval`; stops while the field has a value or is focused (if pause-on-focus), resumes on clear/blur.

## Dependencies
Core only (`drupal/core: ^10 || ^11`). No contrib deps, no external JS libraries, no Drush commands.

## Solution docs
- [Configuration & operation](config/settings.md) — every config key, form fields/validation, the page-attachment hook, the JS runtime, and how to target an input.
