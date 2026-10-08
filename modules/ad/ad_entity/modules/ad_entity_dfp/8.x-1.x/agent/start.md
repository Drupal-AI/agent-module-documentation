<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertising Entity: DFP (ad_entity_dfp) — agent index

Google Doubleclick for Publishers / Ad Manager provider for `ad_entity`. Submodule of
**ad_entity**. Depends on `ad_entity`. Package `Advertising`. Core `^9 || ^10 || ^11`.
GPL-2.0-or-later. Version 8.x-1.6 (dir `8.x-1.x`).

- **The `dfp` AdType + default/iframe/AMP AdView handlers, sizes, AMP/RTC options** →
  [plugins/dfp.md](plugins/dfp.md)

## What it provides (from source)

- **1 AdType:** `dfp` (`src/Plugin/ad_entity/AdType/DFPType.php`). Per-ad settings: `network_id`,
  `unit_id`, `sizes` (JSON of `[w,h]` pairs / `fluid`), `out_of_page`, `targeting`, plus `iframe`
  and `amp` sub-settings (AMP width/height, `multi_size_validation`, `same_domain_rendering`,
  `consent.block_behavior`/`npa_unknown`, `rtc_config` vendors/urls/timeout). Global settings:
  `order_info`, `change_correlator`.
- **4 AdView handlers** (`src/Plugin/ad_entity/AdView/`): `dfp_default` (`container=html`,
  `requiresDomready=false`, lib `ad_entity_dfp/default_view`), `DFPIframe` (`container=iframe`),
  `DFPFia` (`container=fia`), `DFPAmp` (`container=amp`; `DFPAmp::blockOnConsentOptions()`).
- Theme hooks `dfp_default` / `dfp_iframe` / `dfp_amp` (`ad_entity_dfp.theme.inc`,
  `.iframe.inc`, `.amp.inc`); templates in `templates/` (`<div>` w/ `data-dfp-*` attrs; a GPT
  `srcdoc` iframe; `<amp-ad type="doubleclick">`).
- Config schema `config/schema/ad_entity_dfp.schema.yml` (third-party settings incl. AMP + RTC);
  `hook_config_schema_info_alter()` adds `ad_entity.settings:dfp` (`order_info`,
  `change_correlator`).
- `hook_ad_entity_module_info()`: `personalization: TRUE`, `consent_aware: TRUE`.
  `hook_page_attachments()` attaches `ad_entity/provider.googletag` (external GPT) + optional GPT
  preload on non-admin routes when a `dfp_default` ad is used
  (`AdEntityUsage::getCurrentlyUsedAdViewPlugins()`), and passes `dfp_order_info` /
  `dfp_change_correlator` to `drupalSettings`.
- `ad_entity_dfp.post_update.php` cleans a stale `amp.rtc_config.vendors.actions` key.

## Routes / permissions

No own routes. Ads and global DFP settings are configured through ad_entity's admin UI, gated by
**`administer ad_entity`**. No `*.permissions.yml`.

## Security note

Reviewed adversarially — no finding. All per-ad values (network/unit ids, sizes, AMP attrs) are
admin-authored (`administer ad_entity`) and emitted via `Attribute::setAttribute()` (escaped) or,
for sizes, re-encoded from validated numeric pairs; targeting is filtered
(`TargetingCollection::filter()`) and JSON-encoded (`JSON_HEX_*`). The GPT library loads
client-side (no server-side fetch → no SSRF/TLS surface).
