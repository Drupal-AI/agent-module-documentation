# Configuration

This module has no settings form of its own. You configure it entirely from the
**Authorization** module's profile UI by adding a profile whose consumer is
**Groups**.

## Before you start

- **Authorization**, **Group**, and an Authorization **provider** (LDAP, OAuth,
  SAML, …) are all enabled and configured.
- You have created at least one **Group** and a **Group type** with the roles you
  want to assign. This module never creates groups for you — it only assigns
  users to groups that already exist.

## Create the profile

1. In the Authorization module UI, add a new **Authorization profile**.
2. Set the profile's **consumer** to **Groups** (`authorization_group`).
3. Decide the revoke behaviour with the option **"Remove the user from the
   Group, if they no longer have any roles"**:
   - **Checked** — when a full revoke happens, the user's membership is deleted
     entirely.
   - **Unchecked** — the membership is kept but its group roles are emptied.
4. Add **mapping rows**. Each row has a **Group and Role** select built from
   every group on the site: you can choose the group on its own (plain
   membership) or the group paired with one of its non-global roles.

## How grant and revoke behave

- **Grant** — the user is added as a member of the mapped group. If the mapping
  includes a role, that role is appended to their membership (only if it is not
  already there), and a status message is shown. Anonymous users and empty /
  "none" mappings are skipped.
- **Revoke** — the module compares what the provider still grants against the
  user's current memberships. For groups no longer granted it either deletes the
  membership (if you enabled the removal option) or clears its roles. For groups
  still granted it keeps only the granted roles.
- **Global (site-wide) group roles are never removed** — they are left untouched
  during sync, so manually assigned global roles are preserved.

## Notes

- The consumer does **not** auto-create Drupal groups; create them yourself
  first.
- There is no user-facing endpoint — all effects are driven by the provider's
  proposals as Authorization applies the profile (for example, on login).
- You can add several mapping rows in one profile, and combine the Groups
  consumer with other Authorization consumers on the same site.
