<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monitoring HRM exposes one route, `/healthz`, whose HTTP status code (200 or 500) tells external infrastructure whether any of the Monitoring module's health sensors is currently failing.

---

The module adds a single controller and a single route on top of the contrib `monitoring` module. On request it calls Monitoring's `SensorRunner`, counts the sensors whose status is `STATUS_CRITICAL`, and returns a tiny JSON body `{"count_failures": N}` — with status 500 when N is greater than zero and 200 when it is zero. The body is deliberately minimal because the consumers are machines, not people: a load balancer, a Kubernetes liveness/readiness probe, or an uptime service such as Pingdom or Statuscake reads the status code and acts on it. The route is guarded by a custom access check rather than a permission, using a `token` query-string argument compared against a configured `endpoint_key` (config object `monitoring_hrm.settings`, default `'top secret'`); there is no admin UI, so the key is set by config export or a `settings.php` override. Reducing the whole Monitoring sensor set to a single status code is what makes Drupal's internal health visible to the infrastructure deciding whether to keep sending it traffic.

---

- Give a load balancer a single health signal to route on.
- Configure a Kubernetes liveness probe against `/healthz`.
- Configure a Kubernetes readiness probe that gates traffic.
- Point Pingdom at the endpoint to alert on failures.
- Point Statuscake or another uptime checker at a real health check.
- Take an unhealthy instance out of rotation automatically.
- Reduce Monitoring's sensor dashboard to one status code.
- Alert the maintenance team when any Monitoring sensor fails.
- Add a smoke-test health check to a deployment pipeline.
- Verify a site's health immediately after a release.
- Use the conventional `/healthz` path expected by orchestration tooling.
- Pass a shared secret via the `token` query parameter to authorize the probe.
- Set the `endpoint_key` through a `settings.php` config override.
- Export and edit `monitoring_hrm.settings` to change the token.
- Distinguish infrastructure liveness checks from human-readable dashboards.
- Fail a canary deployment when sensor failures appear.
- Monitor cron freshness, disk usage or other Monitoring sensors indirectly through one code.
- Wire the endpoint into an external status page.
- Restrict `/healthz` at the network or reverse-proxy layer to the probing infrastructure.
- Return HTTP 500 to a probe so the orchestrator restarts or reschedules the pod.
- Confirm 200 responses across a fleet before promoting a build.
- Combine with the Monitoring module's own sensor configuration.
- Give an SRE team a machine-readable single source of health truth.
