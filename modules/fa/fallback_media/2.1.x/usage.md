<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fallback Media provides a media field formatter that renders an admin-chosen default media item whenever a media entity-reference field is empty.

---

Fallback Media (package Media, depends only on core `media`) solves the "empty media field" problem for display. It ships a small config entity, `fallback_entity`, where an administrator names a reusable fallback and picks the media item it should point to, managed under `/admin/structure/fallback_entity`. It then ships a field formatter, **Rendered entity (with fallback)** (`entity_reference_entity_fallback`), that is offered on any entity-reference field targeting media. When the field has a value the formatter behaves exactly like core's *Rendered entity* formatter; when the field is empty it renders the chosen fallback media item in the configured view mode instead of leaving a gap. This keeps card grids, teasers and hero regions visually consistent without editors having to attach the same placeholder to every entity. It is a display-only feature: it never writes content, and the fallback is set once per field display and reused across every entity of that bundle.

---

- Show a default placeholder image when a media reference field on a node is empty.
- Keep teaser and card layouts consistent when some items have no media of their own.
- Render a house/brand default video where a video field was left blank.
- Reuse one configured fallback media item across many bundles and view modes.
- Define several named fallbacks (e.g. "default avatar", "no image", "generic thumbnail") as `fallback_entity` config.
- Let editors leave a media field empty and still get a sensible rendered output.
- Replace an empty hero-image region with a branded default without per-entity work.
- Provide a fallback avatar for user-referenced media that has not been set.
- Display a generic thumbnail in a listing view where the referenced media is missing.
- Swap the formatter in on a field's Manage display to add fallbacks with no template changes.
- Manage fallbacks centrally through admin CRUD at `/admin/structure/fallback_entity`.
- Point a single fallback definition at a curated placeholder in the media library.
- Keep the core *Rendered entity* behaviour for populated fields while covering empty ones.
- Choose the view mode the fallback renders in, matching the field's normal output.
- Avoid shipping duplicate placeholder attachments across thousands of entities.
- Give designers predictable output in every cell of a grid regardless of content completeness.
- Support D8/D9/D10/D11 sites needing a media default at display time.
- Configure fallbacks per bundle/field display rather than in code.
- Update the placeholder site-wide by editing one fallback definition's target media.
- Present a consistent front-end even while content is still being backfilled with media.
