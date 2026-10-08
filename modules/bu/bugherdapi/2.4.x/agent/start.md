<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bugherd API (bugherdapi) — agent index

Injects the **BugHerd feedback sidebar** (`sidebarv2.js`) onto front-end pages using a configured
BugHerd **project key**, and ships a server-side **PHP client** for the BugHerd REST API v2. Package
`Reporting`. **No module or composer dependencies** (core only). Core requirement `^11 || ^12`.
License GPL-2.0-or-later. Version 2.4.x.

- **Settings form, config object/schema, routes, permissions, the sidebar attach logic** →
  [config/settings.md](config/settings.md)
- **The `bugherdapi.client` REST API v2 service (methods, auth, errors)** →
  [api/client.md](api/client.md)

## What it actually is

- **No entities, no plugins.** Provides: 2 permissions, 1 config form/route, 1 config object, 1 JS
  library, 2 services, 2 hooks (via an attribute hook class), 1 exception class.
- **Services** (`bugherdapi.services.yml`):
  - `bugherdapi.manager` → `Manager\BugherdApiManager` — decides whether the sidebar loads on the
    current page and produces the `drupalSettings` payload.
  - `bugherdapi.client` → `Client\BugherdClient` — Guzzle wrapper for the BugHerd REST API v2.
  - Both are aliased to their class name for autowiring; plus `logger.channel.bugherdapi`.
- **Hooks** (`Hook\BugherdApiHooks`, attribute-based `#[Hook(...)]`):
  - `hook_page_attachments` — when `BugherdApiManager::pageApplies()` is TRUE, attaches
    `drupalSettings['bugherdapi'] = ['api_key' => <project_key>]` and the `bugherdapi/bugherdapi`
    library.
  - `hook_help` — short About text on `help.page.bugherdapi`.
- **JS** (`js/bugherdapi.js`): reads `drupalSettings.bugherdapi.api_key` and injects
  `//www.bugherd.com/sidebarv2.js?apikey=<project_key>`. The value passed here is the **public
  project key**, not the secret personal API key.

## Where the sidebar loads (from `BugherdApiManager::pageApplies()`)

1. If `project_key` is empty → don't load (and warn users with `administer bugherd`).
2. If the current user lacks the **`access bugherd`** permission → don't load.
3. If `disable_on_admin` is on and the route is an admin route → don't load.
4. Otherwise load. So: any role granted `access bugherd`, on non-admin (optionally) routes, once a
   project key is set.

## Config / routes / permissions

- Config object **`bugherdapi.settings`**: `project_key` (string), `api_key` (string, the secret
  REST key), `disable_on_admin` (bool). Schema in `config/schema/bugherdapi.schema.yml`.
- Route **`bugherdapi.bugherd_configuration_form`** → `/admin/config/system/bugherd`
  (`Form\BugherdConfigurationForm`), requirement **`administer bugherd`**, `_admin_route: TRUE`.
  Menu link under *Configuration → System*.
- Permissions (`bugherdapi.permissions.yml`): **`administer bugherd`** (`restrict access: TRUE`),
  **`access bugherd`** (who gets the on-page reporting sidebar).
