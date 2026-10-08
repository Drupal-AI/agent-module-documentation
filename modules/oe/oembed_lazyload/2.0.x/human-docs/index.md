# oEmbed lazy load — manual setup guide

**oEmbed lazy load** (`oembed_lazyload`) defers loading of embedded third‑party
media — YouTube, Vimeo, and other oEmbed providers — until the visitor actually
needs it. Instead of dropping a heavy provider iframe onto the page immediately
(with all its scripts, cookies, and third‑party requests), it shows a lightweight
thumbnail placeholder and only swaps in the real embed when the video scrolls into
view or when the visitor clicks a play button. The result is faster page loads,
better Core Web Vitals / Lighthouse scores, less layout shift, and a more
privacy‑friendly page that doesn't contact the provider until the user engages.

The module works through a **field formatter** called "Lazy load oEmbed video"
(`lazyload_oembed`), which you apply to a field that holds an oEmbed resource URL —
a `link` field, or a plain text field. When rendered, the formatter resolves the
oEmbed resource, draws a placeholder (provider name, title, thumbnail) from
overridable Twig templates, and loads the real iframe on demand. The iframe is
served through a signed, access‑checked route so only legitimate placeholder‑
generated URLs resolve.

Because everything is configured on the field formatter, there is **no global
settings page**. You choose two behaviours per field: a **loading strategy**
(load when the embed enters the viewport, or load on click) and optional
**maximum width/height**. Advanced customization is available through a per‑
provider "enhancer" plugin system and full theming control, and the optional
`oembed_lazyload_youtube` submodule adds YouTube‑specific player options.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the YouTube submodule.

## Where it lives in the admin menu

The module adds no settings page of its own. Its formatter appears in the formatter
dropdown on each bundle's **Manage display** page (for example
`/admin/structure/types/manage/article/display`), for eligible fields.

## How to use it

1. Have a field that stores a video/oEmbed URL — a **link** field or a text field
   containing the provider URL.
2. Go to the bundle's **Manage display** (`/admin/structure/…/display`), and for
   that field choose the **Lazy load oEmbed video** formatter.
3. Click the formatter's gear icon to set:
   - **Strategy** — *Intersection observer* (default) loads the embed when it
     scrolls into view; *On click* loads it only when the visitor clicks the play
     button.
   - **Intersection observer margin** — an optional root margin (for example
     `20px` or `4%`) that starts loading slightly before the embed enters the
     viewport. Used only with the intersection‑observer strategy.
   - **Max width / Max height** — optional pixel caps on the embed size (0 means
     unset).
4. Save the display. Visitors now see a thumbnail placeholder that loads the real
   embed on scroll or click.

For YouTube‑specific player options (autoplay, modest branding, related‑video
behaviour), enable the `oembed_lazyload_youtube` submodule.
