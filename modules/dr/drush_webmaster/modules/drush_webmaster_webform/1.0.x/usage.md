<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush Webmaster: Webform adds `wm:webform:*` and `wm:webform:submission:*` Drush commands to list, inspect, export, duplicate and delete webforms and manage their submissions from the command line for AI-assisted site administration.

---

This submodule of Drush Webmaster provides a `WebformCommands` class (backed by a `WebformManager`
service) that wraps the contributed Webform module. It lets an agent or webmaster list webforms with
submission counts, get a form's full configuration (elements, handlers, settings), export a form as
YAML for backup/migration/version control, duplicate a form under a new machine name and title, and
delete a form (protected against accidental data loss unless `--force`). For submissions it can list,
get full submission data, delete a single submission, or purge all submissions for a form. Like the
rest of Drush Webmaster it is CLI-only with no routes or admin UI. It requires the base
`drush_webmaster` module and the contributed `webform` module. This is a 1.0.0-beta1 pre-release.

Submission data can contain personal information, and purge is irreversible, so prefer `--dry-run`
and export submissions from the Webform UI before destructive operations.

---

- List all webforms with title, status, category and submission count (`wm:webform:list`).
- Get a webform's full configuration: elements, handlers, settings (`wm:webform:get`).
- Export a webform as YAML for backup, migration or version control (`wm:webform:export`).
- Duplicate a webform under a new machine name and title (`wm:webform:duplicate`).
- Preview a duplication with `--dry-run` before creating it.
- Delete a webform, with protection against deleting one that has submissions (`wm:webform:delete`).
- Force-delete a webform and all its submissions with `--force`.
- List a webform's submissions with metadata (sid, serial, created, uid, draft) (`wm:webform:submission:list`).
- Get a single submission's full field data (`wm:webform:submission:get`).
- Delete a single submission (`wm:webform:submission:delete`).
- Purge all submissions for a webform (`wm:webform:submission:purge`).
- Check how many submissions would be purged with `--dry-run` before executing.
- Migrate a form between environments by exporting YAML on one site and recreating on another.
- Clear test submission data before launching a form.
- Let an AI assistant inspect and manage webforms through structured commands.
- Read machine-readable form structure to help build or edit forms.
