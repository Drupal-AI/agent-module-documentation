<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Microsites — configuring a microsite

## Create
`/admin/microsites/add/{group_type}` → `DomainGroupAddController::addForm` (access = `_entity_create_access: group:{group_type}`). Seeds default content/roles via `GroupDefaultContent` and binds a domain.

## Per-microsite settings — `DomainGroupSettings` plugins
Collected into `/group/{group}/domain-settings` (`DomainGroupSettingsForm`). Access =
`AccessResultAllowed::allowedIfHasPermission('bypass domain group permissions')` OR-ed with each plugin's own `access($group, $account)`. Plugins:
- `ThemeSettings` — theme override (group perm `set localgov microsite theme override`).
- `SiteSettings` — per-site name/email/etc.
- `ContentTypeSettings` — enable/disable content types per microsite.
- `MicrositeDomain` — the domain binding (group perm `administer group domain settings`, restricted).

## Context & routing
- `DomainGroupContext` context provider + `DomainGroupResolver` map the active domain → its Group.
- `MicrositeAdminController::access()` allows `/admin/microsite` only when a current group resolves from `group_sites.settings:context_provider`; otherwise forbidden.
- `ThemeSwitcherNegotiator` applies the microsite's theme override.
- Event subscribers: `ReplicateGroupContent`, `GroupContentRedirectSubscriber`, `SearchApiSubscriber` (scopes Search API access), `AlterCreateGroupContentSubscriber`, `ConfigSubscriber`.

## Permissions model
Global: `access microsites overview`, `bypass domain group permissions`. Group: `manage microsite enabled module permissions`, `set localgov microsite theme override`, `administer group domain settings` (restricted), `administer group domain site settings` (restricted). The `localgov_microsites_permissions` submodule extends `group_permissions` so microsite admins manage their own per-group permissions.

## Feature/content submodules
blogs, news, events, guides, directories, publications, step_by_step, group_webform, group_term_ui — each adds per-microsite content or UI.