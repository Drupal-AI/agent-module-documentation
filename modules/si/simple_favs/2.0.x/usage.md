<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple favourites gives site visitors a lightweight way to bookmark content, storing favourites in a browser cookie for anonymous users and (optionally) in the database for logged-in users.

---

The module provides heart/favourite blocks, a Views field, a "My favourites" management page at `/my-favourites`, and a set of JSON endpoints for reading and writing favourites. A settings form at `/admin/config/simple_favs/settings` (permission `administer simple favs`) toggles database storage and display limits. Favourites are keyed by the current user server-side: the database controllers (`SimpleFavsStorageController`, `SimpleFavsStorageOtherController`, `SimpleFavsManageController`) all derive the uid from `currentUser()` — never from the request — reject anonymous writes (uid 0), and store node ids in `simple_favs_user` and arbitrary path/title favourites in `simple_favs_user_other`. A public titles endpoint (`/simple-favs/titles`, `_access: 'TRUE'`) only returns titles of published nodes and runs an access-checked entity query.

Security review: there is **no IDOR** — because every read/write scopes to the authenticated uid and the `_access: 'TRUE'` endpoint exposes only published, access-checked node titles, a user cannot read or modify another user's favourites or arbitrary entities. The mutating endpoints (`/simple-favs/set-user-favs`, `/set-user-favs-other`, `/save-titles`) are gated by `access content`, reject anonymous users and read a JSON request body. Stored favourites are module-written `serialize()` arrays of node ids. Typical setup is enabling the module, placing a heart block, and optionally turning on database storage for authenticated users.

---

- Let anonymous visitors bookmark content via cookies
- Store logged-in users' favourites in the database
- Add a heart/favourite toggle block to content
- Show a favourites count or list block
- Provide a "My favourites" page at /my-favourites
- Add a favourite toggle as a Views field
- Favourite nodes and arbitrary paths
- Fetch node titles for favourite ids via JSON
- Read the current user's stored favourites
- Save the current user's favourites via POST
- Manage and rename saved favourites
- Remove favourites from the management page
- Limit how many favourites a block displays
- Toggle database vs cookie storage in settings
- Restrict settings to `administer simple favs`
- Scope every favourite to the authenticated user
- Add a favourite directly from a Views row
- Translate favourite titles per language
- Invalidate per-user favourite caches on change
- Bookmark taxonomy or other path-based content
