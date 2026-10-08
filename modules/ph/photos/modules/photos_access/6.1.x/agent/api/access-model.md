<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access model (node grants, tables, Views, password)

## Node access grants

Photos access enforces album privacy through Drupal's node access system (only for node types
whose `photos.settings:photos_access_<type>` flag is on):

- `hook_node_access_records($node)` (`photos_access_node_access_records`) writes grant rows for
  the album based on its `viewid`:
  - author always gets view/update/delete;
  - **Open** (0): a public `grant_view` for everyone;
  - **User list** (2): listed users get view (and update if they may collaborate);
  - **Locked/Password**: no public view grant (only author/allowed users/session grant).
- `hook_node_grants($account, $op)` (`photos_access_node_grants`) returns the realms the current
  user holds: `photos_access_author` (their uid), open-album, per-user grants, and — after a
  visitor submits a correct album password — a session-based `photos_access` grant read from
  `$session->get('photos_access_passwords')`.

Because grants are involved, changing the `photos_access_<type>` flag or an album's privacy may
require a **node access rebuild** (`node_access_rebuild()`).

## Storage tables (`photos_access.install`)

- `photos_access_album`: `nid`, `viewid` (0 Open / 1 Locked / 2 User list / 3 Password),
  `pass` (hashed password for mode 3).
- `photos_access_user`: `id` (album id), `uid`, `collaborate` (0/1 — may the user edit).

Helper functions manage these: `_photos_access_usersave()`, `_photos_access_userlist()`,
`_photos_access_usersdel()`, `photos_access_update_access()`, `_photos_access_pass_type()`,
`photos_access_pass_validate()`.

## File-system moves

`photos_access_move_files($node, $public)` moves an album's image files between the **public** and
**private** file systems when its privacy changes, so private album images are not served from the
public files directory. Triggered from the privacy form submit / node update path.

## Password flow

- Route `photos_access.page` → `/photos_privacy/pass/{node}`
  (`DefaultController::photosAccessPasswordPage`) shows `PhotosAccessPasswordForm`.
- A correct password stores a session grant so the visitor can view that album for the session.

## Views access plugin

- `Plugin/views/access/PhotosAccess` (plugin id `photos_access`) — select it as a View's *Access*
  method to gate a Views page/display with the same album-access logic.

## Migrate (Drupal 7 → 10/11)

- Source/destination plugins `PhotosAccess` and `PhotosAccessUser`
  (`Plugin/migrate/source|destination/`) bring D7 album access settings and per-album user lists
  forward. Migration state file: `migrations/state/photos_access.migrate_drupal.yml`.

## Agent notes

- The submodule adds **no** config object of its own; the only config it touches is
  `photos.settings:photos_access_<type>` (the master switch). Per-album privacy is **DB state**,
  not config — read/write `photos_access_album` / `photos_access_user` directly (or via the node
  form).
