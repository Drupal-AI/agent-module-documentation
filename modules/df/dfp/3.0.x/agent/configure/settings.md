# DFP — configuration

## Global settings — `dfp.settings` (form `dfp.admin_settings`, `/admin/structure/dfp/settings`)

| Key | Type | Meaning |
|---|---|---|
| `network_id` | string (**required**) | Google network ID; prepended to every ad unit. Should begin with `/`. |
| `adunit_pattern` | string | Default ad unit pattern (tokens allowed) used when a tag has no `adunit`. Validated by `TagInterface::ADUNIT_PATTERN_VALIDATION_REGEX` (letters, numbers, hyphens, dashes, periods, slashes, tokens). |
| `click_url` | string | Sync-mode-only click URL for click interception/reporting. Cannot be set together with `async_rendering` (form validation error). |
| `async_rendering` | bool (default true) | `enableAsyncRendering()` vs `enableSyncRendering()`. |
| `disable_init_load` | bool | Async-only: `disableInitialLoad()`; forced false when async is off. |
| `single_request` | bool (default true) | `enableSingleRequest()`. |
| `default_slug` | string | Label shown above ads (e.g. "Advertisement"); `<none>` for none. |
| `collapse_empty_divs` | int 0/1/2 | 0 never, 1 collapse-if-empty (`collapseEmptyDivs()`), 2 expand-if-served (`collapseEmptyDivs(true)`). |
| `hide_slug` | bool (default true) | Hide the slug when no ad is served. |
| `targeting` | sequence of `{target, value}` | Global key/value targeting → `googletag.pubads().setTargeting()`. |
| `adtest_adunit_pattern` | string | Ad unit pattern used for every slot when `?adtest=true` is on the URL (campaign preview). |

Defaults ship in `config/install/dfp.settings.yml`; schema in `config/schema/dfp.schema.yml`.

## Ad tag entity — `dfp_tag` (config entity `dfp.tag.*`, `Drupal\dfp\Entity\Tag`)

Managed at *Structure › DFP Ad Tags* (`entity.dfp_tag.collection`); add/edit/delete forms all require
`administer DFP`. Exported fields:

- `id` — machine name.
- `slot` — human-readable ad slot name (also the entity label).
- `size` — comma-separated sizes, e.g. `300x600,300x250`; out-of-page uses `0x0`.
- `adunit` — per-tag ad unit pattern (tokens allowed); overrides the global `adunit_pattern`.
- `slug` — per-tag slug override; `<none>` for none, empty to use the default.
- `block` (bool, default true) — expose this tag as a placeable Drupal block (a `TagBlock`
  derivative). Placement is done in the core Block layout UI.
- `short_tag` (bool, default false) — render a JavaScript-free image link (`dfp-short-tag`) instead of
  a GPT slot, for use in email.
- `breakpoints` — sequence of `{browser_size, ad_sizes}` for responsive size mapping.
- `targeting` — per-tag `{target, value}` pairs (merged with global targeting).
- `adsense_backfill` — `{ad_types, channel_ids, color:{background,border,link,text,url}}` for AdSense
  fallback when DFP inventory is empty.

`Tag::postSave()` clears the block plugin definition cache so block derivatives update.

## How a tag reaches the page

The tag's view builder adds a `dfp_slot` attachment. The decorator service
`dfp.html_response.attachments_processor` (`DfpHtmlResponseAttachmentsProcessor::processAttachments`)
collects those attachments and injects, into `<head>`: the GPT loader (`dfp-js-head-top`), a
`googletag.defineSlot(...)` block per tag (`dfp-slot-definition-js`), and a settings + global
targeting block (`dfp-js-head-bottom`). See [../theming/templates.md](../theming/templates.md).

## Ad-test / preview

- Admin test page: `dfp.test_page` at `/admin/structure/dfp/test_page` (requires `administer DFP`).
- Append `?adtest=true` to any front-end URL to swap all ad units to `adtest_adunit_pattern` so a
  campaign can be trafficked to a preview without touching real inventory.

## Permission

Single permission **`administer DFP`** (`dfp.permissions.yml`) — create/edit/delete ad tags and
configure how/when they display. It is the `admin_permission` of the `dfp_tag` entity and the
requirement on every route in `dfp.routing.yml`. Grant only to trusted ad-ops editors.
