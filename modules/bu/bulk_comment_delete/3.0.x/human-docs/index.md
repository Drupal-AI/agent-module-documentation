# Bulk Comment Delete — manual setup guide

**Bulk Comment Delete** (`bulk_comment_delete`) lets an administrator delete
comments in bulk, grouped by the content type of the node each comment is
attached to. Instead of removing comments one at a time, you get a form listing
your content types with their comment counts, a confirmation step, and then the
deletions run through Drupal's Batch API so a large clean-up does not hit a PHP
timeout.

It is aimed at clean-up jobs: purging spam across a whole content type, clearing
test comments left over from QA, or resetting a content type's discussion during
a relaunch.

Deleting comments is destructive and there is no undo, so the tool always shows a
confirmation step before it runs, and it is gated by its own permission. It uses
Drupal's entity API to perform the deletions. It depends on core's **Comment**
module and supports Drupal 8 through 10.

Note: the permission's machine name contains a typo — **`administer bulk commnet
delete`** (misspelled "commnet"). That is the string you will see when granting
it, so it is documented here as-is.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core Comment).

## Where it lives in the admin menu

The tool is under the admin content area at `/admin/content/bulk-comments`, with
its confirmation step at `/admin/content/bulk-comments/delete`. Both are gated by
the module's **administer bulk commnet delete** permission (spelling as above).

## How to use it

1. Install and enable `bulk_comment_delete` (see
   [Installation](installation/index.md)).
2. Grant the **administer bulk commnet delete** permission to the roles that
   should be able to run bulk deletions (typically trusted admins/moderators).
3. Go to `/admin/content/bulk-comments`. You will see each content type with the
   number of comments attached to nodes of that type.
4. Select the content type(s) whose comments you want to remove and continue to
   the confirmation step.
5. Confirm. The matching comments are deleted in a batch. Because this is
   destructive with no undo, double-check your selection — and ideally back up —
   before confirming.
