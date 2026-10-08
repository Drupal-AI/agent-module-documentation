<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD entities (host / core / domain and the inventory model)

DRD models a managed fleet as a small entity graph. All classes live in `src/Entity/` with
interfaces alongside; forms in `src/Entity/Form/`, list builders in `src/Entity/ListBuilder/`,
view builders in `src/Entity/ViewBuilder/`, access handlers in `src/Entity/AccessControlHandler/`,
Views data in `src/Entity/ViewsData/`.

## The inventory graph

- **`drd_host`** (`Host.php`) — a physical/logical server. Created automatically on install
  (`drd_install()` creates a "Localhost" host). SSH connection details for local-copy/update
  operations attach here. Content entity, base table `drd_host`.
- **`drd_core`** (`Core.php`) — one Drupal codebase/installation on a host. References a host, a
  Drupal release, a `drupalroot`, and a git repo (`gitrepo`, added by `drd_update_8004`). One core
  can serve many domains.
- **`drd_domain`** (`Domain.php`) — a single site URL that the dashboard talks to. This is the unit
  the agent runs on. Fields include `domain`, `uripath`, `port`, `secure`, `aliase`, `header`
  (key/value, via `key_value_field`), `auth` + `authsetting`, `crypt` + `cryptsetting`, `installed`,
  a `core` reference, and cached `releases` / `warnings` / `errors` references.
- **`drd_project`** (`Project.php`), **`drd_major`** (`Major.php`), **`drd_release`**
  (`Release.php`) — the catalogue of contrib/core projects, their major branches and specific
  releases discovered across all domains; used for update/hacked/lock reporting.
- **`drd_requirement`** (`Requirement.php`) — a status-report requirement (from a remote site's
  status page); can be marked ignored so it stops raising warnings/errors.

Config entities: **`drd_script`** (`Script.php`) and **`drd_script_type`** (`ScriptType.php`)
define runnable scripts (shell/drush/console/python — see `config/optional/drd.script_type.*.yml`)
with an interpreter, extension, prefix/suffix and line-prefix (schema
`config/schema/script_type.schema.yml`).

## Entity keys and routes

Host/Core/Domain share `entity_keys` `id`/`name`/`uuid`/`user_id`/`langcode`. Canonical/edit/delete
routes are declared in `drd.routing.yml` under `/drd/{type}s/...`. `field_ui_base_route` points each
type at its `drd_{type}.settings` admin form so fields can be added via Field UI. All entity view
routes require `_entity_access` (e.g. `drd_domain.view`); collections require a `view {type}
entities` permission.

## Domain: the remote-communication surface

`Domain.php` is the largest class and owns the client side of the protocol:

- **Encrypted fields**: `getEncryptedFieldNames()` returns `authsetting` and `cryptsetting`; their
  getters/setters run values through the `drd.encrypt` service (see
  [../api/crypto-and-auth.md](../api/crypto-and-auth.md)).
- **URL building**: `buildUrl($query)` composes `http(s)://domain[:port]/uripath[/query]` from the
  stored fields (`secure` chooses the scheme). `instanceFromUrl()` finds-or-creates a domain by
  parsing a URL.
- **Remote calls** are thin wrappers over the action manager: `ping()`, `remoteInfo()`,
  `initCore()`, `retrieveAllDomains()`, `database()`, `download()`, `getSessionUrl()`,
  `getMaintenanceMode()`, `getRemoteBlock()`, `getRemote{Settings,Globals,Requirements}()` all call
  `$this->actionManager->response('drd_action_*', $this, ...)`.
- **Setup/handshake helpers**: `getSupportedCryptMethods()` (queries `drd-agent-crypt`),
  `authorizeBySecret()` (`drd-agent-authorize-secret`), `pushOtt()` and `getRemoteSetupToken()`
  (one-time-token authorization), `resetCryptSettings()` (negotiates a shared crypt method and
  generates a fresh 50-char password), `initValues()` (seeds `shared_secret` auth + `OpenSsl` crypt
  with generated secrets).
- **Response caching + sanitising**: `cacheRemoteMessages()`, `cacheRequirements()`, `cacheBlock()`
  etc. store remote output in the cache backend; `sanitizeRemoteText()` rewrites relative links to
  absolute remote links and wraps strings in `FormattableMarkup`.

Remote-message/report display: `drd.module` registers `hook_theme` templates (`drd-core`,
`drd-domain`, `drd-host`, `drd-major`, `drd-project`, `drd-release`, `drd-requirement`) and
`hook_entity_extra_field_info` extra display fields (`actions`, `latest_ping_status`, `messages`,
`queryresult`, `review`, `status_report`, `monitoring`).
