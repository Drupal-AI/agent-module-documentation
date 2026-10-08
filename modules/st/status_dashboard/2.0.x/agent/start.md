<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Status dashboard — agent index

Dashboard showing **Drupal core + module update status** (available/security updates at a glance). Depends
on core `views`. Config at `status_dashboard.settings_form`; provides permissions. Version **2.0.0-alpha9**.
Core `^8||^9||^10||^11`.

Positive ops aid (stay patched). **But the update/version info is sensitive** (reveals installed versions +
pending vuln updates) — **restrict to trusted admins; never expose publicly** (would hand attackers a list
of outdated components).
