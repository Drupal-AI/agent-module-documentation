# Filefield to Media Copy — manual setup guide

**Filefield to Media Copy** (`filefield_to_mediafield`) is a small developer
utility that copies the values of a legacy file or image field into an existing
core **Media** reference field on the same entities. It is the tool you reach for
*after* a migration — typically a Drupal 7 site, or any older build that stored
images and documents in plain `file`/`image` fields — when you want to adopt core
Media without setting up a heavyweight migration pipeline.

For each entity of a chosen type (and optional bundle) it reads the source file
field, wraps each file in a Media entity of the bundle you name, and appends that
Media to the target media field. By default it de‑duplicates by hashing each
file's contents (`sha1_file`), so a shared image reuses one Media entity rather
than spawning copies; you can turn that off with `--no-reuse`. Created media are
owned by user 1 and published.

Everything runs from the command line — there is a single Drush command
(`filefield-to-media:copy`, alias `fftm`) and **no admin UI, forms, or
permissions**. The target media field must already exist and be empty before you
run it, and you should take a database backup first, because the command writes to
every matched entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and prepare the target media field.

There is **no configuration page** for this module — it is driven entirely by the
Drush command described below.

## How to use it

The workflow, once the module is enabled, is:

1. Add a **media reference field** of the type you want (for example an image
   media field) to the entity bundle you are copying into, and make sure it is
   empty — it should never have values yet.
2. **Take a backup.**
3. Run the copy command, naming your source field, target field, media bundle, the
   file field *on the media entity*, the entity type, and (optionally) a single
   bundle:

   ```bash
   drush filefield-to-media:copy field_image field_image_media image field_media_image node article
   ```

   Running the alias with no arguments (`drush fftm`) uses the built‑in defaults
   shown above (`field_image` → `field_image_media`, `image` media, on `node`).
   Omit the final bundle argument to process every bundle of the entity type. Add
   `--no-reuse` to disable hash‑based de‑duplication when you need distinct alt or
   title text per value, or when the reuse hashes misbehave.
4. **Check the result.** Progress and errors are written to the
   `filefield_to_mediafield` log channel.
5. Once the media looks correct, delete the now‑redundant legacy file field.

See [Installation](installation/index.md) for the full argument reference and
requirements.
