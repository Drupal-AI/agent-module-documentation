# Entity Version — manual setup guide

**Entity Version** (`entity_version`) attaches a human-meaningful **version
number** — composed of **major, minor, and patch** parts, like `1.2.3` — to
content entity revisions. Drupal's built-in revision history tells you *that*
something changed and when; a version number tells editors *how significant* the
change was, which is exactly what editorial and compliance workflows often need
to communicate at a glance.

You add versioning to a content entity by adding a field of type **Entity
version** to it. Version numbers can be changed manually, or driven automatically
by other modules and by the module's own workflow integration.

Two optional submodules extend it:

- **Entity Version History** (`entity_version_history`) surfaces the history of
  version numbers for a content item.
- **Entity Version Workflows** (`entity_version_workflows`) hooks version numbers
  into core's **Content Moderation / Workflows**, so each workflow state
  transition can increase, decrease, or leave alone any of the major/minor/patch
  numbers.

The version is metadata — it has no unusual security surface. The main thing to
get right is your *policy*: decide which transitions should bump which part of the
number, and confirm those increment rules match how your organization thinks
about versions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the submodules you need.

There is **no single settings page** for this module. You configure it by adding
an **Entity version** field to a content entity, and — if you enable the
Workflows submodule — by setting per-transition increment rules on your workflow.

## How to use it

1. Enable Entity Version (and, if you want workflow-driven versioning, the
   **Entity Version Workflows** submodule — see [Installation](installation/index.md)).
2. Add a field of type **Entity version** to the content entity you want
   versioned, via its **Manage fields** screen (for example **Structure →
   Content types → *(type)* → Manage fields**).
3. If you enabled the Workflows submodule, edit your workflow (**Configuration →
   Workflow → Workflows**) and configure, for each transition, whether it should
   increase, decrease, or leave unchanged the major, minor, and patch numbers.
4. For a visible history of version changes, enable the **Entity Version History**
   submodule.

Once set up, the version number travels with each revision and updates according
to your manual edits or workflow rules.
