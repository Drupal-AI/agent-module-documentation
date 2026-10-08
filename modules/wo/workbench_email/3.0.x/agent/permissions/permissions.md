<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission (`workbench_email.permissions.yml`):

- **`administer workbench_email templates`** — Add and edit workbench email templates. It is the
  `admin_permission` on the `workbench_email_template` config entity, so it gates the whole
  template collection/add/edit/delete UI at `/admin/config/workflow/workbench-email-template`.

There is no per-template or recipient-facing permission — receiving a notification depends only
on being a resolved recipient of a fired template, not on any permission (except the
`roles_with_access` recipient type, which additionally requires update access to the item).
