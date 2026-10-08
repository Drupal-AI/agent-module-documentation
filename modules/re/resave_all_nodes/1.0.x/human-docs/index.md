# Resave All Nodes — manual setup guide

**Resave All Nodes** (`resave_all_nodes`) re-saves every node on your site, or
every node of one content type, using Drupal's Batch API so it does not time out.
This is the standard way to make presave logic that was added *after* content was
created actually take effect. A great deal of Drupal behaviour runs on save —
Pathauto generates URL aliases, Search API queues items for indexing, computed
fields populate, Metatag defaults resolve — so content created before that logic
existed simply does not have it. Touching every node fixes that, and batching
keeps the operation from timing out.

The module gives you two ways to do it: a form with a content-type selector, and a
Drush command for CI or long runs. On any site with real content volume, prefer the
Drush command — it avoids the browser round trip.

> **This is a heavy, wide-reaching operation — read before running.** A resave
> fires every presave and update hook on the site. Depending on your setup that
> can: regenerate path aliases (changing URLs), re-populate Search API and other
> queues, move `changed` timestamps, create a new revision per node if the content
> type creates revisions by default, and trigger anything subscribing to entity
> update events — including outbound integrations. Its single permission,
> **Resave all nodes**, is deliberately marked as a restricted permission; grant it
> only to trusted administrators. Test on a copy first, and consider running during
> a quiet window.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The trigger form and Drush command are the whole interface; usage is described in
"How to use it" below.

## Where it lives in the admin menu

The batch form sits at **Configuration → Development → Resave all nodes**
(`/admin/config/development/resave-all-nodes`). Access requires the **Resave all
nodes** permission.

## How to use it

**From the UI:**

1. Go to **Configuration → Development → Resave all nodes**
   (`/admin/config/development/resave-all-nodes`).
2. Optionally pick a single content type from the selector to limit the operation;
   leave it on all types to resave everything.
3. Submit the form and let the batch run to completion.

**From Drush (preferred for large sites):**

The module ships a Drush command that runs the same batch. Note that Drush core has
also provided an equivalent `entity:save` command since version 11.0.0-rc1, for
example:

```bash
# Re-save all nodes of the "article" type
drush entity:save node --bundle=article

# Re-save all nodes in chunks of 5
drush entity:save node --chunks=5
```

Either way, remember the side effects listed in the warning above before you run
it — especially on production content.
