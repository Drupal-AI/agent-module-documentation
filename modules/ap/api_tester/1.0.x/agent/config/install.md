<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Tester — install & operate

## Install / enable
- `composer require drupal/api_tester` (or place in a modules dir), then `drush en api_tester -y`.
- No Composer dependencies beyond Drupal core; uses core's Guzzle. `api_tester_requirements()` (runtime phase) flags an error if `GuzzleHttp\Client` is missing.
- `hook_install()` shows a status message linking to the tool. No config entities, no `config/install`, no config schema — nothing to import.

## Permissions (`api_tester.permissions.yml`)
- `use api tester` — access and use the tool; **required by every route** (main page, execute, users, all preset routes). `restrict access: true`.
- `administer api tester` — declared (`restrict access: true`) but not referenced by any route in 1.0.0; the tool is fully driven by `use api tester`.
- Grant `use api tester` only to trusted developer/administrator roles: the tool issues server-side HTTP requests and can re-run them as other accounts.

## Routes (`api_tester.routing.yml`)
All under `/admin/config/development/api-tester`: base page (`.main`), `execute` (POST), `users`, `list-presets`, `save-preset` (POST), `load-preset/{preset_id}`, `delete-preset/{preset_id}` (POST). Menu link `api_tester.admin` sits under `system.admin_config_development` (weight -10).

## Operating the tool
1. Go to **Configuration » Development » API Tester**.
2. Pick a method and enter a URL; add query params (auto-sync with the URL), headers, and a body (JSON/XML/text/form-data) in the tabs.
3. Choose an **Auth** strategy: No Auth, Bearer, Basic, API Key (header or query), or **Drupal Session** (reuses your session cookie + an injected `X-CSRF-Token` from the `rest` token, to hit session-protected routes).
4. Optionally set **Test as User** (Settings tab) to run the request under another account and observe permission behavior.
5. **Send** — the request is proxied server-side (Guzzle, 30s timeout, redirects followed); the response pane shows status, timing, size, headers, and a pretty/raw/preview body.
6. **Save Preset** to persist the request (per-user, in the State API); recall/update/duplicate/delete from the sidebar. The **Code Snippet** tab exports the request as cURL or client code for 13+ languages.

## Uninstall
`hook_uninstall()` deletes each user's `api_tester.presets.uid_<uid>` State entry (and a legacy `api_tester.presets` key) and shows a confirmation message. No other residue.
