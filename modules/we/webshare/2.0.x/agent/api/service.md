<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webshare — the `webshare.service` API & the Views field

## WebshareService (`webshare.service`, `src/WebshareService.php`)
Implements `WebshareServiceInterface`. Registered with a `create()` factory so the optional
`plugin.manager.icon_pack` (Icons API) and `logger.factory` are injected only when present.
Dependencies: `config.factory`, `extension.list.module`, `database`, `renderer`, optional icon-pack
manager, optional logger.

### `build(string $url, string $id, array $options = []): array`
Returns a `#type => component`, `#component => webshare:share` render array. Steps:
1. Resolves presentation options from `$options` (validated against allow-lists, falling back to
   defaults): `alignment` (`start`/`end`), `orientation` (`horizontal`/`vertical`),
   `mobile_visibility`, `placement`, `native_share`, plus `share_title`, `share_text`, `heading`.
2. Reads enabled platforms from the `webshare_platforms` table
   (`WHERE enabled = 1 ORDER BY weight, name`). If the table is missing or a read fails it logs a
   warning (when a logger is present) and falls back to the legacy `webshare.settings:buttons`
   config.
3. For each platform, builds the share URL by substituting `[url]` (→ `rawurlencode($url)`) and
   `[title]` (→ `rawurlencode($options['share_title'])`) into `url_template`; an empty template
   yields `#` (copy-to-clipboard). Resolves the icon: Icons-API markup via `renderIconHtml()` when
   mapped and the pack is registered, otherwise the bundled/absolute `<img>` src.
4. Assembles `#props` for the SDC (url, share_title, share_text, ids, layout options, native icon,
   `platforms[]`) and sets `#cache` — tags merged with `['webshare_platforms']`, context `['url']`.

### `renderIconHtml($reference): string`
Renders `#type: icon` (`#pack_id`, `#icon_id`) via `renderer->renderInIsolation()` when the Icons
API manager is available and the pack is registered; returns `''` otherwise so callers fall back to
the bundled SVG.

### Interface (`WebshareServiceInterface`)
`build($url, $id, array $options = [])`. `$options` documents: `heading`, `alignment`,
`orientation`, `mobile_visibility`, `placement`, `native_share`, `share_title`, `share_text`.

## Views field `webshare_field` (`src/Plugin/views/field/WebshareField.php`)
A `FieldPluginBase`, `@ViewsField("webshare_field")`. `webshare.views.inc` (`hook_views_data`)
exposes it on the `node` table, and on `commerce_product` when that module is enabled. `render()`
takes the row entity, derives the absolute canonical URL and a `<entityType><id>` DOM id, and
returns `WebshareService::build($url, $id)` — so each listed row gets its own share rail. Inject:
`webshare.service`.
