<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & operate Backlinks Index

## Settings form
`/admin/config/content/backlinks` — permission **`administer backlinks_index`** (`BacklinksSettingsForm`).
- Shows current index size ("@backlinks backlinks indexed for @nodes nodes").
- **Bundles** — checkboxes selecting which node bundles are scanned; saved to config `backlinks_index.settings:bundles.selected`.
- Action buttons: **Save**, **Reindex** (runs the scan batch), **Purge** (truncates the `backlinks` table and resets the node flag).

## Node tab
`/node/{node}/backlinks` — permission **`access backlinks_index`**. Renders a table of linking nodes with columns Title (link to edit form), Occurrence, Type, Status.

## How indexing works (`BacklinksManager`)
- Triggered on `hook_node_postsave` for nodes in an allowed bundle (postsave provided by `hook_post_action`).
- Renders the node in the site default theme, strips comments/newlines, regex-extracts `href="…"`, skips external URLs (`isExternalLink` via `FILTER_VALIDATE_URL` + host compare).
- Resolves internal paths: direct `node/{id}`, then path alias (`path_alias.manager`), then Redirect source paths (`redirect.repository`); strips language prefixes; excludes self-links.
- Writes rows to `backlinks` (`source`, `backlink`, `langcode`, `timestamp`) and toggles the `backlinks` base field on `node_field_data`.

## Drush
- `drush backlinks_index:reindex` (alias `b_i:reindex`) — batch re-scan of all nodes.
- `drush backlinks_index:purge` (alias `b_i:purge`) — truncate index and reset flags.

## Editor safeguards
The node edit form and postsave add a warning when an unpublished node still has inbound backlinks (risk of 404s).
