<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media oEmbed Provider Markup (media_oembed_provider_markup) — agent index

Replaces core Media's proxied `/media/oembed` iframe with the oEmbed provider's own returned
HTML, per field display. Version **1.0.1**. Core `^10 || ^11`.

## What it is
A single procedural module file (`media_oembed_provider_markup.module`) that hooks core's
`oembed` field formatter. **No PHP classes, no routes, no permissions, no services, no entities,
no admin settings page, no submodules.** Its only configuration surface is one third-party
checkbox on the core `oembed` formatter's display settings.

## Dependencies
Runtime depends on core **Media** (`media`) providing the `oembed` formatter and the
`media.oembed.url_resolver` / `media.oembed.resource_fetcher` services. `.info.yml` declares no
explicit `dependencies:` (core Media is assumed present because the formatter it targets is
core's). No Composer requirements, no libraries.

## What it provides
- **Third-party formatter setting** `provider_markup` (integer/checkbox) on the core `oembed`
  formatter, added via `hook_field_formatter_third_party_settings_form()` +
  `hook_field_formatter_settings_summary_alter()`. Config schema:
  `field.formatter.third_party.media_oembed_provider_markup` (`config/schema/`).
- **Field preprocess override** `hook_preprocess_field()` that, when the setting is on, re-resolves
  the media and swaps the render array for the provider's raw embed HTML.
- **Alter hook** `hook_media_oembed_provider_markup_alter(&$html)` — lets other modules rewrite the
  emitted HTML string before render.

## Solution docs
- [agent/fields/formatter.md](fields/formatter.md) — the `provider_markup` third-party setting,
  the preprocess override, the services used, config schema, and how to enable/operate it.
