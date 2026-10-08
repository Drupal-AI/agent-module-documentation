<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation Owner Manager - agent index

**Drush-only** tool to change the `uid` (author) of a specific node translation. Version **1.0.3**, core `^9 || ^10`. Depends on `content_translation`.

- `translation-owner:update-uid <nid> <langcode> <new_uid>` (aliases `tou`, `translation-owner-update`).
- `translation-owner:bulk-update <csv>` - columns `nid,langcode,new_uid`; writes a report CSV.
- Writes directly to `node_field_data`/`node_field_revision`; no web routes or permissions. Gated by shell access.