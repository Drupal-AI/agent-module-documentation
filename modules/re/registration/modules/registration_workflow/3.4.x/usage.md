<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Workflow adds per-transition permissions and UI operations (buttons/links) for moving registrations between workflow states, and integrates registration state changes with ECA Workflow.

---

The submodule turns the base module's registration workflow states into actionable UI. It provides a
dynamic **permission per workflow transition** — `use <workflow> <transition> transition` (e.g.
`use registration cancel transition`) — built by `RegistrationWorkflowPermissionProvider`. It adds a
`registration_workflow.transition` route with a `StateTransitionForm`, exposes a **Cancel** entity
operation on registration listings and renders a button for every valid transition on a
registration's own page (via `getValidTransitions()` in the `registration_workflow.validation`
service). Access is gated by `StateTransitionAccessCheck` plus two config flags in
`registration_workflow.settings`: `require_update_access` (default true — the user must also have
update access to the registration) and `prevent_complete_own` (default false — when true, users may
not complete their own registrations, useful when completion implies check-in/approval by someone
else). Because transitions are surfaced as workflow events, they can also drive **ECA Workflow**
models. It adds no fields; configuration is the two settings plus role permissions.

---

- Give staff a one-click **Cancel** button on each registration in admin listings.
- Render Complete/Hold/Cancel buttons on a registration's page for valid transitions only.
- Grant the "Cancel" ability to a role via the `use registration cancel transition` permission.
- Control who can complete registrations with the `use registration complete transition` permission.
- Require that a user has update access before they can transition a registration.
- Prevent registrants from completing (approving) their own registrations.
- Model an approval flow: pending -> (staff completes) -> complete.
- Let front-desk staff hold or cancel registrations without full admin rights.
- Drive automated actions on state change via ECA Workflow integration.
- Add per-transition permissions for a custom registration workflow's transitions.
- Expose only the transitions each role is permitted to perform.
- Enforce that self check-in cannot be done by the registrant (prevent_complete_own).
- Provide a dedicated transition form route for scripted/linked state changes.
- Separate "can edit a registration" from "can move it through the workflow".
- Allow event organisers to cancel no-shows in bulk-friendly listings.
- Integrate registration state changes into broader ECA business rules.
- Keep the base workflow states but make them operable by non-developers.
- Give a "Registrations manager" role transition rights on a specific workflow only.
- Surface hold/complete actions contextually based on the current state.
- Tighten security by requiring both update access and transition permission.
