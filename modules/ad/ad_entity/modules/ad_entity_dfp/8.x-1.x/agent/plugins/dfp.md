<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DFP (Google Ad Manager) type & view handlers

Enable with `drush en ad_entity_dfp -y` (requires `ad_entity`). Configure under
`administer ad_entity`.

## `dfp` AdType (`DFPType`)

### Global settings (`globalSettingsForm`)
- `order_info` (bool, default on) — add `slotNumber` / `onPageLoad` targeting.
- `change_correlator` (`default` / always-new / never) — GPT correlator behavior; stored as bool
  or cleared for `default`.

### Per-ad settings (`entityConfigForm`, third-party settings)
- `network_id` (required), `unit_id` (required) — the DFP slot is `/{network_id}/{unit_id}`.
- `out_of_page` (bool) — out-of-page slot (disables the size field).
- `sizes` — user enters `300x600,300x250` (and/or `fluid`); `entityConfigSubmit()` parses into a
  validated list where numeric pairs become `[[300,600],…]` and only the named size `fluid`
  (`isValidNamedSize()`) is accepted, then `Json::encode`s it. Non-numeric/invalid tokens are
  dropped.
- `targeting` — default per-ad targeting (collection), stored under
  `third_party.ad_entity_dfp.targeting.targeting`.
- AMP sub-settings (`amp.*`): `width`, `height`, `multi_size_validation`, `same_domain_rendering`,
  `consent.block_behavior` + `consent.npa_unknown`, and `rtc_config` (`vendors.vendor_items`,
  `urls`, `timeoutMillis`).

## AdView handlers

| Plugin id | container | Notes |
|---|---|---|
| `dfp_default` | `html` | `requiresDomready=false`, lib `ad_entity_dfp/default_view`. `#theme dfp_default`. |
| `DFPIframe` | `iframe` | GPT runs inside the iframe `srcdoc`. `#theme dfp_iframe`. |
| `DFPFia` | `fia` | Facebook Instant Articles variant. |
| `DFPAmp` | `amp` | `<amp-ad type="doubleclick">`; `blockOnConsentOptions()` supplies allowed consent values. `#theme dfp_amp`. |

## Rendering (theme preprocess)

- `template_preprocess_dfp_default()` (`ad_entity_dfp.theme.inc`): `Attribute` with random id +
  `data-dfp-network` / `data-dfp-unit` / `data-dfp-out-of-page` (escaped via `setAttribute`);
  passes `sizes` (the validated JSON) to the template (`<div … data-dfp-sizes='{{ sizes|raw }}'>`);
  attaches `ad_entity/provider.googletag`.
- `template_preprocess_dfp_iframe()` (`.iframe.inc`): inlines `ad_entity/base`, sets
  `slot_id = /network/unit`, filters + JSON-encodes targeting, and the `srcdoc`
  (`templates/dfp-iframe.html.twig`) loads GPT, defines the slot with `sizes|raw` (validated pairs)
  and applies targeting.
- `template_preprocess_dfp_amp()` (`.amp.inc`): builds the `<amp-ad>` attributes (`data-slot`,
  `width`, `height`, `data-multi-size`, consent flags), a `json` blob (targeting +
  `useSameDomainRenderingUntilDeprecated`) and an `rtc-config` blob; the template encodes both with
  `JSON_HEX_*`.

## Frontend wiring

`hook_page_attachments()` attaches the external Google Publisher Tag library
(`ad_entity/provider.googletag` → `//securepubads.g.doubleclick.net/tag/js/gpt.js`) and, when
`tweaks.include_preload_tags` is on, a GPT preload tag — only on non-admin routes and only when a
`dfp_default` ad is actually used on the page (`AdEntityUsage::getCurrentlyUsedAdViewPlugins()`).
`order_info`/`change_correlator` are passed via `drupalSettings`.

## Update

`ad_entity_dfp_post_update_fix_actions_config()` removes a stale
`amp.rtc_config.vendors.actions` key from existing DFP ad entities (run `drush updb`).
