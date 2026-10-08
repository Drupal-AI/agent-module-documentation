# Flexible permissions — manual setup guide

**Flexible permissions** (`flexible_permissions`) is a **developer API** that
gathers, calculates, and caches permissions from any number of sources. It lets
an access‑defining module move beyond Drupal's single flat permission set and
turn its access layer into **Policy Based Access Control (PBAC)**.

This is a foundation library with **no user interface and nothing to
configure**. You don't set it up through the admin UI — you install it because
another module requires it. The best‑known consumer is the
[Group](https://www.drupal.org/project/group) module, which has relied on
Flexible permissions since Group 2.0.0; other access‑oriented modules (Domain,
Commerce Stores, and similar) could use it too.

Here's the idea for developers: instead of one global list of permissions,
implementing modules register **permission calculators**, each of which
contributes permissions for a user account within a named **scope** (for example
Group's `group_outsider`, `group_insider`, and `group_individual`). A chain
calculator service collects every calculator, runs a build pass and an alter
pass, and merges the results into an immutable value object. Because everything
is cached with core's VariationCache — varying by the cache contexts each
calculator declares — permissions can even be **conditional** (for instance,
editors who may edit only during office hours) while staying fast. A checker
service answers the top‑level question "does this account have this permission in
this scope?". In the 2.0.x branch the module bridges to Drupal core's Access
Policy API, so its calculators are exposed to core and converted between the two
value‑object formats.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (usually pulled in automatically as a dependency).

There is **no configuration page** — this module has no settings, permissions, or
UI of its own. It only does something once a consumer module registers a
calculator.

## Where it lives in the admin menu

Nowhere. Flexible permissions adds no admin pages, no permissions, and no Drush
commands. It is pure developer infrastructure.

## How to use it

- **If you're a site builder:** you generally won't install this directly.
  A module such as Group will require it, and Composer will pull it in for you.
  There's nothing to configure afterward.
- **If you're a developer:** add a permission calculator by tagging a service
  `flexible_permission_calculator` (legacy) or providing a core Access Policy
  (`access_policy`, the 2.0.x approach), have its build pass return a
  `CalculatedPermissionsItem` (scope, identifier, permission strings, and an
  `isAdmin` flag), and check access with the checker service's
  `hasPermissionInScope()`. Declare your varying cache contexts up front in
  `getPersistentCacheContexts()` to keep caching correct and prevent privilege
  escalation. See the [`agent/plugins`](../agent/plugins/flexible_permissions.md)
  and [`agent/api`](../agent/api/flexible_permissions.md) docs for specifics.
