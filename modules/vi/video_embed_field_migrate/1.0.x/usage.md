<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Field Migrate provides a `drush vef_migrate` command that finds `video_embed_field` fields on non-media entity types, creates a core `remote_video` (oEmbed) media type and entity-reference fields, converts each stored video URL into a Media entity, and repoints the content to the new reference field.

---

This is an administrative Drush-only tool with no HTTP routes, no forms and no web-facing surface — it runs only from the CLI by an operator with shell/Drush access. It reads local YAML config templates from the standard install profile via `file_get_contents` (local, fixed paths) and uses `accessCheck(FALSE)` on entity queries, which is appropriate for a batch migration run under a trusted operator. No SSRF, XSS, SQL injection or access-control surface is exposed to the web. Run it once against a backup, as the module itself advises abandoning the migration on error.

---

- Migrate Video Embed Field data to core Media oEmbed.
- Convert legacy YouTube/Vimeo URL fields into `remote_video` media.
- Auto-create the `remote_video` media type if absent.
- Generate entity-reference fields pointing at the new media.
- Preview which fields and how many values will be migrated.
- De-duplicate identical video URLs into shared Media entities.
- Modernise a site off the contrib Video Embed Field module.
- Prepare content for Drupal core Media workflows.
- Handle multi-value video fields via field cardinality.
- Wire up form and view displays for the new reference field.
- Seed `media.settings` oEmbed providers URL if unset.
- Run as a controlled, one-shot CLI migration.
- Confirm field-name availability before creating fields.
- Abandon and restore from backup if the migration errors.
- Keep the operation to trusted operators with Drush access.
- Validate results before deleting the old fields.
- Use on paragraphs and other non-media host entities.
