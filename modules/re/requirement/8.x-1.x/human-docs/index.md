# Requirement — manual setup guide

**Requirement** (`requirement`) is a developer-oriented framework that lets modules
declare the configuration they need — or merely suggest — and, crucially, offer a
one-click fix an administrator can apply straight from a report. Core's
`hook_requirements()` can tell you something is wrong ("the private file path is
not set"), but it gives you no way to act on it from where you are reading. This
module closes that gap.

Requirements you or other modules define show up as a summary on Drupal's **Status
Report** page and in full detail on a dedicated **Requirements report** page, where
each item can carry a "Fix it" button that opens a small form and applies the
change. Requirements can declare a severity (error, warning, or recommendation),
depend on one another, be grouped into fieldsets, and be marked "not applicable"
so they only appear in the right circumstances.

This is primarily a tool for module developers: the real value comes from writing
requirement plugins in your own code. A site team can also use it to encode its own
standards ("the private file path must be outside the webroot") as checks that
actually run, instead of a checklist nobody reads. Two cautions worth keeping in
mind: a one-click fix *is* a configuration change, so it should require the same
permission as making the change by hand, and it should always say exactly what it
will do before it does it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no settings form to configure. Its behaviour comes from the requirement
plugins that modules provide; see "How to use it" below.

## Where it lives in the admin menu

Once enabled, visit the **Requirements report** at
**Reports → Requirements report** (`/admin/reports/requirements`) to see every
declared requirement, its status, and any available fix. A summary also appears on
the **Status report** at **Reports → Status report** (`/admin/reports/status`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open **Reports → Requirements report** (`/admin/reports/requirements`). Here you
   can see which requirements are satisfied and which still need setting up, and
   apply any offered fix.
3. To add your *own* requirements, write requirement plugin classes in a module —
   place them under `src/Plugin/Requirement/Requirement/` and annotate them with
   `@Requirement(...)`, giving each an `id`, `label`, `description`, severity, and
   optional `group`, `weight`, and `dependencies`. A requirement can build a small
   form and, on submit, perform the change that satisfies it. The module's
   [project page](https://www.drupal.org/project/requirement) and the sibling
   [`agent/`](../agent/start.md) docs include example code.
