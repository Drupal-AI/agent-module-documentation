Submodule of Video Embed Field providing a single Drush command that migrates existing video_embed_media entities over to Drupal core's native oEmbed video media source.

---

`vem_migrate_oembed` exists to help sites move off the contrib video_embed_media source and onto core Media's built-in oEmbed (Remote video) source. It registers one Drush command, `vem:migrate_oembed` (alias `vemmo`), backed by a `VemMigrate` service that walks video media entities and rewrites their stored video URLs into the field structure core expects. This is a one-time upgrade utility: run it after preparing a core oEmbed media type, verify the results, then you can decommission the contrib source. It depends on core `media` and the `video_embed_media` submodule. There is no UI or configuration — the whole module is the command and its service.

---

- Migrate video_embed_media entities to core oEmbed video source.
- Run `drush vem:migrate_oembed` (alias `drush vemmo`) as a one-off upgrade step.
- Move a site off the contrib video source toward core Media before removing video_embed_field.
- Preserve existing video URLs while switching the underlying media source.
- Script the migration as part of a deployment/upgrade pipeline.
- Reduce contrib dependencies by consolidating on core oEmbed.
- Batch-convert many legacy video media entities at once.
- Prepare a codebase for eventual removal of video_embed_media.
- Standardise on Drupal core's supported video media handling.
- Automate video media conversion instead of editing each entity by hand.
- Keep video thumbnails and references intact through the source switch.
- Simplify long-term maintenance by relying on core rather than contrib.
- Test the migration on a staging copy before running it in production.
- Roll the command into a `drush` upgrade script alongside `updatedb`/`cim`.
- Free a site to drop video_embed_field once all videos use core oEmbed.
- Consolidate remote-video handling for editorial consistency.
