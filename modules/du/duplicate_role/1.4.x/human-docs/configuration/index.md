# Configuration

Duplicate Role has no settings to tune — its "configuration" is the act of
duplicating a role. This page walks through the duplicate form, field by field.

## Start a duplication

You have two entry points on **People → Roles** (`/admin/people/roles`), both of
which require the **"administer duplicate role"** permission:

- The **Duplicate** operation on any individual role's operations dropdown — this
  pre-selects that role as the one to copy.
- The **Duplicate role** action link at the top of the roles page — this opens the
  form with no role pre-selected, so you choose one on the form.

Either way you land on the duplicate form at
`/admin/people/roles/duplicate/{role}`.

## The form, field by field

- **Base role** — the existing role whose permissions you want to copy. If you
  arrived via a specific role's **Duplicate** operation, this is already chosen for
  you and hidden; if you came from the action link, pick it here.
- **Label** *(required)* — the human-readable name of the new role (up to 40
  characters), e.g. "Senior editor".
- **Machine name** *(required)* — the new role's internal ID. It must be
  **unique**; the form rejects a name already used by another role.

## What happens on submit

When you save, the module:

1. Creates a new role with the label and machine name you entered.
2. Copies **all of the base role's permissions** into the new role.
3. Returns you to the roles list, where the new role now appears.

The new role's permissions are exactly the base role's — nothing more, nothing
less. From there, edit the new role's permissions at **People → Permissions** (or
the role's own edit page) to make it what you need.

## Scope and limits

- **Permissions only.** Duplicate Role copies the permission set and nothing else
  — no fields, no view/form display settings, no other role configuration.
- **Trusted operation.** Because it creates roles and copies permission sets, the
  triggering permission is restrict-access; keep it limited to administrators you
  already trust with role management. The form can only copy an *existing* role's
  permissions — it can't be used to grant an arbitrary permission that no role
  already has.
