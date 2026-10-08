<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Meta Conversions API (meta_conversions_api) — agent index

Server-side integration with Meta's (Facebook) **Conversions API**. Builds conversion events with
Facebook's PHP Business SDK (`facebook/php-business-sdk:^15.0`, Graph API **v15.0**) and POSTs them to
`https://graph.facebook.com/v15.0/{pixel_id}/events`, authenticated by an access token in config.
Replaces or supplements the browser Facebook pixel. Version **1.1.0**. Core: `^9 | ^10 || ^11`
(single-pipe and double-pipe are both parsed as OR by Composer — this resolves on D9/D10/D11).

## What it actually does
- Central service `meta_conversions_api.meta_client` (`src/Services/MetaClient.php`) with
  `sendRequest($eventData, $userData, $customData, $testEventCode)` — the one method that sends events.
- Ships a single event, **PageView**, fired client-side: `hook_page_attachments` attaches
  `js/meta_conversions_api.page_view.js`, which GETs `/ajax/page-view`, which calls `sendRequest()`.
- The access token, pixel ID, default action source, test event code and an SDK-logging toggle live in
  `meta_conversions_api.settings`; per-event on/off toggles live in `meta_conversions_api.events`.
- **PII is SHA-256 hashed by the SDK**, not by this module. You pass raw email/phone/name; the SDK's
  `UserData` normaliser hashes them before transmission (README: "You do not need to hash the data").
  Client IP + user agent are attached automatically and sent unhashed (per Meta spec).

## Files that matter
- `src/Services/MetaClient.php` — SDK init, `isEnabled()`, `isAllowed()`, `sendRequest()`, event
  name/toggle logic. This is the whole engine.
- `src/Form/SettingsForm.php` — `/admin/config/system/meta-conversions-api` (access token, pixel ID,
  action source, test event code, logging).
- `src/Form/EventsForm.php` — `/admin/config/system/meta-conversions-api/events` (per-event toggles).
- `src/Controller/PageViewController.php` — the `/ajax/page-view` beacon endpoint.
- `src/MetaApiTwig.php` — Twig functions `meta_api_is_enabled()`, `meta_api_is_allowed()`.
- `src/Logger/FacebookLogger.php` — routes SDK request/response logs into the Drupal logger.
- `meta_conversions_api.api.php` — the three hooks (event_names, event_names_alter, allowed).

## Extension points (see agent/api/ and agent/events/)
- `hook_meta_conversions_api_event_names()` — declare named events (makes them toggleable).
- `hook_meta_conversions_api_event_names_alter(&$names)` — rename events.
- `hook_meta_conversions_api_allowed()` — return `AccessResult::forbiddenIf(...)` to block sending
  (the cookie-consent hook). JS side: override `Drupal.meta_conversions_api.allowedCallback`.

## Privacy / operational note (not a code vuln, but state it)
Server-side reporting is invisible to the visitor's browser and cannot be blocked client-side, so
consent has to be enforced in site code via `hook_meta_conversions_api_allowed()`. A hashed email is
still personal data under GDPR. Deploying without consent gating moves tracking beyond the reach of the
site's consent tooling.

## Sub-docs
- `agent/config/settings.md` — the two config objects, keys, routes, permission.
- `agent/api/service.md` — the `sendRequest()` service and the three hooks.
- `agent/events/page_view.md` — how PageView fires and how to add/gate your own events.
