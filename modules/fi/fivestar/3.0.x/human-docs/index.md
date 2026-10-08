# Fivestar — manual setup guide

**Fivestar** (`fivestar`) adds a clean, AJAX‑powered star‑rating widget to Drupal
content. Visitors click a star and their rating is recorded without a page reload;
the field can then display the community average as filled stars, a numeric score
like "4.2/5", or a percentage like "92". It works on any fieldable entity — not just
nodes, but users, comments, taxonomy terms, and media too — so you can let people
rate articles, review products, or score anything you can attach a field to.

Under the hood, Fivestar is built on the
[Voting API](https://www.drupal.org/project/votingapi) module: it provides a
**Fivestar rating** field type that stores each rating and mirrors it into a Voting
API vote, so all the aggregation and reporting machinery of Voting API is available.
Each field is tied to a **vote type** (a "rating axis" like *quality* or
*satisfaction*), which means one entity can carry several independent ratings. You
get two widgets for capturing ratings — interactive stars, or a plain accessible
select list — and three formatters for displaying them.

Fivestar is highly tunable per field: choose the number of stars (1–10), whether
users can change or clear their vote, whether they may rate their own content, and
whether rating happens while *viewing* the entity or while *editing* it. A pluggable
skin system swaps the star imagery — Hearts, Flames, Oxygen, Minimal, and more — with
no CSS work, and developers can register their own skins. A single **rate content**
permission controls who may vote, and there's a reusable `#type => 'fivestar'` form
element plus services for casting and reading votes from custom code.

One practical note: although the module's info file points at a central admin
overview page, that route isn't actually registered in this version — so there is
**no central Fivestar settings page**. All configuration happens per field, on the
standard Manage fields / Manage form display / Manage display screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Voting API)
   and enable the module.
2. [Configuration](configuration/index.md) — add a rating field, set its options,
   choose widgets, formatters, and skins, and grant the voting permission.

## Where it lives in the admin menu

There's no central settings page. You configure Fivestar wherever you manage a
bundle's fields — for a content type, that's **Structure → Content types → [type]**
and its **Manage fields**, **Manage form display**, and **Manage display** tabs.
Vote types are managed under **Structure → Vote types**
(`/admin/structure/vote-types`), and voting access is granted at **People →
Permissions**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add a **Fivestar rating** field to the entity/bundle you want rated.
3. Set the field's options (stars, voting rules, rate‑while‑viewing vs editing) and
   pick a display formatter and star skin.
4. Grant the **rate content** permission to the roles that should be able to vote.

See [Configuration](configuration/index.md) for the full walkthrough.
