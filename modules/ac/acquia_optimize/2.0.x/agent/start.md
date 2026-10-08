<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Web Governance (acquia_optimize) — agent index

On-demand "Quick Scan" for Drupal editors. From a node edit form (or the Canvas page builder) it
renders a preview of the current page, collects its HTML/CSS in the browser, sends that to the
**Acquia Web Governance (Monsido) API**, and shows accessibility (WCAG 2.0/2.1/2.2), SEO,
readability and data-privacy findings in a modal. **Per-page, on demand — not a whole-site crawler.**
Results are not synchronised back to the Acquia account.

Version **2.0.0**. Core `^10.3 || ^11`. No module dependencies. `composer.json` **conflicts with
`drupal/experience_builder`**. Configure at `acquia_optimize.admin_settings`
(`/admin/config/content/acquia-optimize`).

## Permissions (`acquia_optimize.permissions.yml`)
- `scan acquia optimize` — run scans (**`restrict access: true`**; scans cost vendor quota).
- `administer acquia optimize` — connection settings.

## Configuration (`acquia_optimize.settings`)
- `api_key` — Bearer token for the Web Governance API (stored in config; masked in the form).
- `api_url` — API base; form-validated to HTTPS + `*.monsido.com` only.
- `accessibility` — WCAG target (e.g. `WCAG21-AA`; see `Utilities::ACCESSIBILITY_GUIDELINES`).
- `debug_mode` — JS console debug logging.

See `config/` for the settings form and credential handling.

## Runtime flow / endpoints (`acquia_optimize.routing.yml`)
- `AcquiaOptimizeFormAlter` alters node forms: adds a Quick Scan / Configure API button to the
  advanced group (only when the user has `scan acquia optimize`).
- `AcquiaOptimizePreviewController::view` — node preview, forced to render as the anonymous user.
- `POST /acquia-optimize/api/quick-scan` → `AcquiaOptimizeController::createQuickScan` →
  `ApiClient::createScanRequest` → `POST {api_url}/html_scans`.
- `GET /acquia-optimize/api/quick-scan/{scan_id}` → `getQuickScan` (status + result processing).
- `GET /acquia-optimize/api/content-quick-scan/{scan_id}` → `ContentQuickScanController` does
  server-side polling and renders the results modal.
- `POST /acquia-optimize/api/validate-connection` and `GET|POST /acquia-optimize/api/settings`
  (JSON, used by the React/Canvas extension).

See `api/` for the API client, endpoints and the SaaS integration.

## Key classes
- `ApiClient` / `ApiClientFactory` — Guzzle client to the Web Governance API (Bearer auth, HTTPS,
  default TLS verification).
- `Controller/AcquiaOptimizeController`, `Controller/ContentQuickScanController`,
  `Controller/AcquiaOptimizePreviewController`.
- `Form/SettingsForm` (credentials + URL allowlist), `Form/AcquiaOptimizeFormAlter` (node-form UI).
- `Utilities` (WCAG guideline list, image path, api-key-set check),
  `Enum/SeoIssues`, `Enum/ReadabilityData` (map raw API data to friendly labels).
- React app under `ui/` (bundled to `ui/dist/bundle.js`) for the Canvas authoring environment.

## Credential note
`api_key` lives in `acquia_optimize.settings`. The form masks it and preserves the stored value on
resubmit — careful UI, but masking is not storage: the key is still in config, so it is in config
exports, the repo and database dumps. No Key entity support. Prefer an environment variable plus a
`settings.php` config override so exported configuration carries nothing secret.
