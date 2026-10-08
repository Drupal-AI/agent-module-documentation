# Term Merge Manager — manual setup guide

**Term Merge Manager** (`term_merge_manager`) makes taxonomy merges *stick*. The
[Term Merge](https://www.drupal.org/project/term_merge) module lets you merge one
taxonomy term into another — but it only acts on the terms that exist at the moment
you run it. If the same duplicate term gets created again later (say a nightly feed
keeps re‑importing "USA" after you standardized on "United States"), you have to merge
it all over again. Term Merge Manager solves that by remembering every merge as a
reusable rule and re‑applying it automatically.

Here is how it works. Whenever you perform a merge with Term Merge, this module quietly
records it: it stores the surviving **target** term and each **source** name that
folded into it. From then on, any time a new term is created whose vocabulary and name
match a stored source rule, the module intercepts it *as it is saved* and turns it back
into the existing target term — copying the target's name, description, and fields —
instead of letting a duplicate appear. The result is a "self‑healing" vocabulary that
collapses known variants on its own.

There are a couple of nice extras. If the [Redirect](https://www.drupal.org/project/redirect)
module is enabled with auto‑redirect turned on, each merge also creates a 301 redirect
from the old term's URL to the target — preserving SEO when you consolidate tag pages.
And when you delete a target term, the module cleans up all of its merge rules
automatically, so nothing stale is left behind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it
   alongside Term Merge, and grant permissions.

There is no settings form. Once installed, the module works automatically; you only
visit its rule lists if you want to review or remove a rule (see below).

## Where it lives in the admin menu

The module has no configuration page. It adds two rule‑management lists under
**Structure**:

- **Term merge from** (`/admin/structure/term_merge_from`) — the source names that get
  folded into a target.
- **Term merge into** (`/admin/structure/term_merge_into`) — the surviving target
  terms.

## How to use it

For everyday use there is nothing to do — just keep using Term Merge as normal, and
Term Merge Manager records and re‑applies each merge behind the scenes.

You only need the admin lists in special cases:

- **Review past merges.** Browse `/admin/structure/term_merge_from` and
  `/admin/structure/term_merge_into` to see which names fold into which targets — handy
  for auditing how a vocabulary was consolidated.
- **Undo the automatic behavior for one name.** If you want a previously‑merged name to
  be allowed to exist again as its own term, delete its rule from the **Term merge
  from** list. New terms with that name will then save normally.

Editors who have the *View term merged manager messages* permission also see an
on‑screen notice when a term they created was automatically merged, so the behavior
isn't a surprise.
