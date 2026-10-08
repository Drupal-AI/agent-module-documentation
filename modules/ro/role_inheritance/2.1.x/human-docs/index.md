# Role Inheritance — manual setup guide

**Role Inheritance** (`role_inheritance`) lets you arrange your site's roles into a
hierarchy so that one role automatically **inherits the permissions** of one or more
other roles. Instead of granting the same permissions over and over on each role,
you grant a permission once on a "base" role and let the roles above it pick it up.

The classic example is an editorial newsroom. Suppose you have **Writers**,
**Editors**, and **Global Editors**. Writers get the create/edit permissions for
their sections; you then configure Editors to inherit from Writers, and Global
Editors to inherit from Editors. Now the create-content permission only needs to be
assigned to Writers, and the other two roles gain it automatically through
inheritance. When combined with modules such as Workbench Access or Taxonomy Access
Control, roles can inherit section- and content-level access the same way.

It is important to understand the model precisely, because this module changes how
effective permissions are computed. Inheritance is **additive**: an inheriting role
is granted the **union** of its own permissions and every permission held by the
roles it inherits from. It only ever **grants** permissions — it never removes them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define which roles inherit from which,
   and how to review the result safely.

## Where it lives in the admin menu

The inheritance configuration form is provided by the
`role_inheritance.config_role_inheritance` route. Once the module is enabled you
will reach it from the site's configuration/people administration to set up the
inheritance relationships.

## A word on privilege escalation

Because a role inherits **everything** its ancestors hold, an inheritance graph can
grant far more than you intended if an ancestor role happens to hold a sensitive
permission — that permission propagates up to every role that inherits from it.
Design the graph carefully and, after changing it, review the **effective**
permissions of each role to confirm no role has quietly gained access it should not
have. See [Configuration](configuration/index.md) for the safe way to do this.
