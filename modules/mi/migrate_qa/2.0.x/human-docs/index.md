# Migrate QA — manual setup guide

**Migrate QA** (`migrate_qa`) is a quality‑assurance toolkit for content
migrations. When you migrate a large site, the hard part often isn't running the
migration — it's *reviewing* the result: which pages have been checked, which
still need eyes, and which have problems (stray `<script>` tags, inline styles,
broken markup) hiding in the imported text. Migrate QA moves that whole review
process onto the destination Drupal site itself, so your team can track it there
instead of trying to keep spreadsheets in sync.

To do that it defines a set of custom entities. A **Tracker** records the
approval/QA status of each migrated item (and is revisionable, so you can diff
what changed). An **Issue** lets reviewers log and categorise problems. A
**Connector** links things together, and a **Flag** marks potentially
problematic content — for example items containing script tags or inline styles.
Generators can create Tracker and Connector migrations automatically from your
existing content or migration configs. There's even some clever automation: when
migrated content is inserted, an event subscriber and `hook_entity_insert()` can
auto‑run the matching per‑item tracker/connector migration so your QA data stays
current as content lands.

The payoff is visibility. Reviewers can see at a glance what still needs
checking, developers can spot trends and find multiple examples of the same
problem, and the whole QA conversation lives next to the content it's about.

Migrate QA has a fair few dependencies — **Diff**, core **Field**, **Migrate**,
core **Taxonomy**, **Dynamic Entity Reference**, **Migrate Plus**, and **Migrate
Tools** — and ships three optional submodules: **Migrate QA Demo Data** (example
data), **Migrate QA Views** (ready‑made QA listing views), and **Migrate QA Views
Media** (media‑specific views). Its administration is gated by dedicated
permissions such as `administer migrate_qa_tracker entity` (marked
*restricted*), and per‑node QA notes require both view access to the node and the
`edit migrate_qa_tracker entity` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and pick the submodules you need.

Migrate QA has no single "settings" form to walk through field by field; you work
with it through its entity administration and per‑node notes, described below. The
official
[Quick Start Guide](https://www.drupal.org/docs/contributed-modules/migrate-qa)
on drupal.org is the best companion once the module is installed.

## Where it lives in the admin menu

Migrate QA's administration lives under **Structure → Migrate QA**
(`/admin/structure/migrate-qa/*`), where the Tracker, Issue, Connector, and Flag
entities (and their generators) are managed. Each area is gated by the matching
`administer migrate_qa_* entity` permission.

Per‑node QA notes are reached from the node itself, at `/node/{node}/note`, which
requires view access to that node plus the `edit migrate_qa_tracker entity`
permission.

## How to use it

The typical workflow is:

1. **Enable the module and its dependencies**, and (recommended) the
   **Migrate QA Views** submodule so you get ready‑made reporting views.
2. **Generate Trackers** for your migrated content — either from existing content
   or from your migration configurations — using the built‑in generators.
3. **Run your migrations** (via Migrate Plus / Migrate Tools). As migrated
   content is inserted, Migrate QA can automatically run the corresponding
   per‑item tracker/connector migration so each item gets a QA record.
4. **Review content**: reviewers open the QA views to see what still needs
   checking, set approval status on each Tracker, log Issues, and follow up on
   Flags (such as script tags or inline styles detected in imported text).
5. **Track trends**: filter the reports by QA status, content flag, or issue tag
   to find clusters of related problems.

If you just want to see the tool in action first, enable **Migrate QA Demo Data**
(which needs `migrate_source_csv`) to load example QA content.
