<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Quick Cache Cleaner adds an administrative menu item to quickly clear all Drupal core and Views caches.

---

Quick Cache Cleaner adds a convenient admin menu item to clear caches — a quick way to flush all Drupal
core caches and Views caches from the admin menu, saving a trip to the performance page or Drush. It provides
its own permissions.

Use it for a fast cache-clear from the admin UI. It is an administration/performance utility; clearing caches
is a privileged operation, so it is gated by its permission — grant it only to trusted administrators (a
cache clear has a performance cost/temporary slowdown and shouldn't be exposed to untrusted users). It has no
content-access role beyond its permission. Use the menu item to clear caches.

---

- Add a quick cache-clear menu item.
- Clear core and Views caches.
- Flush caches from the admin menu.
- Avoid the performance page/Drush.
- Provide its own permissions.
- Gate cache-clear by permission.
- Grant only to trusted admins.
- Mind the performance cost of clearing.
- Have no content-access role beyond permission.
- Clear caches quickly.
- Use the menu item.
- Flush Drupal caches.
- Clear Views caches.
- Handle cache clearing.
- Provide quick cache clear.
- Restrict cache clearing.
- Clear all caches.
- Configure the cleaner.
- Flush caches.
- Clear caches.
