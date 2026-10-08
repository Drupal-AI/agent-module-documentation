<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming oEmbed lazy load

## Theme hooks (`oembed_lazyload_theme()`)

| Hook | Template | Variables |
|---|---|---|
| `oembed_lazyload` | `oembed-lazyload.html.twig` | `strategy`, `provider`, `placeholder`, `iframe` |
| `oembed_lazyload_placeholder` | `oembed-lazyload-placeholder.html.twig` | `url`, `thumbnail`, `title`, `provider`, `settings`, `third_party_settings` |
| `oembed_lazyload_help` | `oembed-lazyload-help.html.twig` | (help page) |

## Per-provider template suggestions

`hook_theme_suggestions_HOOK()` adds a provider-specific suggestion so you can theme one provider
without affecting others (provider name is lower-cased):

- `oembed_lazyload__<provider>` (e.g. `oembed_lazyload__youtube`)
- `oembed_lazyload_placeholder__<provider>` (e.g. `oembed_lazyload_placeholder__youtube`)

Create `oembed-lazyload-placeholder--youtube.html.twig` in your theme to override just YouTube
placeholders. (The `oembed_lazyload_youtube` submodule registers
`oembed_lazyload_placeholder__youtube` with base hook `oembed_lazyload_placeholder`.)

## Libraries (`oembed_lazyload.libraries.yml`)

| Library | Contents |
|---|---|
| `oembed_lazyload/common` | base CSS (`oembed-lazyload.css`, `oembed-lazyload-style.css`) |
| `oembed_lazyload/onclick` | `js/onclick.js` (play-button strategy) |
| `oembed_lazyload/intersection-observer` | `js/intersection-observer.js` (viewport strategy) |

The formatter attaches `common` plus the library matching the chosen `strategy`; enhancers can
add more via `getLibraries()`. All the markup is override-friendly Twig, so styling and the
placeholder layout are controlled entirely from your theme.
