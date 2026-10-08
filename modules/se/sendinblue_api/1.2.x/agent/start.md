<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sendinblue API (Brevo) — agent index

Integrates **Sendinblue / Brevo** marketing (API v3) — sync contacts to lists, newsletter signup
forms/block, transactional & marketing email. Configure API key at `sendinblue_api.config` (store as
a secret). Version **1.2.3**. Core `^10.1||^11`.

**Note:** info.yml has a `depencencies` typo, so declared deps on `block`/`rest` may not be enforced —
enable them if needed. Provides admin permissions. Contact data (emails/names) goes to Sendinblue —
consent/GDPR applies.
