<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# masquerade_float_block — agent start

Renders the **Masquerade** switch-user form inside a draggable floating block, shown on every page for
authorised users. Depends on `masquerade`. Settings form
`/admin/config/development/masquerade-float-block` (perm `manage masquerade float block visibility`,
restrict access: true).

Logic (`hook_page_attachments_alter`): block renders only if config `...settings:visible` is on AND the
current user has any `masquerade as *` permission (via `preg_grep('/^masquerade as/i', perms)`) or is
uid 1. The embedded form is Masquerade's own `Drupal\masquerade\Form\MasqueradeForm`. A
`?mfb_show=1|0` query param toggles visibility, gated by the same restricted permission.

## Security — reviewed, no privilege escalation
The user-switch is executed by **Masquerade's own `MasqueradeForm`**, which enforces the
`masquerade as <role/user>` permission model. This module adds **no** new switch-user path and cannot make
a user become an admin/any user beyond Masquerade's authorisation — it only *displays* the form to users
who already hold a masquerade permission. `?mfb_show=` writes the `visible` config and needs the restricted
permission.
