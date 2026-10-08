<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
URL Path Restrictions validates URL paths and aliases against disallowed patterns.

---

URL Path Restrictions **validates URL paths and aliases against a configured list of disallowed patterns**
— preventing editors from creating a path alias (or entity path) that matches a reserved/forbidden pattern, via
a validation constraint added to the `alias` and `path` fields. It depends on core Path Alias, Pathauto and
System, in the Custom package.

Use it to reserve/forbid certain URL patterns. Understand its scope precisely: it is a **content-integrity
validation**, not a runtime access control — it stops **creation** of aliases/paths matching the disallowed
patterns (the value fails validation on save), it does **not** 403 visitors who request such a URL. So use it to
keep editors from colliding with reserved paths, not to protect content (use real access control for that). It
has no access-control role. Configure the disallowed patterns.

---

- Validate paths/aliases vs disallowed patterns.
- Block creating matching aliases.
- Reserve/forbid URL patterns.
- Add a constraint to alias/path fields.
- Depend on core Path Alias/Pathauto.
- Prevent alias collisions.
- BE content-integrity validation, not access control.
- Not 403 visitors requesting such URLs.
- Use real access control to protect content.
- Have no access-control role.
- Configure the disallowed patterns.
- Handle path restrictions.
- Validate paths.
- Configure the patterns.
- Restrict aliases.
- Handle the constraint.
- Validate aliases.
- Reserve paths.
- Set the patterns.
- Provide path-pattern validation.
