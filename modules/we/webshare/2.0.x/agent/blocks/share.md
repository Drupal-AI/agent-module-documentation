<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webshare — the `share` Block plugin

`src/Plugin/Block/WebshareBlock.php`, plugin id `share`, admin label "Share". A `BlockBase`
implementing `ContainerFactoryPluginInterface`. Inject: `webshare.service`
(`WebshareServiceInterface`) and `path_alias.manager` (`AliasManagerInterface`).

## Placement
Place via Block layout (Structure → Block layout) into any theme region, or — because the block's
settings schema is `FullyValidatable` — as a Drupal Canvas component on a content template. It is
**not** auto-injected into node display; site builders place it explicitly.

## Settings (`blockForm` / `blockSubmit`; `defaultConfiguration`)
- `heading` — textfield, default `Share`, maxlength 255 (the title shown above the buttons).
- `display_title` — checkbox, default TRUE (when FALSE the heading is suppressed even if set).
- `alignment` — radios `start` / `end` (RTL-aware logical sides), default `end`.
- `orientation` — radios `horizontal` / `vertical`, default `vertical`.
- `mobile_visibility` — radios `all` / `hide_mobile` / `mobile_only` (breakpoint 768px), default
  `all`.
- `native_share` — checkbox, default FALSE (render the native Web Share API button).
- `placement` — radios `inline` / `rail-end` (sticky column beside the content), default `rail-end`.

Persisted config schema: `block.settings.share` in `config/schema/webshare.settings.schema.yml`
(each enum-constrained; `FullyValidatable` for Canvas).

## build()
Computes the share URL from `Url::fromRoute('<current>')->setAbsolute()` and a stable `$id` from the
current path alias (`path_alias.manager`, `/` stripped). Builds `$heading` from
`display_title` + `heading` (empty string suppresses it), then returns
`WebshareService::build($url, $id, $options)` passing `heading`, `alignment`, `orientation`,
`mobile_visibility`, `native_share`, `placement`. The service renders the `webshare:share` SDC —
see [../components/share.md](../components/share.md) and [../api/service.md](../api/service.md).
