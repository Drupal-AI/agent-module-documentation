<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Generic provides a single "Generic" media source plugin (id `generic`) for core Media, storing an arbitrary string value as the media's source field and using a generic placeholder thumbnail.

---

The module is a thin, single-plugin bridge. Its only code is `Drupal\media_entity_generic\Plugin\media\Source\Generic`, a `MediaSourceBase` subclass annotated `@MediaSource(id = "generic", allowed_field_types = {"string"}, default_thumbnail_filename = "generic.png")`. It exposes no metadata attributes (`getMetadataAttributes()` returns `[]`) and marks its source field storage as `custom_storage`. Historically it exists to let sites that used the contributed **Media Entity** 1.x "Generic" provider migrate cleanly to **Media in core** (Drupal 8.4+): during that upgrade the module is enabled automatically. `hook_requirements()` blocks installation while the old Media Entity 1.x branch is still present. On a modern site you can also enable it deliberately to create a bare-bones media type whose "source" is just a text string — useful as a placeholder or a stand-in when no dedicated source (image, oEmbed, file) fits. There is no settings form and no configure route; you use it by choosing "Generic media" as the source when creating a media type.

---

- Migrate a legacy Media Entity 1.x site that used the "Generic" provider to Media in core.
- Create a media type backed by a plain string value rather than a file or oEmbed URL.
- Provide a placeholder media type during a content model build before the real source is chosen.
- Store an external identifier or reference code as a media entity's source value.
- Represent third-party/opaque media (that has no local file) as a Drupal media entity.
- Give editors a "generic" media bucket for content that doesn't fit image/video/document types.
- Attach a generic thumbnail (`generic.png`) to media that has no derivable preview.
- Use the string source field in media library listings and entity reference fields.
- Prototype a media type quickly without configuring an oEmbed provider or file field.
- Keep a uniform Media entity API over heterogeneous or non-file assets.
- Serve as the target media type for a migration where the incoming source is just text.
- Bridge automated upgrade paths where `media_entity_generic` is enabled for you.
- Model an inventory of physical items (SKU string) as media entities.
- Hold a DOI, ISBN, or catalog number as the source value of a media entity.
- Reference remote DAM asset IDs as generic media without downloading files.
- Create a media type whose source is later swapped once a proper source module is added.
- Test Media UI and field formatters against a minimal source with no metadata.
- Provide a fallback media type so content referencing "media" always resolves to something.
- Use with Media Library to expose text-keyed assets to editors.
- Standardise legacy generic media into core so contrib Media Entity can be uninstalled.
