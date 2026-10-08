<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reserved Paths prevents using any reserved path.

---

Reserved Paths prevents content/users from claiming **reserved URL paths** — it adds validation (and a
pathauto alias alter) so a URL alias that matches a configured reserved pattern is **rejected**, stopping
aliases from shadowing important routes (admin, login, api, etc.) or squatting on names you want to keep free.
It provides its own permissions, in the Reserved Paths package.

Use it to protect route/name space from alias collisions. This is a small **hardening/anti-abuse** feature
(prevents an alias from masking a real route). Configure the reserved list to cover the paths you must protect
(coverage is exactly what you list). It has no broad access-control role beyond its permission. Configure the
reserved paths.

---

- Reject aliases matching reserved paths.
- Stop aliases shadowing key routes.
- Prevent path/name squatting.
- Validate path aliases.
- Alter pathauto aliases.
- Provide its own permissions.
- Protect the route/name space.
- Cover exactly the paths you list.
- Have no broad access-control role.
- Configure the reserved list.
- Handle reserved paths.
- Block reserved aliases.
- Reserve paths.
- Handle the validation.
- Protect paths.
- Configure the paths.
- Handle path reservation.
- Prevent collisions.
- Configure reservations.
- Provide path protection.
