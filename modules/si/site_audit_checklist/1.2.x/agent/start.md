<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Audit Checklist — agent orientation

Admin pre-launch checklist dashboard with per-task update + CSV export.

- Version 1.2.x, core ^8.8||^9||^10.
- Routes under `/admin/config/development/site-audit`: dashboard (`view site audit checklist`), update task + CSV export (`administer site audit checklist`).
- Two-tier permissions, all routes admin-area, no anonymous endpoints, no external calls. Access looks sound.
