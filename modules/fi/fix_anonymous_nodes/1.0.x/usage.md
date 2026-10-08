<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fix Anonymous Nodes bulk-reassigns nodes whose author account was deleted (so they show as Anonymous) to a single chosen user.
---
When a user account is deleted, their nodes are left with `uid` values that no longer resolve to a real account (or fall back to uid 0). This module provides one admin form at `/admin/content/fix-anonymous-nodes` that (1) selects the distinct `uid`s present in `node_field_data`, (2) diffs them against existing `users_field_data` uids to find orphaned authors, adds uid 0, then (3) loads each affected node and calls `setOwnerId()` to the target user before saving.

The form is gated by the dedicated `fix anonymous nodes` permission (marked `restrict access: TRUE`), and it validates that the chosen target user actually exists before running. All database reads use the parameterized query builder (no string-concatenated SQL). Each node is loaded and re-saved through the entity API, so hooks, revisions, and search indexing run normally — on large sites this can be slow and should be run in a maintenance window. There is no batch/queue; it processes all matching nodes in one request.

Typical setup: enable the module, grant the permission to a trusted admin role, then visit the form, pick the user to become the new author, and submit.
---
- Reassign all orphaned nodes to a fallback editorial account.
- Clean up authorship after deleting a departed staff member's account.
- Fix nodes displaying "Anonymous" as author after a user purge.
- Bulk-set a single owner for all uid-0 nodes.
- Grant only a trusted role the `fix anonymous nodes` permission.
- Restrict access so ordinary editors cannot mass-reassign authorship.
- Run the reassignment from `/admin/content/fix-anonymous-nodes`.
- Verify the target user exists before reassigning (form does this automatically).
- Consolidate authorship of imported/migrated content under one account.
- Re-home nodes whose authors were removed by a GDPR erasure request.
- Ensure node access grants recompute by re-saving each node.
- Trigger update hooks/search reindex as a side effect of re-saving nodes.
- Identify how many nodes are orphaned (status message reports the count).
- Use as a one-off remediation step after a bulk user deletion.
- Pair with a cron or drush user-cleanup routine that leaves orphaned content.
- Reassign content before archiving or deleting an old site section.
- Standardize the "owner" field for reporting/Views that group by author.
- Avoid broken author links on published pages caused by missing users.
- Run in a maintenance window on large sites (no batching).
- Audit the permission grant as part of a security review (restricted access).
