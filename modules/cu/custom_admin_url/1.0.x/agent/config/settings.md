<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Admin URL — install, settings & the access gate

Source: `custom_admin_url.info.yml`, `.services.yml`, `.routing.yml`, `.links.menu.yml`,
`config/install/custom_admin_url.settings.yml`, `config/schema/custom_admin_url.schema.yml`,
`src/Routing/RouteSubscriber.php`, `src/Form/CustomAdminUrlForm.php`,
`src/Controller/AccessController.php`.

## Install / enable

- No dependencies beyond Drupal core (`core_version_requirement: ^10 || ^11`). Enable with
  `drush en custom_admin_url` (DDEV: `ddev drush en custom_admin_url -y`).
- On install, config `custom_admin_url.settings` is created with **`bo_url: ''`** (empty). While
  empty, the host comparison is skipped (see below) — the module is enabled but does **not** yet
  block by host.

## Configure the back-office host

- Form class **`CustomAdminUrlForm`** (extends `ConfigFormBase`, `final`), form id
  `custom_admin_url_custom_admin_url`, editable config `custom_admin_url.settings`.
- Route **`custom_admin_url.settings`** → path `/admin/config/system/custom-admin-url`, permission
  **`administer site configuration`**. Menu link (`links.menu.yml`) is placed under
  `system.admin_config_system` (Configuration → System), weight 10.
- Single field **`bo_url`** (`#type => textfield`, title *"Back Office URL"*, description
  *"Set Back-office URL. Eg: back.exemple.com"*). `validateForm()` rejects the value unless
  `UrlHelper::isValid($url, FALSE)` passes (relative-URL validation); `submitForm()` saves it to
  `custom_admin_url.settings:bo_url`. Enter a **bare host** such as `back.example.com` — the value
  is compared against `Request::getHost()`, which is host-only (no scheme, no path, no port).

### Config schema caveat

`config/schema/custom_admin_url.schema.yml` declares only:

```yaml
custom_admin_url.settings:
  type: config_object
  mapping:
    example:
      type: string
```

It defines an `example` key, **not** `bo_url` — so the key the module actually reads/writes is
schema-less. Functionally harmless here, but note it if you validate config or rely on typed config.

## How routes get the gate

`RouteSubscriber` (service `custom_admin_url.route_subscriber`, tag `event_subscriber`) implements
`alterRoutes(RouteCollection $collection)`:

```php
public const ADMIN_PATHS = ['admin', 'user'];
foreach ($collection as $route) {
  $path = explode('/', rtrim($route->getPath(), '/'));
  if (isset($path[1]) && in_array($path[1], self::ADMIN_PATHS, TRUE)) {
    $route->addRequirements(['_custom_access' => '\Drupal\...\AccessController::access']);
  }
}
```

- The leading `/` makes `$path[0]` empty, so `$path[1]` is the **first real segment**. Every route
  under `/admin/**` and `/user/**` (including `/user/login`, `/user/register`, `/user/{user}`,
  `/user/logout`, `/user/password`) receives `_custom_access`.
- `addRequirements()` **adds** to the route's existing requirements. Drupal's access manager ANDs
  all `_access`/`_permission`/`_custom_access`/`_entity_access` requirements (default access mode
  ALL), so this checker can only **deny** — it never overrides another checker that already grants
  or denies. It is a hardening layer, not an access grant.
- Route changes take effect after a **router rebuild** (`drush cr` / cache rebuild), as with any
  route alteration.

## How the access decision is made

`AccessController::access(AccountInterface $account)` (constructed via `create()` with
`request_stack->getCurrentRequest()`):

1. `$bo_url = config('custom_admin_url.settings')->get('bo_url')`.
2. If `$bo_url` is truthy and `$this->request->getHost() !== $bo_url` → return
   `AccessResult::forbidden()` (403). Exact, case-sensitive host string comparison.
3. If the current `_route` is **`user.login`** → return `AccessResult::allowed()`.
4. Otherwise → return `AccessResult::allowedIfHasPermissions($account, ['access administration
   pages'])`.

Consequences to verify after enabling:

- **Empty `bo_url` (default):** step 2 is skipped. Every matched `admin/*` and `user/*` route then
  additionally requires `access administration pages` (except `user.login`, which is allowed).
- **`bo_url` set:** requests from any host other than `bo_url` get a 403 for the whole
  `admin/*` + `user/*` space; requests from the correct host still need `access administration
  pages` (login excepted).
- Because the check is applied to the **entire `user/*` namespace**, core account flows for
  non-admin/anonymous users (registration, password reset, profile view/edit, logout) fall under
  the `access administration pages` requirement on the correct host. Test these flows for the roles
  your site relies on before deploying.

## Operating guidance

- This is **defense-in-depth / security-by-separation**, not a substitute for correct roles and
  permissions. Keep core permissions correct regardless.
- The gate trusts `Request::getHost()`. Configure `trusted_host_patterns` in `settings.php` so the
  host cannot be forged via the `Host` header, and ensure the front-office host genuinely cannot
  serve admin routes at the web-server/proxy layer.
- Set `bo_url` to a host you actually control and can reach before relying on it, so you do not lock
  yourself out of the admin UI by host mismatch.
