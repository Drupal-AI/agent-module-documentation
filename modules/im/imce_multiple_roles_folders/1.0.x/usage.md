<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imce Multiple Roles Folders merges folder permissions for users with multiple roles in IMCE.

---

Imce Multiple Roles Folders adjusts how IMCE (the file manager) resolves folder access for users with
multiple roles — **merging** the folder permissions granted by each of the user's roles, so a multi-role
user gets the combined (union) set of folders their roles allow, rather than only one role's folders. It
depends on the IMCE module, in the Media package.

Use it where IMCE users have multiple roles and should get the union of their roles' folder access. It is an
access-related feature for the IMCE file browser: it makes folder access **additive** across roles (a user
sees any folder any of their roles can access). Keep this in mind when designing IMCE profiles — since access
is merged, ensure no single role grants a folder you wouldn't want a multi-role user to reach (the union can
be broader than each role alone). It relies on IMCE's own access model. Configure the IMCE role/folder
profiles.

---

- Merge IMCE folder permissions across roles.
- Give multi-role users the union of folders.
- Combine roles' folder access.
- Depend on the IMCE module.
- Make folder access additive.
- Resolve access for multi-role users.
- Design IMCE profiles with the union in mind.
- Ensure no role grants an unwanted folder.
- Rely on IMCE's access model.
- Configure IMCE role/folder profiles.
- Combine folder permissions.
- Handle multi-role IMCE users.
- Union folder access.
- Configure IMCE folders.
- Merge role folders.
- Handle IMCE access.
- Combine folders.
- Resolve folder access.
- Configure the profiles.
- Merge IMCE folders.
