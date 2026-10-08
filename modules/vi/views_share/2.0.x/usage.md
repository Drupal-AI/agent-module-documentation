<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Share lets you embed and share a Views display externally: it adds a "share" Views area handler and a set of routes that render a display as a standalone embeddable page, an oEmbed document, an iframe snippet, and a share modal.

---

The routes hang off `/view/{view_id}/{display_id}/{share|embed|oembed|preview}` and are all gated by `access content`. `ViewsShareController` builds a bare HTML page for embedding (`buildViewResponse`), returns oEmbed JSON/XML, and opens a modal share form; a `ViewsShareHelper` produces the embed URL/HTML/iframe code. Optional per-view share options (from the area handler) control iframe size, link rewriting, and hiding of header/footer/attachment handlers. Contextual view arguments can be passed via a `views_share_args` query parameter.

Setup: add the "Share" area handler to a view display's header/footer, configure embed options, then use the generated embed/oEmbed URLs.

---
- Embed a View display in another website via iframe.
- Provide an oEmbed endpoint for a View.
- Offer visitors a "share this view" modal.
- Generate ready-to-paste embed HTML.
- Preview how an embedded view will look.
- Pass contextual filter arguments through `views_share_args`.
- Control iframe width/height for embeds.
- Hide header/footer handlers in the embedded output.
- Disable attachment displays when embedding.
- Rewrite links inside embedded views to absolute URLs.
- Return oEmbed data as JSON or XML.
- Add the Share area handler to a view.
- Syndicate a listing to partner sites.
- Expose a public data view for embedding.
- Produce provider metadata (name/url) in oEmbed.
- Build a bare HTML page for a single view display.
- Restrict embeddable views via each view's access settings.
- Share a filtered result set by URL.
