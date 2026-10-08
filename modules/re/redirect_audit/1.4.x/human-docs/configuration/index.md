# Configuration

Redirect Audit has a small settings form that controls when it scans and how it
behaves on large tables, plus a dashboard where you run audits and act on the
results.

## Open the settings form

1. Log in as a user with the **administer redirect audit** permission.
2. Go to `/admin/config/search/redirect/audit/settings`.

## The audit settings, field by field

- **Scan on Change** — when enabled, the module automatically re-scans when
  redirects are created or modified, so problems are caught as they appear rather
  than only when you run a manual audit. Turn it off if you would rather scan on
  your own schedule (recommended on very large tables, where every change would
  otherwise trigger work).
- **Auto-fix Enabled** — choose between manual review and automatic resolution.
  When on, detected **chains** are resolved automatically as they are found; when
  off, chains are listed for you to fix with the dashboard's one-click action.
  Either way, **loops are never auto-fixed** — they are always flagged for manual
  review.
- **Batch Size** — how many redirects to process per batch. Auditing runs through
  the Batch API to avoid timeouts; a smaller batch size is gentler on a big table
  but takes more batches, a larger one is faster but heavier per step.
- **Maximum Chain Depth** — how many hops the audit follows along a chain, between
  **5 and 50**. Deeper means it can detect longer chains but does more work per
  redirect.

## Save

Click **Save configuration**.

## Running an audit and reading the dashboard

Go to the dashboard at `/admin/config/search/redirect/audit`. It offers:

- **Summary statistics** — total chains found, loops detected, and redirects
  analysed.
- A **results table** — each row shows the source path, the intermediate links,
  the target path, and the issue type (chain or loop). The chain paths are
  clickable, taking you straight to the relevant redirect edit forms.
- **Action buttons** — **Audit** (scan all redirects), **Fix** (bulk-resolve the
  detected chains, rewriting each source to its final destination), and **Clear**.

Loops appear in the results but must be resolved by hand, since collapsing a
circular reference automatically is not safe.

## Operational advice

- **Auditing generates requests.** On a table with thousands of redirects that is
  significant traffic — prefer running scans off-peak, and use the batch size to
  keep each step manageable.
- **Results are a snapshot.** A redirect that resolves cleanly today can break
  when its target is later unpublished. Re-audit on a schedule (or leave
  **Scan on Change** on where the table size allows) rather than trusting a single
  clean run.
