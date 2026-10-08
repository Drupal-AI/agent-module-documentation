<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Global Purge — agent index

Provides **default/global purge settings for Webform submissions** (auto-delete old submissions site-wide).
Depends on `webform`. Provides permissions. Version **1.1.0**. Core `^9||^10||^11`.

**Data-hygiene/privacy-positive** — auto-purge helps meet **retention/data-minimization** (GDPR) by not keeping
submission **PII** too long. Cautions: **destructive** (set the window deliberately; export first), gate the
permission to trusted admins. No access role beyond permission.
