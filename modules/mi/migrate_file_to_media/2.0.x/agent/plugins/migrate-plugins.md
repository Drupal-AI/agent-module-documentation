# Migrate plugins provided

These are migrate **plugin instances** (source / process / destination) you reference by `id` in
migrate_plus migration YAML. The module does not define any new plugin *type*.

## Source plugins (`src/Plugin/migrate/source`)

| id | Class | Use |
|---|---|---|
| `media_entity_generator` | `MediaEntityGenerator` | **Step 1.** Emits one row per file referenced by the listed `field_names`, for creating media entities. Key options: `entity_type`, `bundle`, `field_names`, `toggle_media_mapping: true`, `include_revisions`, `langcode`, `source_langcode`. |
| `media_content_entity` (`content_entity:<type>`) | `MediaContentEntity` | **Step 2.** Iterates source entities so their new `<field>_media` reference fields can be populated. Options: `bundle`, `include_revisions`, `include_translations`, `fields_not_empty`. |
| `media_entity_generator_d7` | `MediaEntityGeneratorD7` | Drupal 7 file-field source. |
| `media_entity_generator_d7_paragraph` | `MediaEntityGeneratorParagraphD7` | Drupal 7 paragraph file-field source. |
| `media_entity_generator_d7_taxonomy` | `MediaEntityGeneratorTaxonomyD7` | Drupal 7 taxonomy-term file-field source. |

## Process plugins (`src/Plugin/migrate/process`)

| id | Class | Use |
|---|---|---|
| `check_duplicate` | `CheckDuplicate` | Skips the row if this file's binary hash was already seen (dedupe on file). |
| `check_media_duplicate` | `CheckMediaDuplicate` | Skips the row if a matching **existing media** entity was found. |
| `media_file_copy` | `MediaFileCopy` | Copies the file binary into the media entity. |
| `media_name` | `MediaName` | Derives the media entity name (e.g. from alt text or file name). |
| `file_id_lookup` | `FileIdLookup` | **Step 2.** Looks up the media id created in step 1 for a given source file id, to set the `<field>_media` reference. |

## Destination plugin (`src/Plugin/migrate/destination`)

| id | Class | Use |
|---|---|---|
| `media_entity_revision` | `MediaEntityRevision` | Writes media entity **revisions** (for revision-aware migrations); has a derivative deriver. |

## Minimal step-1 shape (from the example module)

```yaml
source:
  plugin: media_entity_generator
  toggle_media_mapping: true
  entity_type: node
  bundle: article
  field_names: [field_image, field_image2]
destination:
  plugin: entity:media
process:
  bundle:
    plugin: default_value
    default_value: image
  name: { plugin: media_name, source: file_name }
  existing_media_file: { plugin: check_media_duplicate, source: target_id }
  unique_file_id: { plugin: check_duplicate, source: target_id }
  field_media_image/target_id: target_id
  field_media_image/alt: alt
  field_media_image/title: title
```

Step 2 uses `source.plugin: content_entity:node` and `file_id_lookup` (with
`migration: <step1_id>`) to fill each `<field>_media` reference. See `api/workflow.md` and the
`migrate_file_to_media_example` submodule docs for the full three-file example.
