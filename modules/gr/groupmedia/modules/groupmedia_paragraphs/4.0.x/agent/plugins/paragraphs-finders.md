<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs media finders

Two `media_finder` plugins (parent plugin type: manager `plugin.manager.groupmedia.finder`,
directory `Plugin/MediaFinder/`). They use the legacy `@MediaFinder` annotation. Provider:
`groupmedia_paragraphs`.

| Plugin id | field_types | element | Base class | Finds |
|---|---|---|---|---|
| `paragraphs_media_reference` | `entity_reference_revisions` | — | `MediaFinderBase` | media in entity-reference fields **on Paragraphs** |
| `paragraphs_media_embed` | `text`, `text_long`, `text_with_summary` | `drupal-media` | `EntityEmbed` (parent finder) | *Embed media* media **inside Paragraph text** |

## How they descend into Paragraphs

Both `use ParagraphsMediaFinderTrait`. Its `getParagraphs($entity)`:
1. Iterates the host entity's field definitions, selecting `entity_reference_revisions`
   fields whose `target_type` is `paragraph`.
2. Collects the referenced Paragraph entities.
3. Recurses: if a Paragraph itself has an `entity_reference_revisions` field, its child
   Paragraphs are gathered too (nested Paragraphs).

`paragraphs_media_reference::process()` then scans each Paragraph's `entity_reference` fields
whose `target_type` is `media` and returns those media items. `paragraphs_media_embed::process()`
scans each Paragraph's text fields for embedded `drupal-media` and resolves them to media.

## When they run

The parent `AttachMediaToGroup` service runs every registered finder on a saved entity while
that media type's Group Media relation has `tracking_enabled` on, unions the results, applies
the groupmedia alter hooks, and attaches the surviving media to the group. These two plugins
simply widen the search to Paragraph-hosted media. To add support for a bespoke Paragraph
structure, write your own `media_finder` plugin (see the parent
[plugins doc](../../../../../4.0.x/agent/plugins/media-finder.md)); you can reuse
`ParagraphsMediaFinderTrait`.
