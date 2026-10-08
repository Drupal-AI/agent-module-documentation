<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Ban adds one-click tools to a webform submission's admin listing that push the submitter's IP address into Drupal core's Ban list.

---

Install it with `composer require drupal/webform_ban` and enable it together with the **Webform** module and Drupal core's **Ban** module (`drush en webform_ban ban`); note that Ban is a soft dependency the installer does not pull in automatically, and without it the ban actions error, so enable Ban yourself. The module has no settings page and no permissions of its own — it reuses core Ban's **`ban IP addresses`** permission, which you grant to trusted moderators. Once enabled, open a webform's **Results** table (`/admin/structure/webform/manage/<id>/results/submissions`): each submission row gains a **"Ban IP Address"** operation that opens core's ban form with the IP pre-filled, and the bulk **Action** select offers **"Ban IP Address"** and **"Ban IP and Delete submission"** to act on several submissions at once. Banning here simply adds the IP to core Ban's site-wide list, after which core's Ban middleware returns 403 to that IP across the whole site — which also stops it re-submitting forms. Because bans are by IP and use the address Webform stored at submit time, confirm your reverse-proxy / trusted-host settings so the **real** client IP is recorded, and remember an IP ban blocks everyone behind a shared or carrier-grade-NAT address.

---

- Ban the IP of a spammy webform submission in one click.
- Ban an IP and delete the offending submission together.
- Bulk-ban the IPs of many selected submissions at once.
- Reuse Drupal core's single Ban list instead of a second list.
- Grant moderators the core `ban IP addresses` permission.
- Open core's ban form pre-filled from a submission row.
- Stop repeat form spammers from re-submitting.
- Cut abusive submitters off site-wide via core Ban.
- Manage bans from the webform Results table.
- Apply bans set elsewhere on the site to forms too.
- Skip IPs already present in the ban list automatically.
- Pair with Webform and the core Ban module.
- Enable the core Ban module before using the ban actions.
- Confirm trusted-proxy settings so the real client IP is banned.
- Avoid banning shared or CGNAT IPs that affect many users.
- Moderate submission spam without a third-party service.
- Review the core Ban list at /admin/config/people/ban.
- Restrict who can ban by controlling the ban permission.
- Combine with CAPTCHA or honeypot for layered spam defence.
- Test the ban flow on staging before production.
- Unban a mistaken entry from core Ban's admin page.
- Keep one consistent ban policy across the whole site.
