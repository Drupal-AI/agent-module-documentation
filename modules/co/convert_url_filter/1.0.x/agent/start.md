<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convert URL Filter (convert_url_filter) — agent index

Single **text-format filter** that rewrites absolute `<a href>` links pointing at internal hosts into
root-relative paths on output (`https://example.com/page` → `/page`). Display-only, irreversible
transform — stored content is unchanged and no links are created from plain text.

- **Dependency:** core `filter` only. No routes, permissions, services, hooks, or Drush commands.
- **Plugin:** `@Filter` id `convert_url_filter` — `ConvertUrlFilter` (`src/Plugin/Filter/ConvertUrlFilter.php`),
  extends `FilterBase`, type `TYPE_TRANSFORM_IRREVERSIBLE`. Injects `request_stack`.
- **Setting:** `filter_hosts` (string; default `""`) — extra bare domains, one per line, no scheme/`www.`.
  Schema in `config/schema/convert_url_filter.schema.yml` (`filter_settings.convert_url_filter`). Settings
  are stored per text format in `filter.format.*`; the module has no dedicated config route.
- **Core support:** `^9 || ^10 || ^11`. Version `1.0.2`.

## How it works
`process()` runs `Html::load()`, builds the host list from `filter_hosts` plus
`requestStack->getMainRequest()->getHttpHost()`, then for each `<a>` with an `href` whose parsed host
(minus `www.`) is in the list, strips the `scheme://user@www.host:port` prefix via `preg_replace` and
`setAttribute('href', …)`. Returns `Html::serialize($dom)`.

## Solution docs
- [Filter plugin & settings](plugins/filter.md) — enable on a text format, `filter_hosts` config, matching/rewrite logic.
