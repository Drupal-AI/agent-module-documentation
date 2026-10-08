<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translation Owner Manager provides Drush commands to reassign the owner/author uid of a specific node translation without touching other translations.

---

Translation Owner Manager is a CLI-only utility (no routes, no forms, no web-facing surface). Its Drush command `translation-owner:update-uid <nid> <langcode> <new_uid>` (aliases `tou`, `translation-owner-update`) validates the user, node and translation, then updates the `uid` on `node_field_data` and `node_field_revision` for just that langcode/revision and performs thorough entity/cache invalidation. `translation-owner:bulk-update <file>` reads a CSV with `nid,langcode,new_uid` columns, applies each row, and writes a timestamped results report. Because it runs as a Drush command it is gated by shell access, not by a Drupal permission.

---

- Change the author of one node translation.
- Keep other translations' authors unchanged.
- Bulk-reassign translation owners from a CSV.
- Validate that the target user exists first.
- Validate that the node and translation exist.
- Update both node_field_data and node_field_revision.
- Invalidate entity and cache tags after the change.
- Generate a timestamped CSV report of results.
- Use aliases tou / translation-owner-update.
- Fix ownership after a content migration.
- Correct translation authorship in bulk.
- Run entirely from the command line (Drush).
- Skip rows where the uid already matches.
- Report success/failure counts at the end.
- Avoid any web route or permission exposure.
