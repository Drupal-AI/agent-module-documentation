<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Submissions Revisions — agent index

Adds **revision tracking to Webform submissions** (change history, review/revert). Depends on `webform`, core
`user`. Provides permissions. Version **1.0.0-alpha1**. Core `^10||^11`.

Forms — follows Webform's submission access + its permission; submission revisions may be **PII** (apply
retention/access policy). No independent access role.
