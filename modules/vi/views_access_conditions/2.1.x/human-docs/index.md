# Views Access Conditions — manual setup guide

**Views Access Conditions** (`views_access_conditions`) lets you control who can
see a View — and even hide individual fields, exposed filters, and contextual
arguments — using Drupal's familiar **Conditions API**. These are the same
condition blocks you already use for block visibility (current user role,
request path, node type, and so on), now available as a Views *access plugin*.

Instead of writing a custom access plugin or PHP, you edit a View, choose
**Conditions** as its access method, and pick the conditions that must pass. At
runtime the module evaluates all of them together (they are combined with AND
logic — every condition must pass) and only grants access when they all match.
Beyond gating the whole View, it adds a small "Views Access Conditions" section
to each field, filter, and argument, so you can, for example, reveal a *price*
or *email* column only to staff, show a *department* exposed filter only to
certain roles, or drop a contextual argument for some visitors.

A site-wide settings form lets an administrator decide **which** condition
plugins editors are allowed to use, keeping the choices tidy and consistent
across the site. One important behavior to remember: if you choose the
Conditions access plugin but configure **no** conditions, the View is
**accessible to everyone** by design — you must add at least one condition to
actually restrict access.

This module builds on the [Conditions Helper](https://www.drupal.org/project/conditions_helper)
module (installed automatically as a dependency) for its condition-building
form and evaluator.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

### Gate a whole View

1. Edit a View (**Structure → Views**) and open its **Access** settings.
2. Change the access method to **Conditions**.
3. Configure the condition plugins you want (role, request path, node type, …).
   Every condition you add must pass for a visitor to reach the View.

Remember: with the Conditions plugin selected but **zero** conditions set, the
display stays open to everyone. Add at least one condition to lock it down.

### Hide individual fields, filters, or arguments

Open the configuration form of any **field**, **exposed filter**, or
**contextual argument** on the View. A **Views Access Conditions** details
section appears where you can attach conditions to just that item:

- On a **field**, a failing condition removes the column for that visitor while
  the row still shows.
- On an **exposed filter**, a failing condition hides the filter input.
- On an **argument**, a failing condition drops the argument so the View is not
  constrained by it for that visitor.

These per-item conditions are stored inside the View's configuration, so they
travel with a config export/import.

## Where it lives in the admin menu

There is one small site-wide settings form at
**Configuration → System → Views Access Conditions**
(`/admin/config/system/views-access-conditions`). It is gated by the
**`administer views access conditions`** permission (a restricted, trusted-admin
permission). Use it to build an **allow-list** of the condition plugins editors
may choose from. Leave the list empty to make *all* available conditions
selectable; fill it in to limit editors to a blessed set. When the list is
non-empty it is also enforced at the access-check layer as defense in depth.
