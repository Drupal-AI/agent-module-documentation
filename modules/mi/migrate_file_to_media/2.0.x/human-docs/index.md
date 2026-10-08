# Migrate File To Media — manual setup guide

**Migrate File To Media** (`migrate_file_to_media`) helps you move a site off
plain `file` and `image` fields and onto core **Media** entities. Instead of
storing an uploaded file directly on a node (or paragraph, or taxonomy term),
you end up with a reusable Media entity and a media-reference field pointing at
it — which is how modern Drupal expects you to manage files. The module is the
tooling that gets you there: it builds the new reference fields, creates one
Media entity per file, and links everything back together.

Its standout feature is **duplicate detection**. If the same image was uploaded
to twenty different nodes, a naïve migration would create twenty identical media
entities. This module calculates a binary hash of every file first, so identical
binaries collapse into a single reusable media entity. It can also match against
media you already have, so re-running a migration reuses existing media rather
than piling up duplicates.

You drive the whole process with **Drush commands plus migrate_plus
migrations** — there is no settings page to fill in. A typical run is four steps:
generate the `<field>_media` reference fields, hash the files for de-duplication,
import step 1 (create the media entities), then import step 2 (attach those media
entities to your original content). It handles translations, revisions,
paragraphs, and any content entity type, and it includes Drupal 7 source
variants for site upgrades. A bundled example submodule ships a complete,
working Article image migration you can copy from.

This guide is written for a **human** working through a terminal and the admin
UI. If you want terse, token-cheap references for an AI coding agent — including
the exact plugin ids and YAML shapes — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its migrate dependencies, and (optionally) the example submodule.

There is no configuration form for this module — everything happens through Drush
and migration YAML, described below.

## Where it lives in the admin menu

There is no dedicated settings page. Once enabled, you work with the module
entirely from the command line (its `drush migrate:*` commands and the
`mf2m_media` generator) and, if you want to watch progress, from the standard
migration overview at **Structure → Migrations** (`/admin/structure/migrate`,
provided by migrate_tools).

## How to use it

The end-to-end flow, using an Article's image field as the example, is:

1. **Make sure core Media is set up** and the target media types (Image,
   Document, and so on) already exist.
2. **Generate the media fields.** One command creates a `<field>_media`
   entity-reference field for every matching file field on a bundle:

   ```bash
   drush migrate:file-media-fields node article image image
   ```

   (The arguments are entity type, bundle, source field type, and target media
   bundle. The alias is `mf2m`.) The bundle must already have default form and
   view displays for this to work.
3. **Write or generate the migrations.** Run `drush generate mf2m_media` to
   scaffold the step-1 and step-2 migrate_plus migration YAML interactively, then
   enable the module you scaffolded them into so `drush migrate:status` lists
   them.
4. **Run duplicate detection.** `drush migrate:duplicate-file-detection <step1>`
   hashes every file into the `migrate_file_to_media_mapping` table. **This must
   run before you import step 1.** Optionally run
   `drush migrate:duplicate-media-detection` first (with the step-1 command's
   `--check-existing-media` flag) to reuse media you already have.
5. **Import step 1:** `drush migrate:import <step1>` creates one media entity per
   unique file, skipping duplicates.
6. **Import step 2:** `drush migrate:import <step2>` fills each piece of content's
   new `<field>_media` reference by resolving file id → media id.

Because it is built on the migrate framework, every step is resumable and can be
rolled back with `drush migrate:rollback`. For the exact plugin ids, source
options, and a full three-file YAML example, see the
[`agent/`](../agent/start.md) docs and the shipped `migrate_file_to_media_example`
submodule.
