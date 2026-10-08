<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# carryquery — internals

## Configuration
- Config object `carryquery.settings` (schema in `config/schema/carryquery.schema.yml`).
- Keys: `carryqueryconfig` (raw textarea text), `js` (bool — carry via JS instead of server-side), `keys` (sequence of parameter names), `info` (per-key pipe-split rule rows).
- Set by `QredirectConfig::submitForm()`: textarea is `Html::escape`d, split on newlines, each line split on `|`; first field of each line becomes a carried key.

## Carry mechanisms
- **Outbound path processor** (`CarryQueryPathProcessor`, tag `path_processor_outbound`): on `processOutbound`, if `js` is off, it intersects configured `keys` with the current request's query keys and sets `$options['query'][$key] = $request->query->get($key)` — so internal URL generation carries the params. Adds `url.query_args` cache context. Returns when `js` is on (JS mode handles it client-side instead).
- **Path processor manager decorator** (`CarryQueryPathProcessorManager`): decorates core `path_processor_manager` (priority 10), autowired with `#[AutowireIterator(tag: 'path_processor_inbound')]` / `path_processor_outbound` and `@request_stack`. Overrides `processOutbound` to inject the current request when none is passed, so the outbound processor can read query params during URL generation. This decorator + attribute wiring is the D11-era modernization in the 2.x major.
- **`hook_form_alter`**: for `#method == 'get'` forms, adds a `#type => hidden` element (`#value => $request->get($key)`) for each configured key present in the request.
- **JS** (`carryquery.js`): when `js` config is on, `page_attachments` ships `keys`/`js` in `drupalSettings`; the behavior appends configured params to same-host, non-anchor `<a>` hrefs after render.
- **Link tokens** (`hook_token_info` / `hook_tokens`): `[link:route:<name>,id=,class=,text=]` and `[link:path:<internal/path>,…]` render an anchor via `Link::fromTextAndUrl()` (built from `Url::fromRoute` / `Url::fromUserInput`). Adds `url.query_args` cache context. Intended for CKEditor content (which the path processor does not rewrite).

## Routing / access
- Single route `carryquery.config` → `QredirectConfig` form, `_permission: administer site configuration`. No other routes; no custom permissions; menu link `carryquery.admin` under `system.admin_config_search`.

## Dependencies
- `drupal:filter`, `token:token`, `token_filter:token_filter`.
