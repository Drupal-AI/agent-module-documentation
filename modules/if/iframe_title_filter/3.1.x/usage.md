iFrame Title Filter is a text-format filter (plus a Media oEmbed integration) that adds a missing `title` attribute to `<iframe>` tags so embedded content meets WCAG accessibility guidance.

---

The module provides one text filter, `filter_iframe_title` ("Add missing titles to iFrames",
`Plugin/Filter/FilteriFrameTitle`, a `TYPE_TRANSFORM_REVERSIBLE` filter with weight 100). On processed
text it loads the HTML with `Html::load()`, iterates every `<iframe>`, and for any iframe lacking a
`title` it parses the `src` URL with `parse_url()` and sets `title` to "Embedded content from
&lt;host&gt;" (falling back to the raw URL when there's no host). You enable it per text format at
*Configuration › Content authoring › Text formats*, and — because it needs the final iframe markup —
should order it **after** any HTML-generating/filtering steps (e.g. Media embed, video_filter). The
title string is built with the translation service (`@host` placeholder), so the host value is
placeholder-escaped, and output goes back through `Html::serialize()`. Separately, hooks in
`src/Hook/IframeTitleFilterHooks` target core Media's oEmbed iframes: a
`hook_preprocess_media_oembed_iframe()` implementation adds a `title` (from the oEmbed resource title,
or "Embedded content from &lt;provider&gt;") to title-less iframes in the rendered media markup, with
a `media_oembed_iframe__iframe_title_filter` theme suggestion/hook. No global settings page, no
permission, no config schema, no dependencies beyond core.

---

- Automatically add a `title` to editor-embedded iframes that lack one (WCAG H64).
- Improve screen-reader labeling of embedded videos/maps in body text.
- Add titles to iframes produced by other filters (video_filter, Media) as a universal band-aid.
- Title iframes rendered by core Media oEmbed (YouTube, Vimeo, etc.) without editing each embed.
- Derive a human-readable title from the iframe's `src` host when the author didn't set one.
- Fix accessibility audit failures for "iframe missing title" across existing content.
- Apply consistently across a text format without touching stored content.
- Preserve author-provided titles (only title-less iframes are modified).
- Use the provider name as the title for oEmbed embeds (e.g. "Embedded content from YouTube").
- Meet WCAG 2.x / Section 508 requirements for named frames on public sites.
- Add to a "Full HTML" or custom format used for landing pages with many embeds.
- Reduce manual QA of embed accessibility for editorial teams.
- Complement CKEditor media embedding with automatic frame titling.
- Order after HTML correction so it operates on final, well-formed markup.
- Provide a template override point via the `media_oembed_iframe__iframe_title_filter` suggestion.
- Roll out iframe titling site-wide by enabling the filter on all relevant formats.
