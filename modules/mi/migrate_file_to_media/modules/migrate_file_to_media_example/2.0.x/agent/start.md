# Migrate File To Media Example — agent index

Worked example submodule of Migrate File To Media: a complete Article-images file→media migration
you copy from. Not for production. No code, no config of its own beyond the sample fields and
migrations. See the parent module docs for the plugins and Drush commands it uses:
`../../../2.0.x/agent/start.md`.

## What enabling it installs

- An **Article** content type with image fields `field_image` and `field_image2` (plus body,
  tags vocabulary, image styles, `teaser`/`rss` view modes and displays) — `config/optional`.
- Three migrate_plus migrations (installed via `config_devel`), migration group `media`:

| Migration id | Source plugin | Role |
|---|---|---|
| `migrate_file_to_media_example_article_images_step1` | `media_entity_generator` (fields `field_image`, `field_image2`, `toggle_media_mapping: true`) | Step 1 — create one deduped media entity per image |
| `migrate_file_to_media_example_article_images_step1_de` | `media_entity_generator` | Add translations to those media entities |
| `migrate_file_to_media_example_article_images_step2` | `content_entity:node` (+ `file_id_lookup`) | Step 2 — set `field_image_media` / `field_image2_media` on the Articles |

  (plus `…_step1_rokka`, a rokka.io CDN variant.)

## Run order it demonstrates

```bash
drush migrate:file-media-fields node article image image     # create field_image_media / field_image2_media
drush migrate:duplicate-file-detection migrate_file_to_media_example_article_images_step1
drush migrate:import migrate_file_to_media_example_article_images_step1
drush migrate:import migrate_file_to_media_example_article_images_step2
```

Inspect the shipped migration config:
`drush cget migrate_plus.migration.migrate_file_to_media_example_article_images_step1`.
