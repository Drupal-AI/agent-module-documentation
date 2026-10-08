<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Default Content Deploy exports Drupal content entities to per-entity JSON files and imports them into another environment, preserving cross-references by UUID. It ships Drush commands and an admin UI so content can be moved from staging to production, kept in git, and deployed continuously alongside code rather than by copying a database.

---

Drupal's configuration management moves config between environments but deliberately excludes content, yet some content behaves like configuration: front-page nodes, standard taxonomy, demo or seed data a site ships with. Default Content Deploy treats that content as files you export and import, correcting entity IDs across sites by matching on UUID so references (including references embedded in links and processed text) survive the move. Export runs in three modes -- a single entity type, an entity type with all its references, or the whole site -- and import decides per entity whether to create, update, or skip based on UUID and change timestamps, with force and incremental variants. It integrates with the Batch API for large sets, exposes export/import events for customization, overrides the HAL normalizers so files round-trip cleanly, and offers a Search API submodule for tracking and incrementally exporting only what changed. Both a Drush workflow (dcde/dcder/dcdes/dcdi) and an admin UI (with tar.gz upload/download) are provided.

---

- Export content to versionable JSON files.
- Import content into another environment.
- Deploy seed or demo content like code.
- Sync content from staging to production.
- Preserve entity references across environments via UUID.
- Ship default content with a site install.
- Move taxonomy terms between sites.
- Deploy front-page or landing content.
- Keep content under version control in git.
- Continuously sync content during CI deploys.
- Export a single entity by ID.
- Export an entity type with all its references.
- Export the entire site's content at once.
- Export only entities changed since a given date.
- Skip selected entity types during a site export.
- Import incrementally, re-importing only newer entities.
- Force-override local content back to the exported state.
- Delete entities on import via a _deleted folder.
- Preserve original entity IDs on import when required.
- Move media and file entities across environments.
- Seed a fresh environment with baseline content.
- Download an export as a tar.gz archive from the UI.
- Import content by uploading an archive in the UI.
- Look up an entity's UUID from the command line.
- List all content entity types available to export.
- Customize export/import via dispatched events.
- Track changed content for deploy with Search API.
