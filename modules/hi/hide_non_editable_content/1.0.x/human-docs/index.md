# Hide Non-Editable Content — manual setup guide

**Hide Non‑Editable Content** (`hide_non_editable_content`) tidies the admin
**Content** overview (`/admin/content`) so that each user sees only the nodes they
can actually edit or delete. On a site with several editorial roles, this cuts the
clutter of listing rows a given editor could never touch, and it trims the exposed
**Type** filter down to just the content types that user can manage.

It works entirely server‑side: the restriction is added to the View's SQL query, so
hidden rows never reach the browser (it is not a JavaScript hide). The logic only
ever **removes** rows and filter options — it never grants access — so it cannot
over‑expose content. Users with broad rights (`bypass node access`,
`administer nodes`, or "edit any"/"delete any" for a bundle) keep their full view;
users with only "edit own"/"delete own" see just their own nodes; users with neither
stop seeing that bundle at all.

Two things are worth being clear about:

- **It is a convenience/UX filter, not a node‑access system.** It only affects the
  View named `content`. It does **not** cover other Views, REST, or direct node
  URLs. Pair it with real node‑access controls where you need genuine protection.
- **This module is deprecated.** Its maintainer recommends the
  [Content View Bundle Permissions](https://www.drupal.org/project/content_view_bundle_permissions)
  module as a better way to achieve similar functionality. Prefer that on new sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — enabling it *is* the entire
setup.

## How to use it

There is nothing to configure. Once enabled, the module automatically applies to the
standard **Content** admin View (`/admin/content`). Visit that page as different
users and you will see each one's list narrowed to the content they can edit or
delete, with the Type filter limited to the matching bundles.
