<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filefield to Media Copy is a developer/Drush utility that copies legacy file and image field values into an existing core Media reference field on the same entities.

---

Sites migrated from Drupal 7 (or built before core Media) commonly store images and documents in plain `file`/`image` fields. Moving to core Media means every one of those field values has to become a Media entity referenced from a media field. This module automates that copy: for each entity of a given type/bundle it reads the source file field, creates (or reuses) a Media entity of the chosen bundle wrapping each file, and appends it to the target media field.

Operationally it is CLI-only — a single `drush filefield-to-media:copy` command (alias `fftm`) drives everything; there are no routes, forms, or permissions. By default it de-duplicates by hashing file contents with `sha1_file()` and reusing an existing Media entity when the same file is found, so shared images do not spawn duplicate media; `--no-reuse` disables this. Created media are owned by user 1 and published. The target media field must already exist and be empty, and you should take a backup first because the command writes to every matched entity.

Typical setup: add the media field to the bundle, ensure it is empty, install the module, run the command with your field/bundle names, verify the result, then remove the now-redundant legacy file field.

---

- Copy an image field's values into a core Media (image) field after a D7→D10/11 migration
- Copy a document/file field into a Media (file/document) field
- Run the conversion for a single content type with the optional bundle argument
- Convert media across all bundles of an entity type by omitting the bundle argument
- Convert file fields on non-node entities (users, taxonomy terms, paragraphs) via the entity_type arg
- Map image alt/title/width/height into the created media when the bundle is `image`
- Map file display/description into the created media for non-image bundles
- De-duplicate media by file hash so shared images reuse one Media entity
- Force fresh media per value with `--no-reuse` when you need distinct alt/title text
- Use the alias `fftm` with defaults for the common node/image case
- Preview which entities have source values by reading the module's log output
- Batch a large migration from the CLI without loading admin UI
- Keep the legacy file field temporarily, then delete it once media looks correct
- Re-run after adding more content of the same type
- Populate media fields for a staged content import pipeline
- Troubleshoot reuse-hash issues by switching to `--no-reuse`
- Integrate the copy step into a deployment/migration script
