<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration

`download_count.views.inc` implements `hook_views_data()` and `hook_views_data_alter()`,
exposing the raw `download_count` event log as a Views base table so you can build custom
download reports.

- **Base table:** `download_count`, group "Download history", base field `dcid`.
- **Joins / relationships:**
  - Auto-join to `file_managed` on `fid` (both directions;
    `hook_views_data_alter()` also adds the reverse join from `file_managed`).
  - Relationship `fid` → base `file_managed` (label "File").
  - Relationship `uid` → base `users_field_data` (label "User").

## Fields / filters / sorts / arguments
| Column | Field | Filter | Sort | Argument |
|---|---|---|---|---|
| `dcid` | numeric (click-sortable) | numeric | standard | numeric |
| `fid` | — (relationship to File) | — | — | — |
| `uid` | — (relationship to User) | — | — | — |
| `type` (entity type) | standard | standard | standard | string |
| `id` (entity id) | numeric | numeric | standard | numeric |
| `referrer` | url | string | standard | — |
| `ip_address` | standard | string | standard | string |
| `timestamp` | date | date | date | — |

Because this is the raw event table, a Views report can list each individual download with its
user, IP address, referrer and timestamp, or aggregate them with Views' own count/group-by.
There is no Views data for `download_count_cache`.
