# Configuration

Revision Cleanup is configured on a single settings form and then runs on cron. The
whole point of this page is one warning and two numbers.

## Read this first — deletion is irreversible

Once a revision is deleted it is **gone**. Revisions are often the only record of
who changed what, and keeping them can be a compliance obligation, not just a
convenience. Before you run cleanup on real data:

- **Agree the retention rule as a policy**, not just a form setting — how much
  history does this content genuinely need to keep?
- **Check whether revision history is a compliance requirement** for the content
  involved.
- **Test on a copy of production** first.
- **Take a backup** you can restore from.

Two interactions matter on a moderated site: the **default (current) revision must
never be pruned** — the module keeps it — and **content moderation states live on
revisions**, so pruning history affects moderation history and what "previous
state" means.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Revision Cleanup**
   (`/admin/config/system/revision-cleanup`).

## Set the retention rule

The form defines what to keep; everything else older than the rule becomes eligible
for deletion:

- **Days of revisions to keep** — recent revisions from the last *X* days are kept
  in full. Raising this preserves more recent history; lowering it prunes more
  aggressively.
- **Old revisions to retain per month** — for revisions older than the recent
  window, the module keeps *X* per calendar month, so you retain a thinned-out
  historical trail (for example one snapshot a month) instead of every save. Set it
  to keep as many monthly checkpoints as your history needs.

The module is multilingual-aware (it respects the different languages) and also
removes the associated Paragraphs revision data for the revisions it prunes.

Save the form to store the policy.

## Run the cleanup

Cleanup is queued and processed by cron rather than happening the instant you save:

1. **Wait for cron** to populate the queue with the revisions eligible for
   deletion.
2. **Wait for the next cron run** to process the queue and delete them — or force
   the queue immediately with Drush:

   ```bash
   drush queue-run revision_cleanup_processor
   ```

After the first run, confirm on a copy of production that the revisions you expected
to disappear are gone and the ones you meant to keep — especially the current
revision of each item — remain.
