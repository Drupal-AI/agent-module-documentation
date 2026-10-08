<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Memory Limit lets you raise (or lower) the PHP `memory_limit` for specific user roles, so heavy administrative work gets more memory without raising the global limit for anonymous traffic.

---

A configuration form at `/admin/config/system/role-memory-limit` (permission `administer site configuration`) stores a memory value per role in `role_memory_limit.config`. An event subscriber on `KernelEvents::REQUEST` reads the current user's roles, collects the configured limits, and applies the highest one via `ini_set('memory_limit', ...)` for that request (user 1 uses the `administrator` value; `-1` means unlimited). Because it runs early in the request, the appropriate limit is set before most work happens. It has no effect where PHP is compiled without `ini_set` for memory, and values must be plain integers (MB). Setting generous limits only for trusted roles avoids exposing the whole site to high per-request memory use.

---

- Give administrators more PHP memory for bulk/config operations.
- Keep anonymous requests on a low memory limit for stability.
- Raise memory only for editors running heavy content tasks.
- Apply the highest configured limit when a user has several roles.
- Set an unlimited (`-1`) memory limit for a trusted role.
- Avoid bumping the global php.ini limit for the whole site.
- Tune memory per role without touching server config.
- Support migration/import roles that need extra headroom.
- Reduce OOM errors during admin batch processes.
- Configure per-role limits through a simple admin form.
- Apply limits early via a REQUEST-stage event subscriber.
- Let user 1 inherit the administrator memory value.
- Cap memory for low-trust roles to contain abuse.
- Adjust limits per environment through configuration.
- Keep front-end performance predictable under load.
