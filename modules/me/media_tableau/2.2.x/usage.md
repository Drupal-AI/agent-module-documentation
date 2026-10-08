<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Tableau adds a field formatter that renders a Tableau visualization URL (stored in a string field) as an embedded `<tableau-viz>` web component, plus an allowed-hosts settings page that whitelists the domains a viz may come from.

---

The module builds on the Media Remote module and provides a single `media_tableau` field formatter for `string` fields. When the stored value matches an allowed Tableau URL pattern (`.../views/...` or `.../app/profile/.../viz/...`), the formatter rewrites profile-style URLs into embeddable `/views/` URLs and renders the `templates/media-tableau.html.twig` template, which outputs a `<tableau-viz>` element and attaches the Tableau Embedding API JavaScript library (selectable version: `latest`, `3.6`, or `3.5`). The formatter exposes settings for iframe `width`, `height`, `api_version`, and whether to show the Tableau `toolbar`. A configuration form at `/admin/config/media/tableau` stores the list of `allowed_hosts` (default `https://public.tableau.com`) in `media_tableau.settings`; the formatter's URL regex and the media-name derivation are both driven by that list. If the CSP module is installed, an event subscriber automatically appends every allowed host to the Content-Security-Policy `frame-src` directive on non-admin routes so the embed is not blocked. Typical setup is a Media Remote media type whose source string field uses the `media_tableau` display formatter.

---

- Embed a public Tableau Public dashboard on a content page via a Remote Media field.
- Render an internal Tableau Server / Tableau Cloud visualization by whitelisting its host.
- Rewrite a Tableau `app/profile/.../viz/...` share URL into an embeddable `/views/` URL automatically.
- Show or hide the Tableau interactive toolbar on an embedded viz per display.
- Pin an embed to a specific Tableau Embedding API version (`3.5`, `3.6`) for compatibility.
- Track the `latest` Tableau Embedding API by choosing the `latest` library version.
- Control the iframe size of an embedded viz with CSS units (e.g. `100%`, `900px`).
- Restrict which Tableau domains may be embedded through the allowed-hosts whitelist.
- Automatically extend the CSP `frame-src` directive so embeds are not blocked when the CSP module is active.
- Provide editors a simple string field into which they paste a Tableau URL, no custom code.
- Standardise Tableau embedding across a site through one reusable media type.
- Validate that an entered Tableau host uses `https://` and no path on the settings form.
- Derive a sensible default media name ("Tableau view from <url>") from a pasted viz URL.
- Display a KPI dashboard inside an article, landing page, or report node.
- Curate a library of reusable Tableau media entities for reference across many pages.
- Add multiple allowed hosts (public + organization Tableau Cloud) to one site.
- Present a data story to non-technical editors without exposing embed markup.
- Keep Tableau embed markup consistent by rendering through a single Twig template.
- Swap a viz's toolbar visibility without touching the underlying data source.
- Serve Tableau embeds on a decoupled/CSP-hardened site by wiring `frame-src` automatically.
- Reuse the same viz across view modes by configuring the formatter per display.
