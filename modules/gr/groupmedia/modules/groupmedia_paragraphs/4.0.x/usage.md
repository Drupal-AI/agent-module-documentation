<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Media Paragraphs tracker is a submodule of Group Media that teaches the automatic media-tracking feature to look **inside Paragraphs**. It adds two `media_finder` plugins so media referenced or embedded within a Paragraph field is attached to the group along with its host entity.

---

Out of the box Group Media's finders inspect fields directly on the tracked entity (entity-reference fields and embedded media in text). They do not descend into Paragraph entities, so media that lives inside a Paragraph field is missed. This submodule closes that gap with two `media_finder` plugins registered under the `groupmedia_paragraphs` provider: `paragraphs_media_reference` (field type `entity_reference_revisions`) walks the host entity's Paragraph fields and finds media referenced by entity-reference fields on those Paragraphs, and `paragraphs_media_embed` (text field types, `drupal-media` element) finds media embedded via the WYSIWYG *Embed media* filter inside Paragraph text fields. Both reuse a shared `ParagraphsMediaFinderTrait` that recursively collects Paragraphs (including nested Paragraphs referenced through further `entity_reference_revisions` fields). The plugins only take effect when the parent Group Media relation for that media type has `tracking_enabled` on; they add no configuration, permissions, routes, or services of their own. Enable it when your groups' content uses Paragraphs and you want media inside those Paragraphs to become group content automatically. Requires `groupmedia` and `paragraphs`.

---

- Attach media referenced inside a Paragraph to the group when the host node is saved.
- Track media embedded with *Embed media* inside a Paragraph rich-text field.
- Descend into nested Paragraphs (Paragraph-in-Paragraph) to find deeper media references.
- Auto-associate a landing page's Paragraph-based hero image with the owning group.
- Keep group asset libraries complete when editors build pages with Paragraphs.
- Find media in `entity_reference_revisions` Paragraph fields via `paragraphs_media_reference`.
- Find embedded media in Paragraph `text_long` fields via `paragraphs_media_embed`.
- Track a gallery Paragraph's referenced image media into the group.
- Ensure a video embedded in a Paragraph text area is attached to its group.
- Support component/layout builders that store content as Paragraphs.
- Combine with the core Group Media finders so both direct and Paragraph media are tracked.
- Avoid writing a custom finder when your only gap is Paragraph-hosted media.
- Attach media from a multi-item Paragraph list to the group in one save.
- Track media in Paragraphs used by group-owned articles, pages, or custom content types.
- Extend the two plugins (they are ordinary `media_finder` plugins) for bespoke Paragraph structures.
- Migrate a Paragraph-heavy site into groups while keeping media relationships intact.
- Respect the parent relation's `tracking_enabled` flag so tracking stays opt-in per media type.
- Let the group Media overview reflect media that only exists inside Paragraph components.
- Keep private group media scoped even when the media is buried in nested Paragraphs.
- Reduce manual "Relate media" work for Paragraph-based editorial workflows.
