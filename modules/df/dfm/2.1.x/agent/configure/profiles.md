<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DFM profiles, access and integrations

## Access model
`/dfm/{scheme}` access = `Dfm::access($user, $scheme)` = does the user have a `dfm_profile` for that scheme?
- User 1 always gets the `admin` profile.
- Otherwise `dfm.settings:roles_profiles[rid][scheme]` maps the user's roles to a profile id; roles are evaluated most-permissive first.
- Default `roles_profiles` is empty ⇒ nobody but user 1 has access until you map a role.

Admin UI: `/admin/config/media/dfm` (permission `administer dfm`) shows the settings form + profile list. Profiles are `dfm_profile` config entities (add/edit/duplicate/delete under `/admin/config/media/dfm/...`, entity-access gated).

## Profile configuration (`conf`)
Ships with `member` and `admin` install profiles. A profile defines:
- `dirConf` — allowed folders and per-folder `perms` (browse/upload/delete/rename/move/copy/resize...), `subdirConf` inheritance.
- `uploadExtensions`, `imgExtensions`, `uploadMaxSize`, `uploadQuota`.
- Optional `chrootJail` to collapse to one top directory; optional `thumbStyle`.

`dfm.settings` extras: `merge_folders` (bidirectional folder-perm inheritance across a user's role profiles), `abs_urls`, `textareas` (regex of textarea ids to attach DFM to).

## Path-traversal defense
`Dfm::regularPath($path)` returns false for any path containing a backslash or a `.`/`..`(dot-only) segment, so profile folder names cannot escape the scheme root. Tokens in folder names are replaced via `\Drupal::token()` and unresolved tokens are dropped.

## Integrations
- CKEditor 5: enable DFM image/link buttons on a text format (`DfmCKEditor5Image/Link/Selector` plugins).
- BUEditor: select DFM as the file browser in the editor settings.
- File/image fields: tick "Allow users to select files from Drupella File Manager" on the widget (`DfmFileField`).

## Sync behavior
`DfmDrupal` registers hooks that, on upload/delete/rename/move/copy/resize, maintain `file_managed` records, enforce quota/overwrite/file-usage checks, and (when `fixBodyOnMove` is set) rewrite matching file URLs inside node/block `body` fields using parameterized `REPLACE()` updates.

## Note
The concrete file-operation engine is the bundled library at `library/core/Dfm.php` (loaded via `require_once`), which is outside `src/` and not covered by this doc.
