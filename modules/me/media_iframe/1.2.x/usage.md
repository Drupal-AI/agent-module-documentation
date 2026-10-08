<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Inline Frame adds a Media **source plugin** called "Inline frame" (`inline_frame`) that lets you build a media type backed by an `iframe` URL field, so editors can store and reuse arbitrary embeddable URLs (maps, calendars, dashboards, third-party players) as media entities.

---

The module is a thin bridge between core Media and the contributed `iframe` field module. It registers a single `@MediaSource` plugin (`inline_frame`, label "Inline frame") whose `allowed_field_types` is `{"iframe"}`, so when you create a media type and pick this source, its source field is an Inline Frame URL field. `InlineFrame::createSourceField()` names the source field `field_media_inline_frame` and labels it "Inline Frame URL"; `prepareViewDisplay()` wires that field to render with the core-iframe `iframe_default` formatter and a visually hidden label. It also ships a Media Library "add" form (`MediaIframeAddForm`) that offers a simple "Iframe URL" text input so items can be created directly inside the media library modal, and a default thumbnail (`iframe.png`). The module has **no settings form and no `configure` route** — all configuration is done through the standard Media type UI (choose the source, map fields, set the view display). It exposes one config-schema entry (`media.source.inline_frame`, of type `media.source.field_aware`). Unlike core's oEmbed source, an iframe media type embeds any URL you allow via the iframe field's own allow-list/attribute settings, rather than being limited to registered oEmbed providers.

---

- Create a "Remote page" media type that embeds any URL in an `<iframe>` and is reusable across content.
- Let editors add an iframe URL directly from the Media Library modal.
- Embed a Google Map, Google Calendar, or Google Form as a managed media entity.
- Store a Power BI / Grafana / Metabase dashboard URL as media and drop it into pages.
- Provide an "external video" media type for players that core oEmbed doesn't support.
- Reuse one embedded booking/scheduling widget across many nodes via a media reference field.
- Give a media type an iframe source field labelled "Inline Frame URL" without writing code.
- Render the iframe with core-iframe's `iframe_default` formatter automatically on the media view display.
- Curate embeddable third-party content in the Media Library alongside images and documents.
- Add an iframe media type to a rich-text editor's media embed button for reusable embeds.
- Embed a PDF viewer or document preview hosted on an external service as media.
- Keep an allow-list of permitted iframe hosts using the underlying `iframe` field settings.
- Attach a visually hidden label so the embedded frame renders cleanly on the page.
- Provide a fallback thumbnail (`iframe.png`) for iframe media in library grids.
- Build an "embed" media type usable by any entity reference / media field.
- Migrate ad-hoc inline `<iframe>` snippets in body fields into structured, reusable media.
- Offer content teams a governed way to embed external tools without full HTML permissions.
- Combine with Media Library Bulk Upload / Edit workflows for iframe entities.
- Present a consistent editorial UX for "paste a URL to embed" content.
- Reference the same embedded dashboard from multiple landing pages with one source of truth.
- Use the iframe media type as the source for a view of "embedded resources".
- Localize or moderate embedded resources by treating each iframe as a media entity.
- Swap an embedded URL in one place and have every reference update.
- Restrict who can create iframe media through standard media type / entity permissions.
