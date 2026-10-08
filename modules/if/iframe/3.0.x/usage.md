Iframe adds an "iframe" field type that lets editors embed a complete `<iframe>` (source URL plus width, height, title, and styling attributes) into any fieldable entity without writing HTML.

---

Iframe defines a single `iframe` field type (built on core `field` and `link`) whose stored value is a source URL (up to 2048 chars) accompanied by title text, header level, width, height, CSS class, frameborder, scrolling, transparency, allowfullscreen, and tokensupport. Three widgets let you choose how much the author controls: `iframe_url` (URL only), `iframe_urlheight` (URL + height), and `iframe_urlwidthheight` (URL + width + height, the default). Width and height accept fixed pixels ("500"), percentages ("50%"), or em/rem/vw and vh units, and a special `iframe-responsive` class turns them into an aspect ratio. Four formatters render the value: `iframe_default` (title above the iframe), `iframe_only` (iframe without title), `iframe_asurl` (a plain link with the given title), and `iframe_asurlwithuri` (a link showing the URI). Field-level settings (Manage fields) and widget settings (Manage form display) set defaults for the styling attributes and decide whether editors may override the CSS class (`expose_class`) or use tokens. URLs are validated via core's LinkWidget, and when the Token module is enabled tokens can be allowed in the title and/or URL. Output goes through the themeable `iframe.html.twig` template, with a `headerlevel` (h1–h4) for accessible heading structure and an optional `allowfullscreen` attribute.

---

- Embed a YouTube, Vimeo, or other video player on a content type via an iframe field.
- Embed an external web page, dashboard, or web app inside a node.
- Add a Google Map, calendar, or booking widget as an embedded iframe.
- Give editors a URL-only widget so they cannot change the iframe dimensions.
- Give editors a URL + height widget while keeping width fixed at the field default.
- Give editors full control of URL, width, and height with the default widget.
- Set a fixed pixel width/height (e.g. 600 x 800) as the field or widget default.
- Use percentage sizing (e.g. "100%") so the iframe scales to its container.
- Use em/rem/vw/vh units for width and height.
- Make an iframe responsive with the `iframe-responsive` class, using width/height as a ratio (e.g. 4:3).
- Try same-origin height auto-fitting with the `autoresize` class.
- Show a title heading above the iframe with a configurable header level (h1–h4) for accessibility.
- Render the iframe with no title using the `iframe_only` formatter.
- Render the value as a plain link instead of an embed using the `iframe_asurl` formatter.
- Render the value as a link that displays the URI with the `iframe_asurlwithuri` formatter.
- Remove or show the frameborder around the embed.
- Enable, disable, or auto scrollbars for the iframe content.
- Allow CSS transparency on the outer iframe tag.
- Enable or disable the `allowfullscreen` attribute so embedded players can go fullscreen.
- Let authors add their own CSS class per iframe by exposing the class field (`expose_class`).
- Apply a site-defined CSS class to every iframe from that field.
- Allow tokens in the iframe title only, or in both title and URL (with the Token module).
- Validate entered iframe URLs (including anchors and query strings) through core's link validation.
- Link to internal paths or entities as the iframe source (internal:/entity: URIs).
- Deploy iframe field, widget, and formatter settings as exported configuration between environments.
- Import iframe field values from Feeds using the provided feeds target.
- Migrate Drupal 7 CCK iframe fields via the bundled migrate plugins.
