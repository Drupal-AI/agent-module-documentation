Attaches author/source attribution and licensing information to any fieldable entity (and to the whole site via a block), backed by a configurable list of licenses imported from the SPDX license list.

---

Attribution provides an `attribution` field type storing five properties — source name, source link, author name, author link, and a license id — plus four widgets (`attribution_license`, `attribution_author_license`, `attribution_source_license`, `attribution_source_author_license`; the last is the default) and six formatters (`attribution_plain`, `attribution_plain_oneline`, `attribution_html`, `attribution_creative_commons` [default], `attribution_creative_commons_icons`, `attribution_creative_commons_refined`). Licenses are stored as `attribution_license` config entities (id, SPDX identifier, name, OSI-certified flag, deprecated flag, link); the module installs nine common defaults (CC0, the CC-BY family, GPL-2.0-or-later, All Rights Reserved) and lets an admin import any of the 400+ licenses from the bundled `composer/spdx-licenses` list at *Structure → Attribution Licenses*. Licenses are managed at `/admin/structure/attribution-license` behind the `administer attribution_license` permission (the `configure` route). Two blocks — **Attribution** and **Copyright** — render a site-wide license notice with a configurable disclaimer that supports core Token replacement (e.g. `[current-date:html_year]`, `[site:name]`) and `@name`/`@link` placeholders for the chosen license. Formatters emit theme hooks (`attribution-*.html.twig`) that add license-aware CSS classes (OSI/deprecated state) and, for the Creative Commons icon formatter, CC glyphs via CSS. A per-field setting restricts which licenses are offered in that field's widget.

---

- Credit the original author and source of imported/reused content on nodes or media.
- Attach a Creative Commons license to articles, photos, or other content.
- Show a site-wide license notice in the footer via the Attribution block.
- Show a copyright line (e.g. "© 2026 My Site. All rights reserved.") via the Copyright block.
- Render attribution as plain text, one-line text, HTML, or Creative Commons variants per display.
- Display Creative Commons license badges/icons next to content.
- Import specific licenses (from 400+ SPDX licenses) into the site's license list.
- Curate a short list of allowed licenses per field so editors pick from a controlled set.
- Store both a source (where content came from) and an author (who made it) with links.
- Add license metadata to media images for DAM/asset-reuse governance.
- Mark deprecated or non-OSI licenses distinctly via the CSS classes formatters emit.
- Use Token placeholders in the block disclaimer to insert the current year and site name automatically.
- Provide machine-readable-ish license identifiers (SPDX) alongside human labels.
- Build a consistent attribution UX across content types with one reusable field type.
- Let editors leave source/author blank and only pick a license (or vice versa) via widget choice.
- Distinguish "Source, Author & License" vs simpler widget variants depending on editorial needs.
- Theme attribution output by overriding the `attribution_*` templates.
- Add per-page copyright/licensing to satisfy legal or funder requirements.
- Reuse the same license vocabulary for both fields and the site-wide block.
- Migrate/seed licenses as configuration (config entities) across environments.
