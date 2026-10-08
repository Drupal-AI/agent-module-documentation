<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Files Download Permission (machine name `pfdp`) controls who may download files out of Drupal's **private file system** by registering directory paths and listing the roles and/or individual users allowed to read from each of them.

---

The whole module is one `hook_file_download()` implementation (`pfdp_file_download()`) plus a `pfdp_directory` **config entity** and a settings form. Each directory entity stores a `path` (relative to the `file_private_path` setting, always with a leading slash and no trailing slash), a `bypass` flag, a `grant_file_owners` flag, and `users` / `roles` lists. On every private download Drupal calls the hook: public URIs are ignored, then the permission `bypass pfdp` (and `bypass pfdp for temporary files` for `temporary://` URIs) short-circuits to "allowed"; otherwise the module finds the **longest matching** registered directory for the file's path and allows the download if the directory is set to bypass, if `grant_file_owners` is on and the requester owns the file entity, if the requester's uid is in `users` (only when the `by_user_checks` setting is on), or if any of the requester's roles is in `roles`. Anything else returns `-1`, i.e. access denied — **and a private file in no registered directory is denied too**. Five booleans in `pfdp.settings` tune it: `by_user_checks`, `cache_users`, `attachment_mode` (send `Content-Disposition: attachment` instead of `inline`), `override_mode` (stream the file immediately with `BinaryFileResponse` and `exit()`, skipping the rest of the validation chain) and `debug_mode` (log every grant/deny to the `pfdp` channel). Beware a packaging bug in 3.1.x: `config/install/pfdp.settings` is missing its `.yml` extension, so `pfdp.settings` **does not exist until the settings form is saved once** — every setting reads as `NULL`/off on a fresh install.

---

- Let only the "member" role download PDFs from a private `/downloads` directory.
- Give a single named user access to a private `/contracts` folder without creating a role.
- Allow file owners to re-download their own uploads while everybody else is blocked.
- Lock down the whole private file system by registering `/` and granting nothing.
- Open one subdirectory to all authenticated users while the rest of the private tree stays closed.
- Exempt a subdirectory from the module entirely with the per-directory *Bypass* flag so other modules decide.
- Give administrators unconditional access with the `bypass pfdp` permission.
- Let a role download temporary files (image-style derivatives, in-progress uploads) via `bypass pfdp for temporary files`.
- Force files to download as attachments rather than opening in the browser (`attachment_mode`).
- Serve large private files immediately with `override_mode` when other `hook_file_download()` implementations are getting in the way.
- Debug "why was this download denied?" by turning on `debug_mode` and reading `drush watchdog:show --type=pfdp`.
- Turn off `by_user_checks` on a site with hundreds of thousands of users to keep downloads fast.
- Cache the user list (`cache_users`) so the directory edit form stays usable on a large site.
- Protect a client-portal folder per customer role in a multi-tenant setup.
- Restrict invoices under `/billing` to a finance role.
- Give a "students" role access to `/course-materials` and nothing else.
- Delegate module configuration to a non-administrator role with `administer pfdp`.
- Combine several nested directory rules and rely on longest-prefix matching for the most specific one.
- Deploy download permissions as configuration (`pfdp.pfdp_directory.*` entities) through `drush config:import`.
- Audit who can currently download from a path by reading the directory entity's `users` and `roles`.
- Migrate away from a custom `hook_file_download()` implementation to configuration.
- Guard media files attached to restricted content when the media entity itself is not access-controlled.
- Keep employee documents private on an intranet while the rest of the site is public.
- Prove to auditors, from exported config, exactly which roles can read a private directory.
