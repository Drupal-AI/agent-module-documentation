<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `email_validator.permissions.yml`:

- **`administer eva api settings`** — grants access to the config form route `email_validator.settings` (`/admin/config/system/email-validator`). This is the only permission the module defines; it is restriction-sensitive (controls the Access Key and which forms are validated). No permission gates validation itself — validation runs automatically once configured.
