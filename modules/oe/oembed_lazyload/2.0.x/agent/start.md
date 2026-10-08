<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# oEmbed lazy load — agent index

Defers loading of embedded oEmbed media (YouTube, Vimeo, …) until it enters the viewport or the
user clicks play, showing a thumbnail placeholder until then. Provides a field formatter and a
per-provider enhancer plugin type. Requires core `media`. No global settings page (`configure`
is `null`) — configuration lives in the formatter on a view display.

- **The `lazyload_oembed` formatter + its settings (strategy, sizes, margin)** →
  [configure/formatter.md](configure/formatter.md)
- **The `ProviderEnhancer` plugin type (customise per provider)** →
  [plugins/provider-enhancer.md](plugins/provider-enhancer.md)
- **Theme hooks, per-provider template suggestions, libraries** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Formatter id `lazyload_oembed` ("Lazy load oEmbed video"), field types `link`, `string`,
  `string_long`. Settings: `max_width`, `max_height`, `strategy`
  (`intersection_observer` default | `onclick`), `intersection_observer_margin`. Stored under
  `core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>.type` = `lazyload_oembed`,
  `.settings`. Schema: `field.formatter.settings.lazyload_oembed`.
- Plugin type: `ProviderEnhancer` — manager service `oembed_lazyload`, dir
  `Plugin/oembed_lazyload/ProviderEnhancer`, annotation `@ProviderEnhancer(id, label, providers)`.
  Base `ProviderEnhancerBase`; `fallback` enhancer handles unmatched providers. Alter hook
  `hook_oembed_lazyload_alter` (manager `alterInfo('oembed_lazyload')`).
- Iframe served via a route guarded by `oembed_lazyload.iframe_access_checker` +
  `IframeUrlHelper` (signed hash). Services in `oembed_lazyload.services.yml`.
- Submodule `oembed_lazyload_youtube` adds a YouTube enhancer with player options.
