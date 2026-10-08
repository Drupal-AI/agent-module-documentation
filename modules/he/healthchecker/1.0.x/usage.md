<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Health Checker provides a health check service for Drupal sites.

---

Health Checker provides a **lightweight health-check endpoint** — a route returning a minimal JSON status
(`{"status":"OK"}`) so load balancers, uptime monitors and orchestrators can probe whether the site is up. It
provides its own permissions, in the Performance and scalability package.

Use it as a liveness/health probe. It is an operations feature. Security note: the endpoint returns **only a
minimal status** (no versions, no sensor detail), so exposing it publicly reveals only that the site responds —
which is the intended use for a monitor probe; still, you can gate it via its permission or a non-guessable
path if you prefer. It has no access-control role beyond its permission. Configure the health-check route.

---

- Provide a health-check endpoint.
- Return a minimal status (OK).
- Serve uptime/load-balancer probes.
- Provide its own permissions.
- Act as a liveness probe.
- Return minimal JSON.
- Reveal only that the site responds.
- Optionally gate the route.
- Have no access-control role beyond permission.
- Configure the health-check route.
- Handle health checks.
- Return status.
- Configure the endpoint.
- Handle the probe.
- Check health.
- Configure monitoring.
- Handle the route.
- Report status.
- Set the route.
- Provide a health endpoint.
