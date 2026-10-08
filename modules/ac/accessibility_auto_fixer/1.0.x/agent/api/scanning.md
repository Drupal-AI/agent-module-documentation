<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scanning API, endpoints & Drush

## Scanner service — `Service\A11yScannerService`
Constructed with `@http_client_factory` and the module logger.
- `scanUrl(string $url): array` — `httpClientFactory->fromOptions(['timeout' => 15])->get($url)`,
  reads the body, then `scanHtml()`. On any throwable it logs and returns `['violations'=>0,'details'=>[]]`.
- `scanHtml(string $html, string $path='/'): array` — loads HTML via `loadDom()`
  (`DOMDocument::loadHTML` with `LIBXML_NONET`, warnings suppressed) and runs five checks, merging
  their issue arrays: `checkMissingAltText`, `checkMissingAriaLabels` (button/select/textarea),
  `checkInlineContrast` (elements with a `style` attr; `extractCssColor` + `contrastRatio` < 4.5),
  `checkEmptyLinks`, `checkMissingFormLabels` (XPath for inputs + `<label for>`/ancestor label).
- Each issue = `issue(id, impact, description, selector, suggestion)` with `source => 'server'`.
  `elementSelector()` builds `tag#id` / `tag.firstClass` / `tag`. Contrast uses WCAG relative
  luminance (`relativeLuminance`, `contrastRatio`).

Violation ids/impacts: `missing-alt-text` (critical), `missing-aria-label` (serious),
`empty-link` (serious), `missing-form-label` (serious), `insufficient-contrast` (serious).

## Storage service — `Service\A11yStorageService`
Constructed with `@database`. Uses the DB query builder throughout (parameter-bound, no string SQL).
- `static calculateScore(array $details): int` — 100 minus per-impact deductions (critical 10,
  serious 5, moderate 2, else 1), floored at 0.
- `save(path, violations, details, scanType='client')` — inserts an `a11y_results` row
  (`details` = `json_encode`, `created` = `time()`).
- Readers: `loadAll`, `loadRecent($limit)` (latest id per path via MAX(id) subquery + join),
  `loadById`, `loadLatestForPath`, `loadHistoryForPath`, `loadStats`, `loadAllPaths`.
- Fix tracking: `saveFix(path, issueId, selector)` inserts into `a11y_fixes` if not present;
  `getFixedKeys(path)` returns `"issueId|selector"` strings used by `report()` to drop resolved
  violations; `deleteForPath(path)`.

## Route discovery — `Service\A11yRouteDiscoveryService`
`discoverPaths(int $maxPaths=500)`: reads the `router` DB table for static (no `{param}`) GET/html
routes, skipping admin/a11y/ajax/api/etc. prefixes (`SKIP_PREFIXES`) and route-name substrings
(`SKIP_NAME_PARTS`); unserializes `requirements` with `allowed_classes => FALSE`. Then
`expandEntityPaths()` builds canonical URLs for published `node`/`user`/`taxonomy_term` entities
(≤200 ids each, `getQuery()->accessCheck(FALSE)`), returns a sorted, unique, capped list.

## HTTP endpoints — `Controller\ScanController` (services: scanner, storage, route_discovery)
All under `_permission: 'access accessibility reports'` unless noted. Bodies are JSON
(`json_decode($request->getContent(), TRUE)`); the client (`js/scanner.js`) sends an
`X-CSRF-Token` header sourced from `drupalSettings.a11yScanner.csrfToken`.
- `report` (POST `/admin/reports/a11y-report`) — persists JS-scanned `details` for `path`,
  filtering out `getFixedKeys()` entries; returns saved count, score, and `unfixed_violations`.
- `scanServer` (POST `/admin/reports/a11y-scan-server`) — reads `body['url']` and calls
  `scanner->scanUrl($url)`, saves the result under `parse_url(...PHP_URL_PATH)`, returns details.
- `scanAll` (`/admin/reports/a11y-scan-all`) — GET redirects to the dashboard; POST scans either
  saved paths (`mode=saved`, from `loadAllPaths()`) or discovered paths (`mode=discover`,
  `max<=500`). Relative paths are prefixed with `request->getSchemeAndHttpHost()`.
- `fix` (POST `/admin/reports/a11y-fix`) — returns a DOM fix payload from `buildFix()`
  (`setAttribute` alt/aria-label, or `setStyle` color `#000000`) and records the fix via `saveFix()`;
  422 if the id has no auto-fix.
- `discoverRoutes` (GET `/admin/reports/a11y-discover`) — returns discovered paths (no scan).

## Rendering controllers
- `DashboardController::view/logs` — stats cards + recent/all scans tables; attaches CSRF token
  and endpoint URLs to `drupalSettings.a11yScanner`.
- `ScanDetailsController::view` — violations (with impact/type filters), overview, and history tabs
  for one `a11y_results` id. Row fields are escaped with `htmlspecialchars()` and rendered as table
  `#markup` (core `Xss::filterAdmin()` applies).
- `NodeScanController` — see config/settings.md.

## Client JS
- `js/scanner.js` — `Drupal.a11yScanner.run()` (DOM + computed-style checks), `.scanAndReport()`
  (POSTs to `report`), `.autoFix()`/`.autoFixAll()` (POST to `fix`, then `applyFix()` mutates the
  live DOM via `setAttribute`/`element.style`).
- `js/ui.js` — slide-in panel, highlight, "Scan this page" injection, Scan-All buttons. Panel
  output escapes issue fields with a local `escapeHtml()`.

## Drush — `Commands\A11yCommands` (tag `drush.command`)
- `a11y:scan <url> [--format=table|json]` — scans one URL, saves the result, prints table or JSON;
  exit code 1 if violations found.
- `a11y:scan-all <urlFile> [--format=table|json]` — scans one absolute URL per line from a file;
  aggregates violations; exit 1 if any found. Intended for CI.
