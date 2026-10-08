Migrate File To Media Example is a worked, copy-me example submodule that ships a complete Article-images migration (file/image fields → Media entities) built with the Migrate File To Media module.

---

The submodule is a learning template, not something you run in production. Enabling it installs an Article content type plus the image fields `field_image` and `field_image2` (and body, tags, image styles, view modes and displays) and, via `config_devel`, three migrate_plus migration configs: `migrate_file_to_media_example_article_images_step1` (source plugin `media_entity_generator`, migration group `media`, listing `field_image` + `field_image2`, creating one deduplicated Media entity per referenced image), `migrate_file_to_media_example_article_images_step1_de` (adds translations to those media entities), and `migrate_file_to_media_example_article_images_step2` (source `content_entity:node`, using `file_id_lookup` to populate the `field_image_media` / `field_image2_media` reference fields on the original Articles). A fourth config, `…_step1_rokka`, shows pushing images to the rokka.io CDN. It demonstrates the full recommended flow: generate the media fields with `drush migrate:file-media-fields`, run `drush migrate:duplicate-file-detection`, then import step 1 and step 2. Use it as the pattern for writing your own per-content-type migration (the `drush generate mf2m_media` generator scaffolds the same shape). Requires the `migrate_file_to_media` module.

---

- Learn the exact structure of a Migrate File To Media step-1 / step-2 migration.
- Copy the shipped `article_images_step1` migration as a template for your own content type.
- See how `media_entity_generator` is configured with `entity_type`, `bundle` and `field_names`.
- See how `toggle_media_mapping: true` wires step 1 into the duplicate-mapping table.
- See how step 2 links media back onto `field_image_media` / `field_image2_media` via `file_id_lookup`.
- Understand the `check_duplicate` and `check_media_duplicate` process plugins in context.
- Understand how `media_name` derives a media entity's name from the file name.
- See a translation migration (`…_step1_de`) that adds translated media entities.
- See how to push migrated images to a CDN (the rokka.io `…_step1_rokka` variant).
- Get a ready-made Article content type with two image fields to practise on.
- Inspect the migration group (`media`) used to run related migrations together.
- Reproduce the documented duplicate-detection + import sequence end to end.
- Compare your own generated migrations against a known-good example.
- Bootstrap a demo/QA site for testing file-to-media migrations.
- Use the example fields to verify `drush migrate:file-media-fields` output naming.
- Teach a team the recommended file-to-media migration workflow.
- Validate that migrate_plus / migrate_tools are correctly installed by running the sample.
- Serve as the reference the `mf2m_media` Drush generator is modelled on.
