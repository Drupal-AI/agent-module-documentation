<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Clear PHP Caches adds an admin action to flush PHP opcache/APC.

---

Clear PHP Caches (clearphpcaches) clears PHP's APC and OPcache — providing an admin action (at `/admin/flush/phpcaches`) to flush the PHP bytecode/opcode caches, useful after deployments when opcache holds stale code, without restarting PHP-FPM.

The flush action is gated by a dedicated `clear php caches` permission — restrict to trusted admins (clearing opcache has a brief performance impact). Depends on `admin_toolbar`; supports Drupal 10 and 11.

---

- Clear PHP OPcache/APC.
- Provide an admin flush action.
- Flush stale bytecode after deploys.
- Avoid restarting PHP-FPM.
- Gate with `clear php caches` permission.
- Restrict to trusted admins.
- Note the brief performance impact.
- Depend on `admin_toolbar`.
- Support Drupal 10 and 11.
- Flush at /admin/flush/phpcaches.
- Aid deployments.
- Support operations.
- Clear opcache
- Handle PHP caches
- Support admins.
- Flush caches.
- Clear APC.
- Support ops
