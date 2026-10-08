<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The remote action (RPC) framework

DRD's core mechanism is a set of **Action plugins** that the dashboard runs *against a remote
domain*. This is a one-directional client: the dashboard POSTs an encrypted command to the
managed site's `drd_agent` endpoint and processes the encrypted reply. DRD itself exposes **no**
inbound command endpoint — the receiving/authenticating endpoint lives in the separate `drd_agent`
module.

## Plugin hierarchy (`src/Plugin/Action/`)

- `Base` extends core `ActionBase`; adds config (taxonomy `terms`), `access()`, argument/output
  helpers, `restrictAccess()`, `canBeQueued()`.
- `BaseEntity` / `BaseEntityInterface` — actions bound to a DRD entity.
- `BaseEntityRemote` — actions that actually talk to a remote domain (see below).
- `BaseCoreRemote` — resolves a `drd_core` to its first active domain, then delegates.
- `BaseHost`, `BaseGlobal` — host-level and global (non-remote) actions.

Concrete actions (each an `@Action` with `type` `drd`/`drd_core`/`drd_domain`/`drd_entity`):
`Info`, `Ping`, `FlushCache`, `Cron`, `MaintenanceMode`, `Update`, `UpdateTranslations`,
`Php` (`drd_action_php`, runs a PHP snippet remotely, arg `php`), `Database` (`drd_action_database`,
downloads a DB dump to the dashboard temp dir), `Download`, `ErrorLogs`, `Session`, `Blocks`,
`Projects`, `ProjectsStatus`, `ProjectsUpdate`, `DomainChange`, `DomainMove`, `DomainsEnableAll`,
`DomainsReceive`, `JobScheduler`, `ReleaseLock`, `ReleaseUnlock`, `UserCredentials`, plus list
actions (`ListCores`, `ListDomains`, `ListEntities`, `ListHosts`). Default configs are shipped as
`system.action.drd_action_*.yml` under `config/optional/`.

## Request/response flow (`BaseEntityRemote::remoteRequest()`)

1. Build args `['auth' => domain->getAuth(), 'authsetting' => domain->getAuthSetting(), 'action',
   'drd_action_module'] + $this->arguments`.
2. For **custom** (non-`drd`) action modules, the matching remote class file
   `src/Agent/Action/V{coreVersion}/{Action}.php` is read with `file_get_contents()` and shipped in
   `drd_action_plugin` so the agent can run version-appropriate code.
3. Instantiate the domain's crypt method (`CryptBase::getInstance($domain->getCrypt(),
   $domain->getCryptSetting())`) and build the payload:
   `{uuid, args: base64(crypt->encrypt($args)), iv: base64(crypt->getIv())}`; if the crypt method
   is auth-before-decrypt (TLS), `auth`/`authsetting` are added in the clear.
4. `HttpRequest` (`src/HttpRequest.php`) POSTs `base64(json_encode(payload))` to the domain's
   `drd-agent` query. It uses the core `http_client_factory` (`fromOptions`) — **TLS certificate
   verification is left at the Guzzle default (enabled)**; it sets an `X-Drd-Version` header and a
   cookie jar, and treats the reply as DRD only when status 200 + `content-type text/plain` +
   `x-drd-agent` version header match.
5. `HttpRequest::getResponse()` `base64_decode`s the body; `remoteRequest()` then calls
   `crypt->decrypt(body, iv)` to reconstruct the PHP response, caches any `messages`, and stores the
   result in `$this->response`.
6. Optional `getFollowUpAction()` queues follow-ups (e.g. `Php` and `Update` follow with
   `drd_action_info`).

## Orchestration

- `ActionManager` (`plugin.manager.drd_action`, extends core action manager) adds `instance($id)`,
  `response($id, $remote, $args)`, `getActionsByTerm()` (fire all actions tagged with a term), and
  `executeAction()` which dispatches `drd.action.started` / `drd.action.finished` events (consumed
  by `drd_eca`).
- `QueueManager` (`queue.drd`) pushes actions onto Advanced Queue job types
  (`Plugin/AdvancedQueue/JobType/Action*`) for background execution.
- `access()` grants when running under CLI or cron (`PHP_SAPI === 'cli' || @ignore_user_abort()`),
  otherwise requires the per-action permission whose name equals the plugin id (see
  [../config/routes-permissions.md](../config/routes-permissions.md)).

## Code-update pipeline

`Update/Manager` plus `Plugin/Update/{Build,Process,Test,Deploy,Finish,Storage}` implement a staged
remote code update: Build (`Composer`, `DrushMake`, `Direct`), Storage (`Git`, `GitFlow`, `Local`,
`Rsync`), Process (`LakeDropsD8`, `None`), Test, Deploy (`Rsync`, `None`), Finish. Each stage is a
DRD Update plugin type (`@Update` annotation, `src/Annotation/Update.php`).
