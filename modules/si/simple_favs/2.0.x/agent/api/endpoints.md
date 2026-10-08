<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple favourites endpoints & storage

## JSON endpoints (all scope to the current user server-side)
| Route | Path | Method | Access | Purpose |
|---|---|---|---|---|
| get_titles | `/simple-favs/titles` | GET | `_access: TRUE` | titles of published, access-checked nodes for given `ids` |
| get_user_favs | `/simple-favs/get-user-favs` | GET | access content | current user's node favs |
| set_user_favs | `/simple-favs/set-user-favs` | POST | access content | replace current user's node favs |
| get_user_favs_other | `/simple-favs/get-user-favs-other` | GET | access content | current user's path favs |
| set_user_favs_other | `/simple-favs/set-user-favs-other` | POST | access content | replace current user's path favs |
| set_user_favs_other_from_views | `/simple-favs/set-user-favs-other-from-views` | POST | access content | add one path fav (title resolved server-side) |
| save_titles | `/simple-favs/save-titles` | POST | access content | rename/reorder favs |

## Storage
- `simple_favs_user` — `uid` → `serialize()`d array of node ids.
- `simple_favs_user_other` — `{uid, path, title, langcode}` rows for non-node favs.
- Whether the DB is used at all depends on `use_database_storage`; anonymous
  users always use cookies (uid 0 short-circuits DB writes).

## Security properties
- **uid always from `currentUser()`** — never from the request body/query — so
  there is no cross-user IDOR; anonymous writes throw `AccessDeniedHttpException`.
- The POST mutators parse the raw request body.
