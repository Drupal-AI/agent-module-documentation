<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GDPR One Trust Implementation (gdpr_onetrust) — agent index

Injects the **OneTrust** consent SDK `<script>` tags into the page `<head>` from an account UUID,
and ships **`onetrust_cookie_blocking`**, which reassigns Drupal-attached JS into OneTrust's
`Optanon.InsertScript`/`InsertHtml` queue so scripts load only after the matching category is
consented to. Depends on core `menu_link_content`. Configure at
`/admin/config/system/gdpr-onetrust`. Version **2.1.0**. Core `^10 || ^11`.

## Mechanism (main module)
- **`gdpr_onetrust_page_attachments()`** (`gdpr_onetrust.module`) builds the loader `<script>`(s)
  and adds them to `#attached['html_head']`. The account id is a UUID validated against
  `GDPR_ONETRUST_UUID_REGEX` (`8-4-4-4-12` hex, optional `-test` suffix).
  - **v1** (`gdpr_onetrust_version == 1`): one tag, `src = //cdn.cookielaw.org/consent/{uuid}.js`.
    A `-test` UUID switches the host to `https://optanon.blob.core.windows.net/consent/`.
  - **v2**: `otSDKStub.js` from `https://cdn.cookielaw.org/scripttemplates/otSDKStub.js` with
    `data-domain-script={uuid}` and `data-document-language="true"`; and, only when
    `gdpr_autoblock_js == 1`, `OtAutoBlock.js` from `https://cdn.cookielaw.org/consent/{uuid}/OtAutoBlock.js`.
- **Per-language UUID.** On a single-language site the key is `gdpr_onetrust_compliance_uuid`;
  otherwise it is `gdpr_onetrust_compliance_uuid_{langcode}`. `hook_config_schema_info_alter()`
  adds a schema mapping entry for each language's key at runtime.
- **`gdpr_onetrust_preprocess_page()`** attaches library `gdpr_onetrust/gdpr-onetrust-api`.
  **Note:** the main module ships **no `.libraries.yml`**, so this library does not exist and
  Drupal logs a "non-existent library" error on every page. It is inert, not a blocker — the
  actual OneTrust script is added by `page_attachments`, not by this library.
- **Blocks** (`src/Plugin/Block/`): `onetrust_footer` (**One Trust Cookie Settings** — a
  `#ot-sdk-btn` button on v2, `.optanon-toggle-display` link on v1) and `onetrust_header`
  (**One Trust Cookie Table** — `<div id="ot-sdk-cookie-policy">` on v2,
  `<div id="optanon-cookie-policy">` on v1). Both render an `inline_template` with `max-age: 0`.
- **`hook_install()`** creates a "Cookie Settings" menu link (uri `internal:/<front>`) in the
  `account` menu — a placeholder you retarget to `.optanon-show-settings`.
- **Permission** is literally `One Trust Access` (with a space and capitals — a human-readable
  string used as the machine name), `restrict access: TRUE`. It gates both the main and submodule
  config routes.

## Submodule `onetrust_cookie_blocking`
The compliance-critical half — holds scripts back until consent. Details in
[submodules/onetrust_cookie_blocking.md](submodules/onetrust_cookie_blocking.md).

## Verify rather than assume
- **Which scripts are actually blocked.** Only JS listed line-by-line in the submodule's
  `external_js_cookie` config (`path|category`), plus GA (when `google_analytics` is enabled) and
  `youtube`/`socialpollencount` iframes in node bodies, are governed. Anything else stays free.
- **Caching.** Consent is per-visitor; a page cached with a script tag in it serves it to everyone.
- **v1 is legacy Optanon.** Choose v2 for current OneTrust accounts; the config and block markup
  differ per version.

See [configure/settings.md](configure/settings.md) and
[submodules/onetrust_cookie_blocking.md](submodules/onetrust_cookie_blocking.md).
