<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User View Mode lets you assign an existing user view mode to each role, and swaps a user profile's display into that view mode when the account is rendered — so profiles show differently depending on the roles the account holds.

---

The module is two hooks and nothing else — no routes, no permissions, no services, no config entity of its own. `hook_form_user_role_form_alter()` adds two fields to the standard role add/edit form at `admin/people/roles/manage/{role}`: a **View Mode** select whose options are the existing user entity view modes (Default, plus any you defined at `admin/structure/display-modes/view`), and a **Weight** number field. Both are stored as third-party settings (`user_view_mode.view_mode`, `user_view_mode.weight`) on the `user.role.*` config entity — the module ships **no config schema** for them. `hook_entity_view_mode_alter()` then does the work: when a `user` entity is about to render in the `full` or `default` view mode, the module looks at the account's non-locked roles (`getRoles(TRUE)`, which excludes anonymous/authenticated) and rewrites the view mode to the one configured for that role. With **one** role it uses that role's setting; with **several** it picks the role whose weight is highest and uses its setting. Two accuracy caveats matter. First, the tie-break reads the **role entity's own weight** (`Role::getWeight()`, i.e. the drag order on the roles listing) — **not** the "Weight" field this module adds to the form, which is written but never read by the selection logic. Second, and more important: **a view mode is a display decision, not access control.** Changing which fields a display includes does not grant or revoke access — Drupal still enforces user view access and per-field access on render, and any field remains readable through JSON:API, Views, a search index or another view mode regardless of which view mode a role selects. Use this to shape presentation; use field/entity access for anything confidential. Requires nothing beyond core `^10 || ^11`; version **8.x-1.4**.

---

- Render staff profiles in a different view mode than member profiles.
- Give an "Editor" role a profile display that includes a biography field.
- Show a compact profile view mode for a "Customer" role.
- Keep per-role profile presentation in exportable configuration instead of theme preprocess.
- Replace a `hook_preprocess_user()` chain of role checks with display config.
- Point the "Author" role at an author-oriented user view mode.
- Show department and extension fields only on employee profiles.
- Differentiate a volunteer profile from a member profile at render time.
- Assign a "Speaker" role its own conference-profile view mode.
- Present membership-tier profiles with tier-specific display settings.
- Control which role's view mode wins on multi-role accounts via the roles' drag-order weight.
- Fall back to the `full` view mode for roles with no configured view mode.
- Leave anonymous/authenticated-only accounts on their normal display (locked roles are ignored).
- Attach a custom view mode created at admin/structure/display-modes to a specific role.
- Let a site builder change per-role profile display in the Field UI, not code.
- Show contact details on internal-role profiles but hide them from a public role's display.
- Build a staff-directory look for one role without touching other roles.
- Swap in a print-oriented or minimal user view mode per role.
- Avoid one bloated user display crammed with every role's fields.
- Configure everything from the standard role edit form — no separate settings page.
