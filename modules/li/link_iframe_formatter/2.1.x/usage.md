Renders a core Link field as an embedded `<iframe>` (the linked page shown inline) instead of as a clickable anchor, with configurable width, height, CSS class, scrolling and an optional "view the original link" fallback.

---

`link_iframe_formatter` adds one field formatter, `link_iframe_formatter` (label "Iframe Formatter"), for core `link` fields. Select it on a link field's **Manage display** tab and each stored URL is output as `<iframe src="{url}" width height class scrolling frameborder="0" allowfullscreen>` via the `link-iframe-formatter.html.twig` template. The formatter subclasses core's `LinkFormatter`, so it reuses core URL building (`buildUrl()`); the URL is the field value entered by whoever can edit the entity. Five formatter settings — `width` (default 640), `height` (default 480), `class` (extra CSS classes, default empty), `disable_scrolling` (default off → `scrolling="yes"`), and `original` (default off; when on, also prints a "You may view the original link at:" anchor below the frame) — are stored under config schema `field.formatter.settings.link_iframe_formatter`. There is no admin settings page, no permissions, no services and no plugin types: it is a single display formatter. It suits embedding trusted external or internal pages (maps, dashboards, docs, videos, forms) directly in the rendered entity. Because an iframe delegates rendering to the embedded origin, deployments should constrain which hosts may be embedded (field validation and/or a CSP `frame-src` directive) and consider adding a `sandbox` attribute via a template override.

---

- Embed an external web page (dashboard, status page, documentation) inline on a node by pasting its URL into a link field.
- Show a Google Maps / OpenStreetMap embed from a link field without teaching editors iframe markup.
- Display a third-party form (survey, booking widget) inside the entity's own layout.
- Embed a YouTube/Vimeo watch or embed URL as a framed player (`allowfullscreen` is set).
- Render an internal Drupal path (a report, a printable view) inside a framed panel on another page.
- Give editors a URL-only way to embed pages — simpler and safer than allowing raw HTML in a body field.
- Set a fixed iframe size per display mode (e.g. 640×480 default, or a custom width/height) via formatter settings.
- Add CSS classes to the iframe (`class` setting) so a theme or responsive-embed CSS can style/scale it.
- Turn scrolling off (`disable_scrolling`) to produce a fixed, non-scrolling embed frame.
- Offer a graceful fallback by enabling `original`, printing a plain "view the original link" anchor beneath the frame for browsers/CSP that block the embed.
- Provide different iframe sizes per view mode (teaser vs full) by configuring the formatter separately on each display.
- Embed a live preview of a linked page in a moderation/editorial view mode.
- Frame a partner or campaign microsite inside a landing node.
- Embed a calendar (Google Calendar public embed URL) from a link field.
- Show a PDF or slide deck hosted elsewhere by framing its viewer URL.
- Build a "linked resources" content type where each item's URL renders as a live preview iframe.
- Combine with a link field's cardinality to render several framed embeds from one multi-value field.
- Override `link-iframe-formatter.html.twig` in your theme to add a `sandbox`, `loading="lazy"`, `title`, or `referrerpolicy` attribute.
- Migrate away from body-embedded iframe HTML toward a structured link field rendered by this formatter.
- Pair with a Content Security Policy `frame-src` allowlist so only approved hosts actually load.
- Use on an internal-only site to embed intranet tools referenced by URL.
- Replace a hand-maintained block of embed markup with an editor-managed link field.
