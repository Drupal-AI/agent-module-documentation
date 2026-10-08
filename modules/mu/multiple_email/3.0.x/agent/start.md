<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiple Email Addresses (multiple_email) — agent index

**Users register multiple confirmed email addresses per account and pick a primary one.**

- **Version:** 3.0.x
- **Core:** ^11.3
- **Config route:** `multiple_email.admin.settings` → `/admin/config/people/multiple-email` (perm `administer multiple emails`).
- **Manage tab:** `/user/{user}/edit/email-addresses` (custom access `_access_multiple_email_personal_tab`).
- **Op routes:** confirm / set-primary / resend / cancel / remove — each `_entity_access`-gated on the `multiple_email` entity.
- **Permissions:** `administer multiple emails` (restricted), `use multiple emails`.
- **Service:** `multiple_email.confirmer` (`EmailConfirmer`).

**Security:** All operation routes are `_entity_access`-gated; the personal tab uses a dedicated access check; confirmation codes use PHP's secure `Randomizer`. No anonymous mutation. No security findings. See [configure/settings.md](configure/settings.md).
