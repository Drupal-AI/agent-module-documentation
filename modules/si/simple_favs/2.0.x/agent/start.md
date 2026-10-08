<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple favourites (simple_favs) — agent index

**Cookie- and optionally database-backed favourites/bookmarking for nodes and paths, with blocks, a Views field and a management page.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11
- **Permissions:** `administer simple favs` (settings only)
- **Routes:** settings (`/admin/config/simple_favs/settings`, `administer simple favs`); `/my-favourites` and JSON endpoints (`/simple-favs/get-user-favs`, `/set-user-favs`, `/get-user-favs-other`, `/set-user-favs-other`, `/set-user-favs-other-from-views`, `/save-titles`) all `access content`; `/simple-favs/titles` **`_access: 'TRUE'`**
- **Blocks:** SimpleFavsBlock, SimpleFavsHeartBlock; Views field SimpleFavsViewsHeart
- **Configure:** `simple_favs.simple_favs_settings_form`

**Security:** No IDOR — every read/write scopes to `currentUser()` (uid from session, not request) and anonymous DB writes are rejected; the `_access:'TRUE'` titles endpoint returns only published, access-checked node titles. Mutating endpoints read a raw JSON body.

See [api/endpoints.md](api/endpoints.md)
