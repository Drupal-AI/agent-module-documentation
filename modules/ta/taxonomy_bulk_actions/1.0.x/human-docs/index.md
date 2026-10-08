# Taxonomy Bulk Actions — manual setup guide

**Taxonomy Bulk Actions** (`taxonomy_bulk_actions`) adds checkboxes and a
bulk‑action selector to Drupal's taxonomy term overview page, so you can act on
many terms at once instead of editing them one at a time. Out of the box it lets
you **delete**, **publish**, or **unpublish** any set of selected terms in a
single operation.

On the term listing for a vocabulary, the module adds a checkbox next to every
term, a "select/deselect all" toggle, a dropdown of available actions, and an
"Apply to selected items" button. You tick the terms you want (or select them
all), choose an action, and apply it — the module then processes the terms in a
Drupal Batch so even large vocabularies run without timing out, and shows a
completion message when it finishes. This makes short work of tidying up a messy
vocabulary, purging obsolete tags after a migration, or unpublishing seasonal
terms.

The module has **no settings page and defines no permissions of its own**. It
relies entirely on core taxonomy permissions: the term overview page already
requires *Administer taxonomy* (`administer taxonomy`), and each action carries
its own check — Delete needs *Delete terms* in that vocabulary
(`delete terms in <vid>`) or *Administer taxonomy*, while Publish and Unpublish
require *Administer taxonomy*. Developers can add their own bulk operations via
the `taxonomy_bulk_actions` plugin type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. The bulk‑action controls appear directly on
the **taxonomy term overview page** for each vocabulary, at
**Structure → Taxonomy → *(your vocabulary)* → List** (a URL like
`/admin/structure/taxonomy/manage/tags/overview`). You need the *Administer
taxonomy* permission to reach that page at all.

## How to use it

1. Go to the term overview for a vocabulary under **Structure → Taxonomy**.
2. Tick the checkbox beside each term you want to act on, or use the
   select‑all toggle at the top to select every term in the vocabulary.
3. Choose an action from the dropdown — **Delete selected terms**, **Publish
   selected terms**, or **Unpublish selected terms**. The list only shows
   actions you have permission to run.
4. Click **Apply to selected items**. The module processes the terms in a batch
   and shows a summary message when it is done.

Because deletion is permanent, double‑check your selection before applying the
Delete action. If your team needs a bulk operation the module doesn't ship —
setting a field value across many terms, for instance — a developer can add one
by writing a `taxonomy_bulk_actions` plugin, optionally limiting it to specific
vocabularies and gating it behind a permission of its choice; see the sibling
[`agent/plugins/action.md`](../agent/plugins/action.md).
