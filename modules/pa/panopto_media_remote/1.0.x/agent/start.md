<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Panopto Media Remote (panopto_media_remote) — agent index

Adds **Panopto** (lecture-capture / video platform) as a provider for the **`media_remote`** module, so
a Panopto recording is referenced as a media entity **by URL** and rendered as an `<iframe>` embed. The
whole module is **one field formatter** (`panopto`) plus the theme hook it renders through — it defines
**no media source of its own**: the source is `media_remote`'s `Remote Media URL` source, and this module
only contributes the display formatter that plugs into it. You build a media type on that source, then set
this formatter on the media type's **default** view display; `media_remote` validates the stored URL against
this formatter's regex at save time, and the formatter emits an iframe pointing at the (unchanged) URL.

The formatter (`src/Plugin/Field/FieldFormatter/PanoptoFormatter.php`) extends
`media_remote`'s `MediaRemoteFormatterBase`. Its `getUrlRegexPattern()` accepts only
`https://…​.panopto.<tld>/Panopto/Pages/(Embed|Viewer)[.aspx]?id=…`, `viewElements()` builds a
`#theme => 'panopto'` render array, and `templates/panopto.html.twig` prints the `<iframe>`. There is **no
server-side HTTP** at all — no oEmbed/thumbnail/metadata fetch; the browser loads the iframe.

- Depends on: **`media_remote:media_remote`** (`drupal/media_remote:^1.9`). Package: **Media**.
- Core: `^8 || ^9 || ^10 || ^11`. Installed/verified at **1.0.1** on Drupal 11.x.
- **No settings page / `configure` route.** Formatter options (iframe `width`/`height`) are set per view
  display in Field UI *Manage display*. No permissions, no services, no routes, no drush, no config schema,
  no new plugin types.
- Note: `media_remote` already ships its **own** `media_remote_panopto` formatter; this module's `panopto`
  formatter is a separate, more strictly-anchored alternative (see plugins topic).

## What you'd do → where

- **Set up a Panopto media type and turn this formatter on / the whole install pipeline** →
  [plugins/media-source.md](plugins/media-source.md)
- **The `panopto` formatter — id, settings (`width`/`height`), URL regex, the iframe template** →
  [fields/formatters.md](fields/formatters.md)

## Key facts (real machine names)

- Field formatter: **`panopto`** (label "Remote Media - Panopto", `field_types: ["string"]`,
  `PanoptoFormatter`, extends `Drupal\media_remote\…\MediaRemoteFormatterBase`).
- Formatter settings: `width` (default `640px`), `height` (default `480px`) — plus inherited
  `formatter_class`. Both go into the iframe.
- Theme hook: **`panopto`** (`hook_theme` in `.module`; variables `url`, `width`, `height`, `title`),
  template `templates/panopto.html.twig` (renders `<iframe src title width height allow="fullscreen">`).
- URL regex (validated at save time by `media_remote`):
  `/^https:\/\/(?:[a-zA-Z0-9-]+\.)+[a-zA-Z0-9-]+\.panopto\.[a-zA-Z]+\/Panopto\/Pages\/(?:Embed|Viewer)(?:\.aspx)?\?id=([a-zA-Z0-9-]+)/`.
- Valid URL examples: `https://hosted.cloud.panopto.eu/Panopto/Pages/Embed.aspx?id=[id]`,
  `…/Viewer.aspx?id=[id]`.
- Media source used (from the dependency, NOT this module): `media_remote` (label "Remote Media URL").
- Static helpers on the formatter: `getUrlRegexPattern()`, `getValidUrlExampleStrings()`,
  `deriveMediaDefaultNameFromUrl($url)`, `getEmbedUrl($url)` (identity — returns the URL unchanged).
