<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prometheus Exporter - Token Access — agent index

Lets a static token authenticate `/metrics` instead of the `access prometheus metrics` permission.
Alters the parent's metrics route to use a custom access check. No UI; configure via `settings.php`.
Depends on `prometheus_exporter`.

- **Token config keys, header/query forms, flood control, the route alter** →
  [configure/token.md](configure/token.md)

Parent module docs: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)

Note: the shipped `access_token` is empty, and with no token configured the access check allows
every request to `/metrics` — set a token when enabling this submodule.
