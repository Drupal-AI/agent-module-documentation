<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# gdpr_onetrust — configure the OneTrust loader

Route `gdpr_onetrust.settings` → **`/admin/config/system/gdpr-onetrust`**
(Configuration → Development → "GDPR compliance"). Form
`Drupal\gdpr_onetrust\Form\GDPROneTrustForm` (a plain `FormBase`, config
`gdpr_onetrust.settings`). Permission: **`One Trust Access`** (`restrict access: TRUE`).

## Fields
| Field | Config key | Notes |
|---|---|---|
| UUID for the language – `<name>` | `gdpr_onetrust_compliance_uuid` (single-language) **or** `gdpr_onetrust_compliance_uuid_<langcode>` (multilingual) | One textfield **per interface language**. The OneTrust account/data-domain-script id. Validated on save against `GDPR_ONETRUST_UUID_REGEX` = `^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}(-test)?$` (case-insensitive). |
| GDPR OneTrust Version | `gdpr_onetrust_version` | `1` (legacy Optanon) or `2` (current OneTrust SDK). Changes both the loader tags and the block markup. |
| Enable OneTrust autoblock JS | `gdpr_autoblock_js` | Checkbox (`1`/`0`). **v2 only.** When on, also injects `OtAutoBlock.js`. Tick it only if auto-blocking is enabled in the OneTrust console. |

`config/schema/gdpr_onetrust.schema.yml` defines `gdpr_onetrust_version` (string),
`gdpr_autoblock_js` (integer) and `gdpr_onetrust_compliance_uuid` (string); the per-language
`gdpr_onetrust_compliance_uuid_<langcode>` keys are added at runtime by
`hook_config_schema_info_alter()`.

## Single- vs multi-language key selection
`getGdprConfigInfo()` returns TRUE (use the flat `gdpr_onetrust_compliance_uuid` key) only when
there is exactly **one** language **and** that key is already non-null. Otherwise the form reads and
writes the per-language `..._<langcode>` keys. Adding a second language to a site that was
configured single-language means the old flat UUID is no longer read — re-enter it per language.

## The `-test` suffix
A UUID ending in `-test` is accepted by validation and, for **v1**, switches the CDN host from
`//cdn.cookielaw.org/consent/` to the staging blob store
`https://optanon.blob.core.windows.net/consent/`. Use it to point a non-production site at a
OneTrust test script.

## What gets rendered
See `agent/start.md` for the exact `<head>` tags per version. The UUID is emitted into a
`<script>` `src` / `data-domain-script` attribute via a Drupal `html_tag` render element, so it is
attribute-escaped by the render system.

## Companion placements (not on this form)
- **Cookie Settings control:** place the `onetrust_footer` block, or the "Cookie Settings" account
  menu link created at install (retarget it to `.optanon-show-settings` / `#ot-sdk-btn`), or a hand-
  written `<a class="optanon-show-settings">` / `<button id="ot-sdk-btn">`.
- **Cookie table:** place the `onetrust_header` block, or add `<div id="ot-sdk-cookie-policy">`
  (v2) / `<div id="optanon-cookie-policy">` (v1) to your cookie-policy page.

## Gotchas
- No settings page exists until the module is enabled; config is **not** created at install
  (`hook_uninstall` deletes `gdpr_onetrust.settings`). Until a UUID is saved, no OneTrust script is
  emitted at all.
- The submodule adds a second local task tab, "Cookie Blocking", under the same route base — see
  `submodules/onetrust_cookie_blocking.md`.
