<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Masquerade Float Block provides a convenient draggable, floating block that embeds the
[Masquerade](https://www.drupal.org/project/masquerade) module's "switch user" form, so an authorised user
can masquerade as another user from any page without navigating to the user's profile. It loads jQuery UI
dialog and a cookie plugin to remember the block's position. Depends on `masquerade`.

---

`hook_page_attachments_alter()` (in `masquerade_float_block.module`) renders the block only when the
site config `masquerade_float_block.settings:visible` is on **and** the current user either holds any
`masquerade as ...` permission (matched with `preg_grep('/^masquerade as/i', ...)` over the user's
permissions) or is user 1. The embedded form is Masquerade's own `Drupal\masquerade\Form\MasqueradeForm`,
rendered and injected via `drupalSettings` and the `masquerade_float_block/masquerade-float-block` library.
Visibility can be toggled by an authorised user via a `?mfb_show=1|0` query parameter, but only if they
hold the module's `manage masquerade float block visibility` permission (`restrict access: true`); the
settings form (`/admin/config/development/masquerade-float-block`,
`MasqueradeFloatBlockForm`) is gated by the same permission.

**Security note (verified):** the actual user-switching is performed by Masquerade's own `MasqueradeForm`,
which enforces the `masquerade as <role/user>` permission model — this module does **not** add a new
switch-user path and does **not** let a user become an admin/any user beyond what Masquerade already
authorises. It only *displays* Masquerade's form to users who already have a masquerade permission, and
gates the block's visibility toggle (the `?mfb_show=` parameter, which writes the `visible` config) behind the
restricted `manage masquerade float block visibility` permission.

---

- Give support staff a floating "become this user" form on every page.
- Masquerade as another user without visiting their profile page.
- Reproduce a user's view of the site for debugging or QA.
- Restrict the block to users who already hold a `masquerade as` permission.
- Always show the block to user 1 (the superuser).
- Drag the floating block and remember its position via a cookie.
- Toggle block visibility with `?mfb_show=1` / `?mfb_show=0` (permission-gated).
- Manage the enable/disable setting from the admin form.
- Let editors quickly switch to a lower-privileged role to test access.
- Support content preview as a specific member during troubleshooting.
- Keep the standard Masquerade block position untouched (this adds a separate float block).
- Provide a faster masquerade workflow for helpdesk teams.
- Confine the visibility control to holders of a restricted permission.
- Test permission-based UI differences by switching users on the fly.
- Rely on Masquerade's own permission checks for who can be impersonated.
- Optionally lock the visible setting via settings.php override.
