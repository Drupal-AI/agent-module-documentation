<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Services Environment Variable Parameters allows setting service container parameters via environment variables.

---

Services Environment Variable Parameters lets you set Symfony service-container parameters from
environment variables — using the pattern `DRUPAL_SERVICE_{parameter}={value}` (with `__` → `.` and nested
array support) to override container parameters (e.g. CORS config, `http.response.debug_cacheability_headers`,
etc.) from the environment, supporting 12-factor / per-environment configuration and keeping settings/secrets
in the environment rather than committed config.

Use it to drive container parameters from env vars. It is a configuration/DevOps feature, and it is
implemented safely: it only processes `$_SERVER` keys with the **`DRUPAL_SERVICE_` prefix** (so client
HTTP headers — which appear as `HTTP_*` — are never matched), it only overrides parameters that **already
exist**, and it runs at **container-compile time** (a service provider `alter()`), so the values come from
the trusted server environment, not from per-request input. Keep the usual discipline: whoever controls the
environment controls these parameters (the intended trusted-operator model), and store any secret values as
environment variables (not committed). It has no access-control role. Set the `DRUPAL_SERVICE_*` variables in
your environment.

---

- Set container parameters from env vars.
- Use the DRUPAL_SERVICE_ prefix pattern.
- Override parameters like CORS config.
- Support 12-factor/per-environment config.
- Only match the DRUPAL_SERVICE_ prefix (not HTTP_* headers).
- Only override existing parameters.
- Run at container-compile time.
- Take values from the trusted environment.
- Keep secrets in env vars, not committed config.
- Have no access-control role.
- Understand env controls the parameters (trusted-operator model).
- Configure via DRUPAL_SERVICE_* variables.
- Set nested array parameters.
- Cast values to the existing type.
- Drive config from env.
- Configure parameters per environment.
- Handle env-based config.
- Override container params.
- Set service parameters.
- Configure via environment.
