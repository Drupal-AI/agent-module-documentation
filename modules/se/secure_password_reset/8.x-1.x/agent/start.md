<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Secure Password Reset — agent index

**Hardens the password-reset form so it does not disclose whether a username/email exists** (prevents user
enumeration). Version **8.x-1.0-rc2**. Core `^8||^9||^10||^11`.

**Security-positive** — returns a neutral response regardless of account existence (closes the reset-form
enumeration vector). No access role.
