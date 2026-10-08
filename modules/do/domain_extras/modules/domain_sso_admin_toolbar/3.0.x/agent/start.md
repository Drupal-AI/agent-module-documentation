# Domain SSO Admin Toolbar (domain_sso_admin_toolbar) 3.0.x

Adds a "Domains" dropdown to the admin toolbar that switches the logged-in user to another configured domain and signs them in there automatically through the domain_sso handshake.

## Facts

- **Dependencies:** `domain:domain`, `domain_extras:domain_sso`, `admin_toolbar:admin_toolbar`; core `^10.2 || ^11`. Part of the `domain_extras` project (package `Domain`).
- **Permission:** `use domain sso admin toolbar` (`domain_sso_admin_toolbar.permissions.yml`). The switcher also requires the core `access toolbar` permission to appear.
- **Route:** `domain_sso_admin_toolbar.switch` — path `/admin/domain-sso-switch/{domain}` (`{domain}` constrained to `[a-z0-9_]+`), `_permission: 'use domain sso admin toolbar'`, `no_cache: TRUE`, `_maintenance_access: TRUE`; controller `\Drupal\domain_sso_admin_toolbar\Controller\DomainSwitchController::switchDomain` (`src/Controller/DomainSwitchController.php`).
- **Hook:** `hook_toolbar_alter()` via OOP hook class `\Drupal\domain_sso_admin_toolbar\Hook\DomainSsoAdminToolbarHooks::toolbarAlter()` (`src/Hook/DomainSsoAdminToolbarHooks.php`), registered in `domain_sso_admin_toolbar.services.yml`; a `#[LegacyHook]` shim in `domain_sso_admin_toolbar.module` forwards to it. Builds the `domain_sso_switcher` toolbar item.
- **Services used (not defined):** `request_stack`, `domain.negotiation_context` (`Drupal\domain\DomainNegotiationContext`), `path_processor_manager` (`InboundPathProcessorInterface`), `current_user`, `entity_type.manager`.
- **Library:** `domain_sso_admin_toolbar/toolbar_domain_switcher` (theme CSS `css/toolbar_domain_switcher.css`), attached to the toolbar item.
- **Config / schema:** none. No `configure` route. Defines no plugin types.

## How it works

- `toolbarAlter()` shows the tray only when the user is authenticated and has both `access toolbar` and `use domain sso admin toolbar`, and when more than one enabled `domain` entity exists (loaded via `loadMultipleSorted()`, filtered by `status()`). Each enabled domain becomes a link to `domain_sso_admin_toolbar.switch`; the active domain (from `domain.negotiation_context`) is labelled "(current)".
- `switchDomain($domain)`: requires an authenticated caller (else redirect to `user.login`); loads the target `domain` entity and errors on an unknown id; if already on the target domain, redirects back to the referer/front. It rebuilds the current internal path from the `referer` header through the inbound path processors, appends it plus any query string to the target domain's configured path. If current and target domains share a hostname it redirects directly (shared cookies); otherwise it redirects to `domain_sso.handshake.issue` with `domain` and `target` query args, handing off token issue/consume/login to domain_sso.

## Setup

1. Enable the module and its dependencies (`drush en domain_sso_admin_toolbar`), then `drush cr`.
2. Ensure domain_sso is configured and all domains share the same database and `hash_salt` (see the domain_sso docs).
3. Grant `use domain sso admin toolbar` (plus `access toolbar`) to trusted roles at `/admin/people/permissions`.
4. With two or more enabled domains configured, the "Domains" item appears in the admin toolbar; open it and pick a domain to switch.

## Docs

- (none — single-file module; the SSO token mechanics live in the domain_sso module docs.)
