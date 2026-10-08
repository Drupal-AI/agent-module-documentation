<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client Support (client_support) — agent index

An **extensible support-access feature** for Drupal 10/11. The base module itself provides **no
form and sends no email** — it adds a **"Support" item to the admin toolbar** and a route
(`/client-support`) that **redirects** to whatever destination a selected *SupportIntegration*
plugin returns. You pick the active plugin on a settings form. A separate submodule,
**`client_support_contact_form`**, supplies a ready-made plugin that redirects to a core Contact
Form. Package `Support`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed version **1.0.1**
(version dir `1.0.x`).

Out of the box the toolbar item is **hidden** until (a) at least one SupportIntegration plugin
exists and (b) a plugin has been selected on the settings form and (c) the user has the
`access client support` permission. With only the base module enabled and no custom plugin, nothing
shows — you enable the submodule or write your own plugin.

## What it provides (from source)

- **Toolbar item** `client_support` (`client_support.module` → `Handler/ToolbarHandler`): a
  right-floated question-mark "Support" tab linking to route `client_support.toolbar`. Library
  `client_support/toolbar` (`css/toolbar.css` + two SVG icons). Cache context `user.permissions`.
- **Plugin type `SupportIntegration`** — annotation `Annotation/SupportIntegration`, manager
  service `plugin.manager.support_integration` (`Component/SupportIntegrationManager`, discovery
  dir `Plugin/SupportIntegration`), interface `SupportIntegrationInterface::redirect()`, base class
  `SupportIntegrationBase`. Alter hook `support_integration_info`.
- **Redirect route** `client_support.toolbar` → `GET /client-support`
  (`Controller/RedirectController::redirectHandler`), requires permission `access client support`.
  Loads the configured plugin and returns its `redirect()` response.
- **Settings form** `client_support.settings_form` → `/admin/config/client-support/client-support-settings`
  (`Form/SettingsForm`), requires `administer client support`. A menu-block landing page lives at
  `client_support.settings` (`/admin/config/client-support`). Two admin-menu links
  (`client_support.links.menu.yml`).
- **Permissions** (`client_support.permissions.yml`): `access client support`,
  `administer client support`.
- **Config**: single object `client_support.settings`, key `settings.integration_plugin` (the
  chosen plugin id). Created only when the settings form is saved; **no default config and no
  config schema ship** with the module.
- No `.install` file, no update/schema hooks, no Drush commands, no PHP library dependencies.

## Submodule

- **`client_support_contact_form`** — a `SupportIntegration` plugin (`contact_form`) that redirects
  to the core Contact Form `support_form`, plus that form's config (fields: severity, issue URLs,
  attachments). Full docs: [modules/client_support_contact_form/1.0.x/agent/start.md](../modules/client_support_contact_form/1.0.x/agent/start.md).

## Solution docs

- **Plugin type contract, manager, toolbar, redirect controller, how to write an integration** →
  [plugins/support-integration.md](plugins/support-integration.md)
- **Settings form, config object, permissions, routes** → [config/settings.md](config/settings.md)

## Notes for agents

- `RedirectController::redirectHandler()` does **not** null-check the configured plugin id: hitting
  `/client-support` with permission but no plugin selected yields a PHP error
  (`$plugins[$pluginId]` undefined). In normal use the toolbar link is hidden until a plugin is set,
  so the route is reached only when configured.
- The base module does not itself capture the originating page URL or any request data; the
  redirect target is a fixed route from the plugin.
