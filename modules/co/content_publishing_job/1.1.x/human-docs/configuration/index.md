# Configuration

Content Publishing Job has two parts to set up: the unpublish jobs (the main
feature) and, optionally, the Related contents block.

## Create an unpublish job

1. Go to **Configuration → System → Publishing config**
   (`/admin/config/system/publishing-config`). This is the collection of
   `publishing_config` job entities.
2. Add a job. Each job pairs:
   - a **content type** — the nodes it applies to, and
   - a **date field** — the field whose value decides when a node has expired.
     The field must exist on that content type; both plain date and datetime-range
     style fields are supported.
3. Save the job. You create **one job per content type** — to stop expiring a
   content type later, delete its job.

Once a job exists, every cron run finds published nodes of that type whose chosen
date field is in the past, queues them, and unpublishes them in the background.
The worker re-checks the date before unpublishing, and only ever acts on
already-published nodes.

> **Cron is required.** Nothing expires unless cron runs. Confirm Drupal cron is
> scheduled (or run `drush cron`) so the queue is processed.

> **Content Moderation caveat.** The worker calls unpublish directly, bypassing
> Content Moderation state transitions. On moderated sites this force-unpublishes
> regardless of the node's moderation state — consider whether that's acceptable
> before using it on moderated content types.

## Place the Related contents block (optional)

The second feature is a block that lists other content related to the current
node by a shared taxonomy term.

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Related contents** block in the region where you want it to appear.
3. In the block's settings, configure it to relate content by the taxonomy term
   field you use. The block shows recent published content of the same type that
   shares the term, excluding the current node.
4. Save the block.

## Permissions

Review block placement and any related permissions after enabling, then confirm
the setup by placing the block and creating at least one publishing job as
described above.
