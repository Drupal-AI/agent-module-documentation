# Term Merge — manual setup guide

**Term Merge** (`term_merge`) lets editors collapse two or more taxonomy terms in the
same vocabulary into a single term. Crucially, before it deletes the extra terms it
**re-points every piece of content** that referenced them at the surviving term — so
nothing loses its tag. It's the tool you reach for when a free-tagging vocabulary has
drifted into duplicates like "Bicycle", "Bicycles", and "Bike", or when a migration
left behind case-variant and misspelled terms.

You run a merge through a short three-step wizard hung off each vocabulary's term
list: pick the terms to merge, choose the survivor (either a brand-new term you name
on the spot or an existing term in the same vocabulary), and confirm. Under the hood
it hands the reference-rewriting to the required **Term reference change** module, so
entity-reference fields on nodes, media, users, paragraphs, and the like are all
updated in bulk.

Two things are worth stressing up front. First, **a merge is destructive and cannot
be undone** — the source terms are permanently deleted. The confirm step shows you
exactly which terms will disappear, so review it before committing. Second, access is
deliberately gated by **two** permissions (see [How to use it](#how-to-use-it)) — a
common reason the "Merge" tab doesn't appear is that only one of them was granted.

For developers, the same work is available from a service (`term_merge.term_merger`)
you can call from scripts or update hooks, and a `term_merge.terms_merged` event fires
just before deletion so other code can react. This module ships no settings form, no
configuration, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the service API and
the event — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (plus its Term
   reference change dependency) and enable the module.

## Where it lives in the admin menu

There's no settings page. The feature appears as a **Merge** tab next to *List terms*
on each vocabulary: **Structure → Taxonomy → *(vocabulary)* → List terms → Merge**
(`/admin/structure/taxonomy/manage/{vocabulary}/merge`).

## How to use it

### Grant the two permissions

To merge terms, a user needs **both** of these:

1. **Merge taxonomy terms** — the module's own permission (flagged as
   security-sensitive, because merging deletes terms).
2. Per vocabulary, either core's **Edit terms in *(vocabulary)*** permission *or* the
   global **Administer taxonomy** permission.

So, for an editor who should tidy up only the "Topics" vocabulary:

```bash
drush role:perm:add content_editor 'merge taxonomy terms'
drush role:perm:add content_editor 'edit terms in topics'
```

Or a taxonomy admin who can merge everywhere:

```bash
drush role:perm:add taxonomy_admin 'merge taxonomy terms'
drush role:perm:add taxonomy_admin 'administer taxonomy'
```

If you grant only "Merge taxonomy terms" and the Merge tab still doesn't show, it's
because the second permission is missing.

### Run a merge

1. Go to **Structure → Taxonomy**, open the vocabulary, and choose **List terms →
   Merge**.
2. **Step 1 — pick the terms.** Tick two or more terms you want to combine, then
   continue.
3. **Step 2 — choose the survivor.** Either type a **new term name** (a fresh
   canonical term is created) *or* pick an **existing term** from the same
   vocabulary. Choose exactly one of the two.
4. **Step 3 — confirm.** Review the list of terms that will be deleted, then
   **Confirm merge**. All content that referenced the removed terms is repointed at
   the survivor, and you'll see a "Successfully merged …" message.

> If you also have the optional [Synonyms](https://www.drupal.org/project/synonyms)
> module installed, step 1 offers an extra option to carry the old term labels over as
> synonyms on the surviving term.

### A note for developers

Merging in bulk (from an update hook, a Drush script, or a queue worker) can be done
by calling the `term_merge.term_merger` service directly — but note the service does
**no** access checking, so guard it appropriately in your own code. See the
[`agent/`](../agent/start.md) docs for the method signatures and the
`term_merge.terms_merged` event.
