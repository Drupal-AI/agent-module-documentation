<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maintenance provides advanced maintenance mode options.

---

Maintenance provides advanced maintenance-mode options — extending Drupal core's maintenance mode with
more control (e.g. scheduling, per-path or richer maintenance pages, more granular access during maintenance).
It requires PHP 7.4, in the Maintenance package.

Use it for richer maintenance-mode control. It is an administration feature governing maintenance mode.
Security-relevant note: maintenance mode controls **who can access the site while it's in maintenance** —
ensure the maintenance-bypass (who can still use the site during maintenance) is limited to the right roles
(core's "access site in maintenance mode" permission), and don't inadvertently leave a bypass open. It relies
on Drupal's maintenance-access model. It has no other access-control role. Configure the maintenance
options.

---

- Provide advanced maintenance-mode options.
- Extend core's maintenance mode.
- Schedule or customize maintenance.
- Require PHP 7.4.
- Add richer maintenance pages.
- Control access during maintenance.
- Limit maintenance-bypass to the right roles.
- Not leave a bypass open.
- Rely on core's maintenance-access model.
- Have no other access-control role.
- Configure maintenance options.
- Handle maintenance mode.
- Customize maintenance.
- Configure the mode.
- Schedule maintenance.
- Control maintenance access.
- Handle the maintenance page.
- Configure maintenance mode.
- Restrict maintenance bypass.
- Manage maintenance.
