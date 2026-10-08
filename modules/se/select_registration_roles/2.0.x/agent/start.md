<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select Registration Roles (select_registration_roles) — agent index

Adds a **role chooser to `/user/register`**, limited to roles an administrator has approved for
self-selection, with an optional **per-role approval** step (flagged roles leave the account
**blocked**; unflagged ones activate immediately). Depends on core `user`. Version **2.0.0**.
Core requirement `^10 || ^11`.

**Can a visitor submit a role that was never offered? No — verified live.** Posting
`select_roles[srr_super]=srr_super` to `/user/register` when only `srr_member` was offered was
rejected: *"The submitted value srr_super in the Choose a role element is not allowed."*
No account was created and no role was assigned.

**But note where the defence lives.** `select_registration_roles_form_submit()` calls
`$user->addRole($role_id)` on whatever it is handed, **without re-checking the allow-list** — the
rejection comes from **core's Form API `#options` validation**, not from the module. Correct
today; resting on Form API behaviour rather than its own.

**The real security control is the administrator's choice of which roles to offer.** Never expose
a role carrying `administer permissions`, `administer users`, `administer nodes` or anything that
can grant further permissions — the module will assign it to anyone who registers.

**Known bug:** line 71 does `if ($approval_roles[$role_id] === $role)` with no null coalesce, so a
configured role absent from `select_registration_roles_admin_approval` emits an
*Undefined array key* warning **from the public registration form**. Logged on a normal site;
printed on the page where error display is on.
