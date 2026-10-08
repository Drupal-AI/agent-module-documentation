# Entity Reference Auto — manual setup guide

**Entity Reference Auto** (`er_auto`) takes the busywork out of content editing by
**auto-filling one entity-reference field from another** when an editor makes a
related change. Instead of asking an editor to keep two related fields in sync by
hand, you define the relationship once and the module pre-populates the dependent
field for them. The auto-fill happens **in the browser**, so the editor can review
the suggested values before saving.

It's most useful on sites where the same taxonomy terms, references or values get
duplicated across entities. A couple of real examples:

- A site uses one taxonomy for access control and another for filtering in search
  and views. If a category usually implies a particular set of access terms, ER
  Auto can attach those access terms automatically — so the editor only worries
  about the topic of their content, not who can see it.
- A knowledge base associates an "end user" topic with "how-to" documentation while
  reserving "API" or "admin account" topics for more technical content — the
  association can be automated rather than remembered.

It lives in the *Field types* package, supports Drupal 10 and 11, and has no
access-control role of its own: the referenced entities still follow normal entity
access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. You configure the automation
**per field**, on the entity-reference field's own settings form, so the setup steps
below happen entirely in Field UI.

## How to use it

The steps below set up a basic automation. Use case: new issues should be
automatically assigned to the project's owner.

Assume these fields already exist:

- The **Project** content type has an entity-reference field `owner` targeting
  users.
- The **Issue** content type has an entity-reference field `assigned_to` targeting
  users, and an entity-reference field `project` targeting nodes.

Then:

1. Edit the **`project`** field's settings on the Issue content type.
2. Tick **"Enable Automation based on this field?"**.
3. In the first multi-select, choose the source field — **`owner`** (on the
   referenced Project).
4. In the second multi-select, choose the destination field — **`assigned_to`** (on
   the Issue).
5. Save.

Now, when an editor sets the project on an issue, the assignee field is
pre-populated with that project's owner — ready to review before saving.
