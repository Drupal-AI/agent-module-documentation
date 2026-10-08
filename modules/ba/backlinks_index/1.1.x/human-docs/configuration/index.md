# Configuration

## Open the settings form

1. Log in as a user with the **Administer backlinks_index** permission.
2. Go to **Configuration → Content authoring → Backlinks**, or navigate directly
   to `/admin/config/content/backlinks`.

The form shows the current size of the index ("*N* backlinks indexed for *N*
nodes") and offers:

- **Bundles** — checkboxes for which node types are scanned for links. Only the
  bundles you tick are indexed on save.
- **Save** — stores your bundle selection.
- **Reindex** — runs a batch job that re-scans every node and rebuilds the index
  from scratch.
- **Purge** — empties the index (truncates the backlinks table and resets the
  per-node flag). Useful before a full reindex or when removing the feature.

## Build the index

New and edited nodes are indexed automatically the moment they are saved.
Existing content is not scanned until you ask for it, so after choosing your
bundles run **Reindex** once from the settings form (or use Drush, below) to
populate the index. Reindexing again is also the right move after a large content
import.

## The per-node Backlinks tab

Any user with the **Access backlinks_index** permission sees a **Backlinks** tab
on each node (`/node/{node}/backlinks`). It lists the pages that link to that
node, with columns for **Title** (linking straight to the linking page's edit
form), **Occurrence** (how many times it links), **Type** and **Status**.

## Editor safeguard

When an editor unpublishes a node that still has pages linking to it, the edit
form shows a warning — a reminder that those pages will now point at a hidden
page and may 404. This is the main day-to-day value of the module.

## Drush commands

The same bulk operations are available from the command line:

```bash
drush backlinks_index:reindex   # alias: b_i:reindex — batch re-scan of all nodes
drush backlinks_index:purge     # alias: b_i:purge   — empty the index and reset flags
```

These are handy for scripting a rebuild after a deployment or a bulk import.
