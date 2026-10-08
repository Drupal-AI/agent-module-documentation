<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Improves the operator experience of the Reroute Email module with finer-grained permissions, data-governance roles, a status block and a test-mail form.

---

Reroute Email intercepts outgoing mail on non-production sites and sends it to a fixed address so real users are never contacted. This companion module wraps that with a dedicated settings form at `/admin/config/development/reroute_email_be`, splits control into discrete permissions (`send rerouted email`, `edit destination address`, `edit allowed address`, `edit allowed roles`, `configure reroute email module`, `configure reroute email be module`) and installs three governance roles (Data Owner, Data Steward, Data Custodian). It alters the core Reroute Email settings form (`reroute_email_be_form_reroute_email_settings_alter`) to disable individual fields based on the current user's permissions, and provides a `ReroutingStatus` block plus themed status templates that surface whether rerouting is enabled.

Setup: enable alongside `reroute_email`, assign the governance permissions/roles, then configure the reroute address and skip-lists. A Drush command service is shipped for scripted control. All routes are admin/permission-gated; there are no anonymous or mutating public endpoints.

---
- Enable a friendlier settings screen for Reroute Email at `/admin/config/development/reroute_email_be`.
- Restrict who may toggle rerouting via the `send rerouted email` permission.
- Grant `edit destination address` to let a role change the reroute target address.
- Grant `edit allowed address` for the addresses excluded from rerouting.
- Grant `edit allowed roles` for the roles whose mail is not rerouted.
- Assign the Data Owner role for overall data control.
- Assign the Data Steward role for data quality oversight.
- Assign the Data Custodian role for technical storage/access.
- Disable specific fields on the Reroute Email form for less-privileged editors.
- Place the Rerouting Status block to show current reroute state in a region.
- Show a themed "enabled" banner when rerouting is active.
- Show a themed "disabled" banner when rerouting is off.
- Show a themed "missing" banner when Reroute Email is not configured.
- Test outgoing/rerouted mail from the Reroute Email test form.
- Drive reroute configuration from Drush in CI pipelines.
- Separate email-governance duties across trusted roles.
- Audit which roles may edit allowed addresses and roles.
- Keep production mail safe on staging by enforcing reroute permissions.
- Delegate reroute address edits without granting full site config.
