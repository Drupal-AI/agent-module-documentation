# Configuration

The settings form is at **Configuration → Content authoring → Content Moderation
Revision Delete** (`/admin/config/content/cm_revision_delete`), gated by the
**`administer cm_revision_delete`** permission.

## Set your retention policy

- **Revisions to keep (per node)** — how many revisions to preserve for each node.
  Anything beyond this count is eligible for deletion. The current default
  (published) revision and the latest moderation‑state revision are always kept,
  regardless of this number.
- **Applicable content types / moderation states** — choose which content types
  participate in pruning and which moderation states you consider "keepable." Review
  these carefully before the first run so you don't prune revisions you'd want to
  retain.

Retention is expressed as a **count** of revisions to preserve per node, not an age.
The module walks your nodes, honours Content Moderation, and removes only the
surplus historical revisions.

## The developer tools form

A second form at `/admin/config/content/cm_revision_delete/devel` (same permission)
lets you exercise the pruning logic while you're setting things up — useful for
confirming your settings behave as expected before you rely on cron. Both forms are
standard Drupal forms, so form‑token (CSRF) protection applies, and there are no
public or anonymous routes.

## How pruning runs

Once configured, pruning happens automatically on **cron** runs (via the queue), so
make sure cron is running regularly on your site. The module only deletes
revisions — never the current published content and never the entities themselves.

## Save

Save the form. On the next cron run, surplus revisions beyond your retention window
will begin to be cleaned up.
