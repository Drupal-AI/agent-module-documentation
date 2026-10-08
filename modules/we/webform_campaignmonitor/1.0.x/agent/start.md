<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Campaign Monitor (webform_campaignmonitor) — agent index

A single **Webform handler** plugin (`id: campaignmonitor`) that subscribes a submitter to a
**Campaign Monitor** list when a form is submitted. Version **1.0.1**, core `^10.3 || ^11.0`.
Requires **`campaignmonitor`** and **`webform`**.

## What this module actually is

- **One file of logic:** `src/Plugin/WebformHandler/WebformCampaignMonitorHandler.php`. No routes,
  no services, no config schema, no `.module`, no library of its own.
- **It delegates everything Campaign Monitor.** The API key, client ID, the `createsend-php`
  library, list retrieval and the subscribe request all live in the required **`campaignmonitor`**
  module. This handler pulls lists via `campaignmonitor.manager::getLists()` and subscribes via
  `campaignmonitor.subscription_manager::userSubscribe()`.
- **Handler traits:** cardinality **unlimited** (multiple handlers per form), results processed,
  submission required, tokens enabled.

## Configuration (per webform handler)

Settings → Emails / Handlers → Add handler → **CampaignMonitor**:

- **List** (`list`, required) — `webform_select_other`; a configured list or a token.
- **Email field** (`email`, required) — select over the form's `email`-type elements.
- **Control field** (`control`, optional) — a checkbox element; if set and unticked, the handler
  does nothing. This is the **opt-in gate**.
- **Merge vars** (`mergevars`) — token-aware YAML; the `name:` key becomes the subscriber name.
- **Double opt-in** (`double_optin`, default TRUE).

## Runtime behaviour (`postSave`)

1. Skips updates — runs only for a **new** submission.
2. If a control field is configured and its value is empty, returns without subscribing.
3. Token-replaces the configuration, reads the email from submission data, `Yaml::decode()`s the
   merge vars, then calls `userSubscribe($list, $email, $name, $mergevars, $interest_groups,
   $double_optin)`.

## Gotchas

- `$name = $mergevars['name'];` assumes a `name` key — an empty/nameless mergevars block raises a
  PHP warning. Always include `name:` in the YAML.
- `interest_groups` is in `defaultConfiguration()` but has no form control (always `[]`).
- Lists only appear after the campaignmonitor module has run cron to fetch them.

## Solution-type docs

- [handlers/campaignmonitor-handler.md](handlers/campaignmonitor-handler.md) — the handler plugin in detail.
