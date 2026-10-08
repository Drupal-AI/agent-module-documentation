<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Permissions are **dynamic**, generated per reaction field via a permission callback
(`votingapi_reaction.permissions.yml` → `FieldPermissions::permissions`). For **every**
entity-type:bundle:field that has a `votingapi_reaction` field, four permissions are created:

| Permission pattern | Gates |
|---|---|
| `view reactions on <entity_type>:<bundle>:<field>` | Seeing the reaction widget/results at all. |
| `create reaction on <entity_type>:<bundle>:<field>` | Casting a first reaction. |
| `modify reaction on <entity_type>:<bundle>:<field>` | Changing/removing an existing reaction. |
| `control reaction status on <entity_type>:<bundle>:<field>` | Controlling per-entity reaction status (open/closed/hidden). |

Example machine names for a field `field_reaction` on `node:article`:
`view reactions on node:article:field_reaction`, `create reaction on node:article:field_reaction`, etc.

## How they're enforced

`src/Form/VotingApiReactionForm::checkAccess()`:
- Returns "no access" (form hidden) unless the user has **`view reactions on <instance>`**.
- Then requires **`modify reaction on <instance>`** when acting on an existing vote, or
  **`create reaction on <instance>`** when casting a new one; lacking it disables the radios/submit.
- `checkStatus()` additionally hides the form when the entity's field `status` is `HIDDEN` and disables
  it when `CLOSED`.

None of these are marked `restrict access: true`; they are ordinary, grantable per-field permissions
(intended for anonymous/authenticated/editor roles). Grant `view` + `create` (+ optionally `modify`) to
the roles that should be able to react. Access to *define reactions* (vote types/icons) is governed by
Voting API's own vote-type administration permission, not by this module.
