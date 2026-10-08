<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IMCE DFP adds dynamic path functionality on IMCE profiles.

---

IMCE Dynamic File Path (imce_dfp) adds **dynamic path functionality to IMCE profiles** — so the IMCE file
manager's upload directory can be computed dynamically (e.g. per-user or by token) rather than a single fixed
folder. It depends on the IMCE module, in the Media package.

Use it to route IMCE uploads into dynamic folders. It is a media/file-management feature. Security note: IMCE
controls **file browsing/upload within configured directories** — with dynamic paths, ensure the computed path
stays **within the intended, permission-scoped area** (a path that resolves outside a user's allowed folder
would widen file access), so validate the dynamic-path configuration. IMCE's own per-profile permissions gate
who can browse/upload. It has no other access-control role. Configure the dynamic path on the IMCE profile.

---

- Add dynamic IMCE upload paths.
- Compute the upload dir per user/token.
- Avoid a single fixed folder.
- Depend on the IMCE module.
- Route uploads dynamically.
- Serve file management.
- Keep the computed path within the allowed area.
- Validate the dynamic-path config.
- Rely on IMCE profile permissions.
- Have no other access-control role.
- Configure the dynamic path.
- Handle IMCE paths.
- Route uploads.
- Configure IMCE.
- Set dynamic paths.
- Handle the profile.
- Compute paths.
- Scope uploads.
- Set the path.
- Provide dynamic IMCE paths.
