# Configuration

Fix Anonymous Nodes has no ongoing settings — its "configuration" is a single
action form that you run when you need it. This page walks through that form and,
just as importantly, the precautions to take before you submit it.

> **Back up first.** This form re‑writes node authorship directly in your
> database. Take a full database backup before running it, and prefer to run it in
> a **maintenance window** — it processes every matching node in one request with
> no batching, and re‑saving each node triggers save hooks, revisions, and search
> re‑indexing, which can be slow on a large site.

## Open the form

1. Log in as a user with the **Fix anonymous nodes** permission (see
   [Installation](../installation/index.md)).
2. Go to **Content → Fix Anonymous Nodes**, or navigate directly to
   `/admin/content/fix-anonymous-nodes`.

## The reassignment form

The form has essentially one decision to make:

- **Target user** — the existing account that will become the new author of all
  orphaned nodes. Pick the account you want the reassigned content to belong to
  (commonly `admin` or a dedicated editorial account). The form validates that
  the chosen user actually exists before it runs, so you can't accidentally
  reassign content to a missing account.

When you submit, the module:

1. Looks at the distinct authors currently recorded on your nodes.
2. Works out which of those no longer match a real user account, and includes
   uid 0 (Anonymous).
3. Loads each affected node and sets its owner to your chosen target user, then
   saves it.

## After running

The form reports how many nodes were affected in a status message. Because each
node is re‑saved through Drupal's entity API, node access grants are recomputed,
update hooks fire, and the content is re‑indexed for search — so author links on
published pages that previously read "Anonymous" should now point at your chosen
user. Spot‑check a few of the affected pages to confirm the new authorship looks
right.
