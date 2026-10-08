# Scanner-Fixer API — manual setup guide

**Scanner-Fixer API** (`scanner_fixer_api`) is a developer framework for defining
two‑step "find, then fix" operations. You write three kinds of plugin: a
**Scanner** locates items that need attention and returns their IDs (node IDs,
term IDs, UUIDs, and so on); a **Fixer** decides whether it can act on a given item
and then performs the fix; and a **Solution** bundles one or more scanners and
fixers together so the combined list of scanned IDs is passed to the fixers to act
on. Scanners and fixers are never run on their own — a Solution is what you run.

It solves the recurring problem of bulk remediation: cleaning up broken
references, normalising field values across a content type, re‑tagging or migrating
taxonomy terms, or any data‑cleanup pass during a migration. Rather than writing a
one‑off script each time, you express the work as reusable plugins and let the
framework run them — from the admin UI or from Drush — with progress and statistics
reported back.

This is a **code‑only** module: it has no configuration of its own, and all its
functionality comes from plugins you (or other contrib modules) write. Enabling it
alone does nothing useful until at least one Solution exists. It requires no
modules outside Drupal core, provides its own permissions, and ships an example
submodule, **`scanner_fixer_api_example`**, that documents how to build plugins.
The **7.x‑1.x** series is unsupported; this **2.0.x** series deliberately mirrors
that older API to make porting easier, while breaking changes are reserved for a
future 3.0.x.

A note on safety: because Fixers can change content in bulk, the framework gates
each Solution behind its own permission. Every defined Solution automatically gets
a `use solution {id}` permission, and the run wizard checks it before any fix runs
— so keep destructive Solutions behind their own permission and grant it only to
the right roles.

This guide is written for a **human**. If you want a terse, token‑cheap reference
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally enable the example submodule.

## Where it lives in the admin menu

Once one or more Solutions are defined, the list of Solutions is at
**`/admin/content/scanner_fixer_api`**, controlled by the **Use the Scanner-fixer
solution-overview page** (`use scanner-fixer solution overview page`) permission.
Each Solution links to a multi‑step run wizard at
`/admin/content/scanner_fixer_api/{solutionId}`.

## How to use it

1. **Write your plugins** — a Scanner, one or more Fixers, and a Solution that
   groups them. Study the `scanner_fixer_api_example` submodule for a worked
   example, and extend the provided `ScannerBase`, `FixerBase` and `SolutionBase`
   classes.
2. **Grant permissions** — give the roles that should run a Solution its
   auto‑generated `use solution {id}` permission, and give anyone who should see
   the list the overview permission.
3. **Run it** — either through the web UI (the solutions overview links to a
   wizard for each Solution) or from the command line via the module's Drush
   command (`drush scanner-fixer:list-solutions` to list, and
   `drush scanner-fixer:run-solution <solution_id>` to run one). Results and
   statistics are reported as it goes.
