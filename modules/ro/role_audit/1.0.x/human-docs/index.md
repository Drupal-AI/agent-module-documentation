# Role Audit — manual setup guide

**Role Audit** (`role_audit`) adds an administrative **report** that compares two (or
more) user roles side by side, so you can see exactly what each role can do and where
their access diverges. Managing complex access control in Drupal can be opaque; this
report makes the permission model easy to read, in the spirit of a Venn diagram —
what is unique to Role A, what is unique to Role B, and what they share.

It is a **read-only** governance and security aid: it displays comparisons but never
changes any permission. Use it during security reviews and role design to verify
least privilege, spot unexpected grants, catch cases where a "lower" role
accidentally has more power than a "higher" one, and debug why a particular user can
or cannot do something.

The report offers two tools. The **Permissions Audit** compares the permission sets
of the roles you pick and highlights the differences and commonalities. The **Route
Audit** compares how roles access system routes based on their *static* routing
definitions (the `_permission` and `_role` requirements). Note that the Route Audit
examines static definitions only — it does not evaluate dynamic access checks or
custom access-check services, so for a fully accurate picture always test specific
routes with specific users as well.

The module relies solely on Drupal core (the User and Routing systems) and has no
external dependencies. It targets Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration form** for this module — it works as soon as it is
enabled. You use it entirely from the report page described below.

## Where it lives in the admin menu

Once enabled, go to **People → Role Audit** (`/admin/people/role-audit`). You will
find the two tools there:

- **Permissions Audit** — select your roles to generate a filtered table
  highlighting the differences and commonalities in their permission sets.
- **Route Audit** — compare how different roles access system routes based on static
  route definitions.

## Restrict who can see it

Because the report reveals your site's permission model in detail, treat access to
the Role Audit page itself as sensitive and grant it only to the administrators and
reviewers who need it.
