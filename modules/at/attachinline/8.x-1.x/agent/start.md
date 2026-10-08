<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach Inline (attachinline) — agent index

Developer utility that lets a render array carry **inline JS/CSS snippets** directly, via new
`js` and `css` keys under `#attached`, without first declaring a `*.libraries.yml` library. There is
no UI, no route, no permission and no block — it is a code-only API. Mechanism: it **replaces the
core `html_response.attachments_processor` service** with a subclass that adds `css`/`js` to the list
of accepted `#attached` types, and **decorates four core asset services** (`asset.resolver`,
`library.discovery`, `asset.js.collection_renderer`, `asset.css.collection_renderer`) so the snippets
flow through the normal asset pipeline: they are collected into `Drupal\attachinline\Asset\AttachedAssets`,
turned into `type => inline` assets, sorted by group/weight, split header/footer, and finally rendered
as `<script>` / `<style>` tags via the unescaped-passthrough class `AttachInlineMarkup`.

The one runtime knob is CSP-related and only matters when `drupal/csp` (^2, suggested) is installed:
each inline `<script>`/`<style>` gets either a **CSP hash** (default) or a **nonce** added to the
page's Content-Security-Policy so `'unsafe-inline'` is not needed — controlled by the single config
key `attachinline.settings:csp-allow-method`. With BigPipe enabled, core's BigPipe processor wraps
attachinline's replacement as its inner processor, so the override still applies (runtime-verified).

- Depends on: nothing (info.yml has no `dependencies`). Suggests `drupal/csp` (composer `suggest`);
  conflicts with `drupal/csp < 1.21`. Optional runtime service `@?csp.nonce`.
- Core: `^10 || ^11 || ^12`. Package: none declared. PHP: none declared. Version `8.x-1.9`.
- No settings form / `configure` route (config is code/drush only), no permissions, no drush, no
  routes, no plugin types, no hooks. Provides a config schema (`attachinline.settings`).

## What you'd do → where

- **Attach an inline `<script>` / `<style>` to a render array; snippet option keys, scope,
  dependencies, ordering** → [api/attached.md](api/attached.md)
- **Call the API from PHP / the `AttachedAssets` + `AttachInlineMarkup` classes / the decorator
  services** → [api/attached.md](api/attached.md)
- **Content-Security-Policy integration: choose hash vs nonce, the `csp-allow-method` config, the CSP
  event subscriber** → [configure/csp.md](configure/csp.md)

## Key facts (real machine names)

- Config object: `attachinline.settings`, key `csp-allow-method` (`hash` default in code, or `nonce`).
  No `config/install` default, no form — set with `drush config:set` / config import.
- Service replacement: `html_response.attachments_processor` →
  `Drupal\attachinline\Render\HtmlResponseAttachmentsProcessor` (extends core; adds `css`/`js` to the
  `#attached` allowlist and throws `\LogicException` for any other `#attached` key).
- Decorator services: `attachinline.asset.resolver_decorator` (`AssetResolverDecorator`, decorates
  `asset.resolver`), `attachinline.asset.library_discovery_decorator` (`LibraryDiscoveryDecorator`,
  decorates `library.discovery`), `attachinline.asset.js.collection_renderer_decorator`
  (`JsCollectionRendererDecorator`, decorates `asset.js.collection_renderer`),
  `attachinline.asset.css.collection_renderer_decorator` (`CssCollectionRendererDecorator`, decorates
  `asset.css.collection_renderer`).
- Event subscriber: `attachinline.csp_subscriber` (`EventSubscriber\CspSubscriber`) on
  `\Drupal\csp\CspEvents::POLICY_ALTER` (priority `-10`).
- Render-array keys added: `#attached['js']` and `#attached['css']` (lists of snippet arrays or plain
  strings). Snippet keys: `data` (required), `scope` (`header`|`footer`, JS only, default `footer`),
  `group`, `weight`, `attributes`, `dependencies`.
- Classes: `Asset\AttachedAssets` + `Asset\AttachedAssetsInterface` (`getJs`/`setJs`, `getCss`/`setCss`,
  `createFromRenderArray`), `Render\AttachInlineMarkup` (unescaped `MarkupInterface`, for known-safe
  strings only).
- Virtual proxy library namespace: `attachinline/<real_library>` (moves a header-scoped snippet's
  dependency into the header; no `*.libraries.yml` file exists — it is synthesized by the decorator).
- CSP directives touched: `script-src` + `script-src-elem` (JS), `style-src` + `style-src-elem` (CSS).
