<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hide Non-Editable Content — behaviour

Applies only to the Views view whose id is `content` (the standard admin content overview).

## Query alter — `ViewsQueryAlter::alter()`
For each node bundle, evaluated against the current user:
- Has `bypass node access` OR `administer nodes` OR `edit any <bundle>` OR `delete any <bundle>` → bundle left unrestricted (`continue`).
- Else has `edit own <bundle>` OR `delete own <bundle>` → adds a where-group condition `node_field_data.uid = <current user id>`.
- Else (no edit/delete rights) → adds `node_field_data.type != <bundle>`, removing that bundle from the results.

## Exposed form alter — `FormViewsExposedFormAlter::alter()`
For each bundle, if the user lacks all of bypass/administer/edit-own/delete-own/edit-any/delete-any, that bundle is `unset()` from `$form['type']['#options']`, so it cannot be chosen in the exposed Type filter.

## Properties
- Enforcement is in the SQL query and the form build (server-side).
- The logic only ever narrows results/options; it never widens access.
- No configuration; behaviour is automatic once enabled. Other views, REST and direct node access are unaffected — pair with real node-access controls where needed.
