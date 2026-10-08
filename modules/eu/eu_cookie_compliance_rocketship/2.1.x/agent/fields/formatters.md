<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie-Content-Blocker field formatters

The module does **not** register new formatter plugins. Instead
`hook_field_formatter_info_alter` (in `.module`) swaps the *class* and *provider* of three existing
formatters so they attach Cookie Content Blocker's pre_render:

| Existing formatter id | Provided by | Replacement class (`src/Plugin/Field/FieldFormatter/`) |
|---|---|---|
| `iframe_default` | `iframe` module | `CookieBlockedIframe` (extends `IframeDefaultFormatter`) |
| `iframe_only` | `iframe` module | `CookieBlockedIframeOnly` (extends `IframeOnlyFormatter`) |
| `video_embed_field_video` | `video_embed_field` module | `CookieBlockedVideo` (extends `Video`) |

So these formatters only exist when the `iframe` / `video_embed_field` modules are installed; the alter
is a no-op otherwise (guarded by `isset($info[$id])`).

## Common mechanism

Each subclass calls `parent::viewElements()` and then, per delta, appends the pre_render callback
`cookie_content_blocker.element.processor:processElement` and sets
`#cookie_content_blocker => TRUE`. At render, Cookie Content Blocker wraps the element so the iframe/
video is not loaded (and third-party cookies not set) until the visitor consents. The `TODO` comments
in each class note that CCB options (blocked message, button text, etc.) are not yet exposed as
formatter settings — they fall back to CCB's own defaults.

## `CookieBlockedIframe`

Straight pass-through: blocks every delta the parent iframe formatter renders.

## `CookieBlockedIframeOnly`

Adds a `whitelist_hostnames` setting (`defaultSettings()` = `''`; textarea in `settingsForm()`, one
hostname per line; `settingsSummary()` lists them). In `viewElements()`, if the iframe's `#src` host
(`parse_url(..., PHP_URL_HOST)`) is in the whitelist, that delta is **skipped** (left unblocked) — use
it to let trusted embeds through while blocking the rest.

## `CookieBlockedVideo`

Resolves the provider with `providerManager->loadProviderFromInput($item->value)` and only attaches the
blocker when a video provider is recognised (YouTube/Vimeo/etc.), so non-video values render normally.

## Enabling

*Manage display* on the bundle → set the field's format to the underlying formatter (e.g. "Iframe",
"Iframe (only URL)", or the video_embed_field video format). Once this module is enabled the swapped
class runs automatically; no separate "blocked" format appears in the list.
