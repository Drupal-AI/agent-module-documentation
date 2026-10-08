<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cross-domain traversal: routes, permissions, service and flow

## Install & enable

```bash
composer require drupal/domain_traversal
drush en domain_traversal -y
```

Hard dependency: `drupal/domain` (`^2.0 || ^3.0`; `.info.yml` requires `domain:domain >=2.0.0-beta1`).
The Domain Access submodule (`domain_access`) is **optional** — the service references it as
`@?domain_access.manager` and adapts when it is absent. No third-party libraries. PHP `>=8.1`.

## Permissions (`domain_traversal.permissions.yml`)

| Permission | Notes |
|---|---|
| `traverse domains` | "Traverse between assigned domains." Lets a user hop to the domains assigned to them (via Domain Access) — or, if Domain Access is not installed, to any active domain. |
| `traverse all domains` | "Traverse between all domains." `restrict access: true`. Lets a user hop to every active domain regardless of assignment. |

Anonymous can never hold either permission: `domain_traversal_form_user_admin_permissions_alter()`
(in `domain_traversal.module`) sets `#access = FALSE` on the anonymous checkboxes and adds
`_domain_traversal_form_user_admin_permissions_validate()`, which force-sets both to `0` on submit.

## Routes (`domain_traversal.routing.yml`)

All three are served by `src/Controller/DomainTraversal.php`.

1. **`domain_traversal`** — `GET /admin/domain-traversal`. Core `SystemController::systemAdminMenuBlockPage`
   renders the child menu links. Access: `DomainTraversal::domainTraversalAccess()` — allowed if the user
   may traverse all domains, or has **more than one** traversable domain id.
2. **`domain_traversal.traverse`** — `GET /admin/domain-traversal/traverse/{domain}` (`{domain}` =
   `entity:domain`). `options: no_cache: TRUE`, **`_csrf_token: 'TRUE'`**. Access:
   `DomainTraversal::traverseAccess()`. Runs `DomainTraversal::traverse()`.
3. **`domain_traversal.login`** — `GET /admin/domain-traversal/login/{domain}/{uid}/{timestamp}/{secret}`.
   `options: no_cache: TRUE`, `_maintenance_access: TRUE`. Access: `DomainTraversal::loginAccess()`.
   Runs `DomainTraversal::login()`. This route is hit **on the target domain**.

## Access logic — the `domain_traversal` service (`src/DomainTraversal.php`)

Implements `DomainTraversalInterface`; constructed with `@entity_type.manager` and `@?domain_access.manager`.

- `accountMayTraverseAllDomains($account)` → `TRUE` if the account has `traverse all domains`, or (when
  Domain Access is present) `domainAccessManager->getAllValue($account)` is non-empty. `FALSE` for anonymous.
- `getAccountTraversableDomainIds($account)` → active-domain ids the user may reach. If Domain Access is present
  and the user is not an all-domains user, it restricts to `array_keys(domainAccessManager->getAccessValues($account))`;
  otherwise it considers all domains. Inactive domains (`!$domain->status()`) are skipped.
- `accountMayTraverseDomain($account, $domain)` → `FALSE` for anonymous; `TRUE` if may-traverse-all; else
  `isset($ids[$domain->id()])`.

`traverseAccess($account, $domain)` (controller) forbids traversing to the **current** active domain
(`domainNegotiator->getActiveId()`) and forbids anonymous; allows if `traverse all domains`; else requires the
`traverse domains` permission **and** `accountMayTraverseDomain()`.

## The traverse → login flow (`src/Controller/DomainTraversal.php`)

`traverse(Domain $domain)`:
1. Load the current user; `timestamp = time->getRequestTime()`.
2. `secret = secretKey($account, $domain->id(), $timestamp)` where
   `secretKey()` = `Crypt::hmacBase64($timestamp . $account->id(), Settings::getHashSalt() . $domainId . $account->getPassword())`
   — HMAC keyed on the **site hash salt + domain id + the user's stored password hash**.
3. Insert `{uid, domain, timestamp, secret}` into the `domain_traversal` table.
4. Build a `Url` for `domain_traversal.login` with those params, `base_url` set to the target domain's path
   (`$domain->getPath()`), `absolute: TRUE`, and return a `TrustedRedirectResponse` to it.

`loginAccess(Domain $domain, int $uid, int $timestamp, string $secret)` (on the target domain):
- Deny if `timestamp < requestTime - 30` (`$secretTimeout = 30` seconds).
- Look up the stored row by `domain + timestamp + secret`, then `cleanupSecret()` deletes that row and any rows
  older than the timeout.
- Deny if the stored uid is non-zero and `!== $uid`.
- Load the user by `$uid`; deny if not active; deny if `!accountMayTraverseDomain($account, $domain)`.
- Recompute the secret and deny unless `hash_equals($secret, $secretKey)` (constant-time compare). Else allow.

`login(...)`:
- If someone is already logged in: if it is the same uid, clean up the secret and show "You are now logged in.";
  otherwise warn that another user is logged in on this computer (with a logout link). Redirect to `<front>`.
- Otherwise load the user by `$uid`, call `user_login_finalize($account)` (this establishes the session on the
  target domain), log a `notice` (`logger.channel.domain_traversal`) with the user name and timestamp — the
  secret is not logged — show "You are now logged in.", and redirect to `<front>`.

## Menu links & toolbar

- `domain_traversal.links.menu.yml` defines the parent link **"Domain traversal"** (route `domain_traversal`,
  parent `system.admin`) and a derived block whose deriver is `Plugin\Derivative\DomainTraversalMenuLink`.
- The deriver loads all Domain entities, skips inactive ones, and emits one `MenuLinkDefault` per domain
  pointing at `domain_traversal.traverse` with `route_parameters: {domain: <id>}`, title = the domain name,
  weight = the domain weight, in menu `admin` under the `domain_traversal` parent. Because the target route
  declares `_csrf_token`, the rendered links carry a CSRF token automatically.
- `Hook\DomainTraversalHooks::toolbar()` (`#[Hook('toolbar')]`, bridged by the `#[LegacyHook]`
  `domain_traversal_toolbar()`) adds a `toolbar_item` (weight 999) attaching the
  `domain_traversal/domain_traversal-toolbar` library (a key icon; `css/domain_traversal-toolbar.css`).

## Storage (`domain_traversal.install`)

`hook_schema()` defines table **`domain_traversal`**: `uid` (int), `domain` (varchar 64), `timestamp` (int),
`secret` (varchar 128); primary key is all four columns. Rows are transient — inserted on traverse and deleted
by `cleanupSecret()` on the next login attempt or once older than the 30-second timeout.

## Operating it

1. Enable `domain` (and configure your domains) and `domain_traversal`.
2. At **People → Permissions**, grant `traverse domains` (and/or `traverse all domains`) to the relevant roles.
   With Domain Access installed, also assign the intended domains to those users.
3. Users then see the per-domain links under the **Domain traversal** admin menu / toolbar item and click a
   domain to switch to it while staying logged in. There is **no settings form** — the "secret timeout" (30s)
   is a hardcoded `$secretTimeout` property (marked `@todo convert to config`).
