<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Core (varbase_core) — agent index

Foundation/glue module of the **Varbase** distribution. Its own PHP is thin: a settings
landing page, one general-settings form, five drush commands, and a `src/Hook` class of
integration hooks. Its substance is **configuration and a bundled module set** — it hard-depends
on ~28 modules (info.yml `dependencies`), auto-enables ~60 more at install (info.yml `install:`),
and its `composer.json` pulls in ~100 contrib projects. Core is pinned to `~11.4.0` (one minor,
not a range). Configure at `/admin/config/varbase` (route `varbase_core.settings_index`).

Common tasks:
- **Toggle welcome message / custom account names** → [configure/settings.md](configure/settings.md)
- **Gate the Varbase settings pages** → [permissions/permissions.md](permissions/permissions.md)
- **Fix broken permissions / entity defs, run optional updates, clean patches** → [drush/commands.md](drush/commands.md)
- **What the module does at install / on other modules being enabled (managed config, tokens, form alters)** → [hooks/hooks.md](hooks/hooks.md)

Eight packaged submodules (each has its own doc dir), enabled selectively by a Varbase profile:

| Submodule | Owns |
|---|---|
| `varbase_admin` | admin config (userprotect, roleassign, VBO, coffee, responsive_preview) |
| `varbase_page` | Basic `page` content type + CKEditor5/metatag/yoast config |
| `varbase_security` | password_policy, seckit, honeypot, captcha, username_enumeration_prevention |
| `varbase_internationalization` | language, locale, content/config translation |
| `varbase_webform` | webform features + business_contact form |
| `varbase_tour` | editor welcome tour/modal |
| `varbase_default_content` | starter content (hidden module) |
| `varbase_development` | dev tooling (dblog, devel, reroute_email) — **its description says disable in production** |

Key facts:
- **Config object:** `varbase_core.general_settings` — keys `welcome_status` (bool), `allow_custom_account_name` (bool). Schema in `config/schema/varbase_core.schema.yml`.
- **One permission:** `access varbase settings` — gates both routes (`varbase_core.settings_index`, `varbase_core.general_settings`).
- **Routes:** `varbase_core.settings_index` (`/admin/config/varbase`, core `SystemController::systemAdminMenuBlockPage`), `varbase_core.general_settings` (`/admin/config/varbase/settings`, `VarbaseGeneralSettingsForm`).
- **Drush** (`varbase_core.commands`): `varbase:remove-non-existent-permissions` (rnep), `varbase:entity-update` (edupdb), `varbase:optional-update` (varbase-up), `varbase:composer:cleanup:patches` (var-ccup), `varbase:composer:cleanup:patches-file` (var-ccupf).
- **Provided tokens:** `[site:origin-url]`, `[default-active-theme:path]`.
- **Config dirs:** `config/install`, `config/optional` (bulk-imported at install via regex scan), `config/managed` (imported only when a related optional module is enabled), `config/permissions` (role permissions applied via `ModuleInstallerFactory::addPermissions`).
- Requires the `vardot/varbase-patches` composer plugin — must be in `config.allow-plugins` or `composer require` fails.
- No plugin types defined. No services beyond the drush command service.
