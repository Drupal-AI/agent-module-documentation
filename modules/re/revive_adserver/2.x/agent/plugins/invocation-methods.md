<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# InvocationMethodService plugins (the ad-tag markup)

A custom plugin type decides *how* a zone is emitted. Both the block and the field resolve a
method, feed it a zone id + options, call `prepare()` then `render()`.

## Plugin type wiring

- Annotation: `src/Annotation/InvocationMethodService.php` — fields `id`, `label`, `weight`.
- Manager: `InvocationMethodServiceManager` (service
  `plugin.manager.revive_adserver.invocation_method_service`, extends `DefaultPluginManager`,
  ctor arg `@config.factory`). Discovery dir `Plugin/ReviveAdserver/InvocationMethod`,
  interface `InvocationMethodServiceInterface`, alter hook
  `revive_adserver_invocation_method_service_info`. Definitions are sorted by `weight`.
- Base: `InvocationMethodServiceBase` (extends `PluginBase`) — holds zoneId / blockBanner /
  blockBannerCampaign / width / height, plus helpers:
  - `getReviveDeliveryPath()` → `'//' . config('revive_adserver.settings').delivery_url`
  - `getReviveId()` → `md5(delivery_url . '*' . delivery_url_ssl)` (Revive's async-JS id).
  - `prepare()` → loads the zone from config via `getZoneFromConfig()` and sets width/height.
  - `getUniqueId()`, `getLinkHref()` (`ck.php`), `getImageSrc()` (`avw.php`) — fallback markup.

Manager helpers used by the UI: `getInvocationMethodOptionList()` (id→label),
`getZonesOptionList()` (zone id→name), `loadInvocationMethodFromInput($id)`.

## The three plugins (`src/Plugin/ReviveAdserver/InvocationMethod/`)

### `async_javascript` — "Asynchronous JS Tag" (weight 0, default)
`AsyncJavascript::render()` builds a render array (no raw markup):
- `#type => html_tag`, tag **`ins`**, attributes `data-revive-zoneid` = zone id,
  `data-revive-id` = `getReviveId()`, class `revive-adserver-async-js`; adds
  `data-revive-block` / `data-revive-blockcampaign` when the block-banner options are set.
- A `<script async src="//<delivery_url>/asyncjs.php">` tag.
- Cache tag `config:revive_adserver.settings`. All values are `html_tag` **attributes → auto-escaped**.

### `iframe` — "iframe Tag" (weight 5)
`Iframe::render()` emits an `<iframe>` (`html_tag`) whose `src` = `getIframeSrc()` =
`//<delivery_url>/afr.php?zoneid=<id>&amp;cb=<Crypt::randomBytesBase64()>`, sized from the
synced zone width/height (Revive stores omitted dims as `-1`, so only `> 0` are applied), with a
nested `<a><img src=avw.php…></a>` fallback. `max-age = 0` (random cache-buster each render).
`src`/`href` are attributes → auto-escaped.

### `javascript` — "Javascript Tag" (weight 10, legacy)
`Javascript::render()` builds the classic OpenX/Revive `document.write` snippet as a **string**
and wraps it in `Markup::create($script)` as the `#value` of a `<script>` tag (plus a
`<noscript>` `<a><img></a>` fallback; cache tag `config:revive_adserver.settings`). The string
interpolates `getReviveDeliveryPath()` (from admin config) and the zone id (with optional
`&amp;block=1` / `&amp;blockcampaign=1`). The zone id is an **integer** in every path that feeds
it (see below), and the delivery URL is administrator-only config — so the interpolated values
are not attacker-controllable.

## Who controls the inputs

- **Delivery URL / publisher id / zone catalog**: `revive_adserver.settings`, editable only with
  `administer revive_adserver`.
- **Zone id**: block config (`ReviveAdserverZoneBlock`) or field value (`ReviveItem`). The field
  type's `zone_id` property/column is **`int`** and the widget uses a `number`/`select` element;
  the block config schema types `zone_id` as `integer`. So the zone id is numeric everywhere it
  reaches an invocation method.
- **Invocation method**: chosen from `getInvocationMethodOptionList()` (a fixed select of the
  three plugin ids) in the block config, formatter settings, or per-entity field value.

## Adding a method

Create a class in `src/Plugin/ReviveAdserver/InvocationMethod/` extending
`InvocationMethodServiceBase`, annotate `@InvocationMethodService(id, label, weight)`, implement
`render()` returning a render array. It is picked up automatically and appears in every method
select.
