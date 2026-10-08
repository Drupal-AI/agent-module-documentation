<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Photos access is a submodule of Photos that adds per-album privacy: each album can be Open, Locked (owner only), restricted to a list of users, or protected by a password, enforced through Drupal's node access grant system.

---

Once enabled, Photos access adds a **privacy** section to the album (node) edit form for any
content type whose `photos.settings:photos_access_<type>` flag is on (e.g. `photos_access_photos`
for the `photos` album type). The chosen setting is stored per album in the `photos_access_album`
table as a `viewid`: **0 = Open, 1 = Locked, 2 = User list, 3 = Password**, plus a `pass` hash for
the password mode; allowed users (and whether they may collaborate/edit) are stored in
`photos_access_user`. Enforcement is via node access: `hook_node_access_records()` writes grants
for each album and `hook_node_grants()` returns the grants the current user holds (author,
open-album, per-user, and — after a visitor submits the album password at
`/photos_privacy/pass/{node}` — a session-based password grant). It also moves an album's files
between the public and private file systems when its privacy changes
(`photos_access_move_files()`). The submodule provides a Views **access plugin** (`PhotosAccess`)
so you can gate Views pages with the same album-access logic, a password entry controller/form,
and D7 migrate source/destination plugins for legacy album access + user lists. It defines no
permissions or config schema of its own — its master switch is the `photos_access_<type>` flag in
the parent module's `photos.settings`, and per-album state lives in its two tables. Uninstalling
sets `photos_access_photos` back to 0.

---

- Lock a photo album so only its owner can view it.
- Password-protect an album and share the password with select visitors.
- Restrict an album to a specific list of users.
- Keep an album Open (public) while others on the site are private.
- Let designated users collaborate on (edit) a private album.
- Enable album privacy only for the `photos` content type via `photos_access_photos`.
- Enable album privacy for another album-like content type via its `photos_access_<type>` flag.
- Automatically move a private album's files into the private file system.
- Move files back to public when an album is made Open again.
- Gate a Views listing of albums with the Photos access Views access plugin.
- Prompt anonymous visitors for a password at `/photos_privacy/pass/{node}`.
- Grant per-visitor, session-scoped access after a correct album password.
- Build a members-only gallery where each album has its own user list.
- Hide unpublished/locked albums from anonymous users via node grants.
- Combine open and password albums on the same site.
- Migrate Drupal 7 album access settings and user lists into Drupal 10/11.
- Give an album author full view/edit/delete grants automatically.
- Present a friendly "please enter password" page for protected albums.
- Change an album from Locked to Open and have access + file locations update.
- Enforce album privacy consistently across node view and Views pages.
- Protect family/private photo sets on an otherwise public site.
- Let a photographer share a client's proofs behind a password.
- Restrict sensitive event photos to invited users only.
- Ensure private album images are not served from the public files directory.
