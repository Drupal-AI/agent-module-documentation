<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Workflow — agent index

Adds per-transition **permissions** and UI **operations/buttons** for moving registrations between
workflow states, plus ECA Workflow integration. No configure route.

- **Settings, transition route & the two access flags** → [configure/workflow.md](configure/workflow.md)
- **Permissions (one per transition)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- Config object `registration_workflow.settings`: `require_update_access` (default true),
  `prevent_complete_own` (default false).
- Dynamic permission per transition: `use <workflow> <transition> transition` (e.g.
  `use registration cancel transition`).
- Route `registration_workflow.transition` → `StateTransitionForm`, gated by
  `_state_transition_access_check`. Service `registration_workflow.validation` returns valid
  transitions for a registration.
