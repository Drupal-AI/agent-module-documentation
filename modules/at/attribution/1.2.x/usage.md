Attaches author/source attribution, licensing, and AI-provenance information to any fieldable entity (and to the whole site via a block), backed by a configurable list of licenses imported from the SPDX license list.

---

Attribution provides an `attribution` field type storing ten properties — source name, source link, author name, author link, a license id, plus AI-provenance fields (creation type, AI tool, AI prompt, prompt-editor name, prompt-editor link) — served by four widgets (`attribution_license`, `attribution_author_license`, `attribution_source_license`, `attribution_source_author_license`; the last is the default) and seven formatters (`attribution_default` [default, configurable], `attribution_plain`, `attribution_plain_oneline`, `attribution_html`, `attribution_creative_commons`, `attribution_creative_commons_icons`, `attribution_creative_commons_refined`). The creation type is one of `human_created`, `ai_generated`, or `ai_modified`; the AI tool/prompt/prompt-editor inputs appear (via `#states`) only for the two AI types. Licenses are stored as `attribution_license` config entities (id, SPDX identifier, name, OSI-certified flag, deprecated flag, link); the module installs ten common defaults (CC0, the CC-BY family, GPL-2.0-or-later, All Rights Reserved, and the new "Uncertain copyright status" entry) and lets an admin import any of the 400+ licenses from the bundled `composer/spdx-licenses` list. Licenses are managed at `/admin/structure/attribution-license` behind the `administer attribution_license` permission (the `configure` route); the collection page offers **Add license** (SPDX import form at `/add`) and **Add custom license** (blank entity form at `/add-custom`). Two blocks — **Attribution** and **Copyright** — render a site-wide license notice with a configurable disclaimer that supports core Token replacement (e.g. `[current-date:html_year]`, `[site:name]`) and `@name`/`@link` placeholders for the chosen license. Formatters emit theme hooks (`attribution-*.html.twig`) that add license-aware CSS classes (OSI/deprecated state, per-license, per-creation-type) and can render CC glyphs and AI icons; a per-field setting restricts which licenses are offered in that field's widget.

---

- Credit the original author and source of imported/reused content on nodes or media.
- Attach a Creative Commons license to articles, photos, or other content.
- Declare whether content is human-created, AI-generated, or AI-modified for provenance/disclosure.
- Record the AI tool used and the prompt that produced AI content, and who edited the prompt.
- Show the AI prompt in an expandable details element on the rendered attribution.
- Show a site-wide license notice in the footer via the Attribution block.
- Show a copyright line (e.g. "© 2026 My Site. All rights reserved.") via the Copyright block.
- Render attribution as plain text, one-line text, HTML, Creative Commons variants, or the configurable Default formatter per display.
- Display Creative Commons license badges/icons and AI-type icons next to content.
- Import specific licenses (from 400+ SPDX licenses) into the site's license list.
- Curate a short list of allowed licenses per field so editors pick from a controlled set.
- Store both a source (where content came from) and an author (who made it) with links.
- Add license and provenance metadata to media images for DAM/asset-reuse governance.
- Mark deprecated or non-OSI licenses distinctly via the CSS classes formatters emit.
- Use the Default formatter's toggle (field label as a `<details>` summary) to collapse attribution.
- Use Token placeholders in the block disclaimer to insert the current year and site name automatically.
- Provide machine-readable-ish license identifiers (SPDX) alongside human labels.
- Build a consistent attribution UX across content types with one reusable field type.
- Let editors leave source/author blank and only pick a license (or vice versa) via widget choice.
- Distinguish "Source, Author & License" vs simpler widget variants depending on editorial needs.
- Theme attribution output by overriding the `attribution_*` templates.
- Add per-page copyright/licensing to satisfy legal, funder, or AI-disclosure requirements.
- Reuse the same license vocabulary for both fields and the site-wide block.
- Migrate/seed licenses as configuration (config entities) across environments.
- Mark content of uncertain copyright status with the shipped "Uncertain copyright status" license.
