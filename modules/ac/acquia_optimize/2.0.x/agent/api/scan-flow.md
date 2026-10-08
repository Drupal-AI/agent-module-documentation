<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API integration & scan flow

The module talks to the **Acquia Web Governance (Monsido)** SaaS over HTTPS. It does not run any
analysis locally — Drupal only collects the page markup and proxies it to the vendor API.

## HTTP client (`src/ApiClient.php`, `src/ApiClientFactory.php`)
- Guzzle `ClientInterface` (`@http_client`). **Default TLS verification** — no `verify => false`,
  no disabled cert checks.
- Auth: `Authorization: Bearer {api_key}` header. Credentials come from
  `acquia_optimize.settings` (`getCredentials()`), or from per-call overrides passed to
  `ApiClientFactory::create($apiKey, $apiUrl)` (used by connection validation).
- Timeouts: `timeout 45`, `connect_timeout 15`, `read_timeout 30`.
- `validateLibrary()` first checks that the module's "optimize" JS library file
  (`js/acquiaProcessing.js`, the browser `DataCollector`) exists on disk, else returns a 404-style
  error telling the admin to obtain the library from Acquia.
- `handleApiError()` maps upstream status codes (400/401/403/404/422/429/5xx) to fixed,
  translated messages and logs them. Only the status code is logged — no request/response bodies,
  no credentials.

## Vendor endpoints called
| Method | Path | Purpose |
| --- | --- | --- |
| GET | `{api_url}/account` | Validate connection / credentials. |
| POST | `{api_url}/html_scans` | Create a scan from `encoded_page` + `html` + `css` + `accessibility`. |
| GET | `{api_url}/html_scans/{scan_id}` | Poll scan status / fetch results. |

## Drupal endpoints (`acquia_optimize.routing.yml`)
All require `scan acquia optimize` unless noted; the settings/validate endpoints require
`administer acquia optimize`.
- `POST /acquia-optimize/api/quick-scan` → `createQuickScan` → `ApiClient::createScanRequest`.
- `GET /acquia-optimize/api/quick-scan/{scan_id}` → `getQuickScan` → `processScanResults`.
- `GET /acquia-optimize/api/content-quick-scan/{scan_id}` → `ContentQuickScanController` —
  server-side polling loop (max 15 tries, 2s interval, up to 2 failure-retries) that blocks until
  the scan is `completed`/`failed`, then renders the results modal server-side.
- `GET /acquia-optimize/{node_preview}/preview` → `AcquiaOptimizePreviewController::view` — extends
  core `NodePreviewController` but **switches to the anonymous user** before rendering so the scan
  sees the public page. `no_cache: TRUE`.

## End-to-end quick scan (node form)
1. `AcquiaOptimizeFormAlter::formAlter` adds the Quick Scan button (only if user has
   `scan acquia optimize`, and not on `canvas.api.*` routes).
2. On click, the entity is built (not submitted), the form state is written to the
   `node_preview` private tempstore keyed by the node UUID, and a modal opens.
3. `js/quickScan.js` GETs the preview URL, feeds the HTML into `window.DataCollector` (from the
   Acquia "optimize" library) to get `dom_tree`/`html`/`css`/`viewport`, then POSTs to
   `/acquia-optimize/api/quick-scan`.
4. It polls `/acquia-optimize/api/content-quick-scan/{id}`; the server returns `rendered_results`
   (a server-rendered Twig modal). The browser swaps it in via `modalContent.outerHTML`.
5. Results are shown but **not** synced to the Acquia account.

## Result processing (`processScanResults`, Enums)
- `seo_issues` → `Enum\SeoIssues::getGroupedSeoIssues()` adds friendly names + categories.
- `readability` score → `Enum\ReadabilityData::fromScore()` yields grade level, description, colour.
- `accessibility_errors` and `data_protection_violations` are passed through to the section
  templates. Total issue count = SEO + accessibility + data-protection counts.

## Canvas / React path
`ui/` (bundled to `ui/dist/bundle.js`, library `acquia_optimize.app`, depends on `canvas/canvas-ui`)
is a React extension for the Canvas page builder. `ui/components/services/apiService.js` calls the
same JSON endpoints, attaching the CSRF token from `GET /acquia-optimize/api/settings` on POSTs.
