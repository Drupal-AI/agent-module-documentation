<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Drush commands

`src/Drush/Commands/SiteCommands.php` provides commands to set the **state** and **reason** of the
site from scripts — useful when your own monitoring determines health.

Typical use: run your check, then set the Site State (OK/Warning/Error) + a reason string; the value
feeds the Site entity and its saved revisions. Combine with cron/report settings so snapshots are
saved or POSTed to a remote destination automatically.
