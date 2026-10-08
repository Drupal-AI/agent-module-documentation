<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Entity Auto Term

1. Go to `/admin/config/system/eat` (permission: `administer site configuration`). Only the `node` entity type is currently supported.
2. Expand a content type and check the vocabularies that its auto-terms should be created in. Save.
3. Create/edit nodes of that bundle — a term named after the node title is created (or reused) in each selected vocabulary, and the mapping is stored in the `{eat}` table. Editing the node renames the term; deleting the node deletes term + mapping.

## Backfill existing content
- Batch form: `/admin/config/system/eat/batch` → runs `Eat::matchupEntitiesToSet()`.
- Drush: `drush eatas <entity_id> <title> <vid>` (`eat-add-single`).

## Views
Use the argument-default plugin **"Content ID from path for EAT"** (id `eat`) to derive the mapped term id from the current node's path.

## Security caveat
`eat.batch_update` is gated by `_permission: 'access content'` (granted to anonymous by default) yet performs writes (term creation). Restrict/override this route's access before exposing the site publicly.
