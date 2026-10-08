<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DXP Assistant (dxp_assistant) — agent index

Loads a remote DXP (Digital Experience Platform) assistant script into site pages. Version **1.0.0-alpha1** (pre-release; minimally maintained, WIP). Core `^10.4 || ^11`. Package `DXP`. No module or Composer dependencies. Not security-advisory covered.

**What it actually does (this release):** `dxp_assistant_page_attachments()` in `dxp_assistant.module` injects a `<script src="{script_url}">` tag into the HTML head via `hook_page_attachments()`, only when the current user has permission `access dxp assistant` and the admin-configured `script_url` passes `UrlHelper::isValid()`. That is the whole runtime surface.

**Not present despite the project blurb "provides its endpoints and information":** no controllers, no `*.routing.yml` data/HTTP endpoints (only the config-form route below), no `*.services.yml`, no `*.libraries.yml`, no `drupalSettings`, and no API key / token / credential handling. The assistant JS comes from a remote, admin-entered URL.

## Config
- Config object: `dxp_assistant.configuration`, single key `script_url` (plain string). Schema: `config/schema/dxp_assistant.schema.yml`.

## Routes
- `dxp_assistant.configuration` → `/admin/config/user-interface/dxp-assistant`, form `Drupal\dxp_assistant\Form\DxpAssistantConfigurationForm`, requires `_permission: administer dxp assistant`. Menu link in `dxp_assistant.links.menu.yml` under `system.admin_config_ui`.

## Permissions (dxp_assistant.permissions.yml)
- `access dxp assistant` — gates whether the assistant script is loaded for the current user.
- `administer dxp assistant` — gates access to the configuration form.

## Solution docs
- [config/settings.md](config/settings.md) — the settings form, config object, schema, route, admin permission.
- [behavior/script-injection.md](behavior/script-injection.md) — the `hook_page_attachments()` script-loading mechanism, `access` permission gating, caching, and what is (not) exposed.
