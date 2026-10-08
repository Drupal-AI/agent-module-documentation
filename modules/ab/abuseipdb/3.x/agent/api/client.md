<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API client, decision service, ban managers & event subscribers

The runtime splits into four layers: **`ApiClient`** (raw HTTP), **`Reporter`** (decisions),
the **ban-manager** service-collector (pluggable ban backends), and two **event subscribers** +
one **form hook** that drive it all.

## `ApiClient` (`src/ApiClient.php`, service `abuseipdb.client`)

Guzzle wrapper. Constructor reads `abuseipdb.settings:abuseipdb.api_key` and sets
`baseUri = 'https://api.abuseipdb.com/api/v2/'` (fixed — not request-influenced).

- `check(string $ip, int $days = 30): ResponseInterface` — `GET check?days=&ipAddress=`.
- `report(string $ip, array $categories, string $comment = ''): ResponseInterface` —
  `POST report` with `categories` (comma-joined ints), `comment`, `ip` as query.
- `request()` (protected) builds headers `Accept: application/json` and **`Key: <api_key>`** (the
  key travels in a header, never in the URL). For `check` it applies `timeout = check_timeout ?? 0`.
  Guzzle TLS verification is left at its secure default (no `verify => false`).
- On `GuzzleException` it calls `handleException()` (logs `Status:`/`Error:` — message + code, no
  IP, no key — to the `abuseipdb` logger channel) and returns a mock `Response(408, …, $message)`.
- Exception-state helpers: `hasError()`, `getException()`, `setException()`, `getResponse()`.

## `Reporter` (`src/Reporter.php`, service `abuseipdb.reporter`)

Injects `abuseipdb.client`, `abuseipdb.reporter_factory`, `config.factory`, `current_user`,
`database`. Constructor resolves the active ban manager via `ReporterFactory::doCreate()` and caches
the `shutdown` flag.

- `isAbusive(string $ip): bool` — empty IP → FALSE; else `check($ip, 30)`, `json_decode` the body,
  and return `data->abuseConfidenceScore >= (int) abuse_confidence_score`. Any thrown exception or
  empty body → FALSE (fail-open on API error).
- `ban(string $ip)` → delegates to the active ban manager's `banIp()`.
- `isBanned(string $ip)` → active ban manager's `isBanned()`.
- `report(string $ip, array $categories, string $comment)` → `ApiClient::report()`.
- `canUserBypass()` → `current_user->hasPermission('abuseipdb bypass check')`.
- `isIpWhitelisted(Request $r)` → splits `abuseipdb.whitelist` on newlines and matches
  `IpUtils::checkIp($r->getClientIp(), $list)` (CIDR-aware).
- `isShutdownMode()` / `setShutdownMode()` — the emergency switch.
- `isExceptionThrown()`, `getResponseBody()`, `getResponseStatusCode()` — response inspection used
  by `Form\Report`.

Every consumer gates on the same guard trio before acting:
`canUserBypass() || isShutdownMode() || isIpWhitelisted($request)` → return early.

## Ban-manager plugin system (a service_collector, not a Drupal plugin type)

- `AbuseipdbBanManagerInterface` (`src/AbuseipdbBanManagerInterface.php`): `banIp($ip): void`,
  `isBanned($ip)`, `getId(): string` (must equal the service id), `getModuleName(): string`.
- `AbuseipdbBanManagerCollector` (service `abuseipdb.ban_manager_collector`, tag
  `abuseipdb_ban_manager`, method `addBanManager`): collects tagged services keyed by `getId()`;
  `getBanManager($name)` returns one, `getBanManagers()` returns all sorted by module name
  (`- None -` sinks to the end).
- `ReporterFactory::doCreate()` (`src/ReporterFactory.php`) reads `abuseipdb.ban_manager` (default
  `abuseipdb.empty_ban_manager`) and asks the collector for that manager.
- `EmptyAbuseipdbBanManager` — default no-op (`banIp` does nothing, `isBanned` FALSE, name
  `- None -`).
- Submodules register `abuseipdb_core_ban.ban_manager` (core `ban.ip_manager`) and
  `abuseipdb_advban.ban_manager` (`advban.ip_manager`).

To add your own backend: create a service implementing `AbuseipdbBanManagerInterface`, tag it
`{ name: abuseipdb_ban_manager }`, and return its service id from `getId()`.

## Enforcement surfaces

### Form check — `abuseipdb_form_alter()` / `abuseipdb_form_validate()` (`abuseipdb.module`)

`hook_form_alter` appends `abuseipdb_form_validate` to `#validate` when the form's `#form_id`
appears (substring `mb_strpos`) in `abuseipdb.forms`. The validator gets
`Request::getClientIp()`, runs the guard trio, and if `Reporter::isAbusive($ip)` sets a form error
and — when `abuseipdb.forms_ban_ip` — calls `Reporter::ban($ip)`.

### Request event — `EventSubscriber\Request` (`abuseipdb.request`, `KernelEvents::REQUEST`)

`pathsCheck()`: guard trio → if `abuseipdb.paths_check` matches the current path
(`PathMatcher::matchPath`, lowercased) and the client IP is abusive, then **ban** it
(`paths_check_ban_ip`) **or** issue a `RedirectResponse` to `paths_check_safe_path` (default `/`).
This is a synchronous API check on every matching request — keep the list off high-traffic paths.

### Terminate event — `EventSubscriber\Terminate` (`abuseipdb.terminate`, `KernelEvents::TERMINATE`)

`pathBlacklist()`: guard trio → if `abuseipdb.paths_report` matches the path, submit the client IP
to AbuseIPDB with category **21 (Web App Attack)** and a comment naming the path, then optionally
**ban** it (`paths_report_ban_ip`). Runs post-response so it doesn't block the page.

## Category vocabulary

`abuseipdb_get_categories_mapping()` (`abuseipdb.module`) returns AbuseIPDB's 1–23 category codes
(DNS Compromise … IoT Targeted) with titles/descriptions; `Form\Report` uses it for the manual
report checkboxes, and the Terminate subscriber hard-codes category 21.

## Behavioural notes

- IP is always `Request::getClientIp()` — the real connection IP unless Drupal's trusted-proxy
  settings are configured (then it honours the trusted forwarding header).
- On any API/network error the check **fails open** (`isAbusive` returns FALSE) so the site stays
  reachable; a mock 408 response is produced and the error is logged.
- `AbuseipdbBanManagerCollector::getBanManager()` returns the requested id directly; if config names
  a manager whose module was removed, resolution can fail — keep `ban_manager` in sync with enabled
  submodules (the submodule `hook_uninstall` resets it to `- None -`).
