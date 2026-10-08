API Insight Lab is an in-Drupal admin dashboard for load-testing, chaining, asserting on, and inspecting HTTP/REST APIs, with snapshots and per-environment configuration.

---

API Insight Lab installs a React single-page app at Administration » Configuration » Development » API Insight Lab (`/admin/config/development/api-insight-lab`), reachable only to users with the core "administer site configuration" permission. The SPA talks to a family of JSON endpoints under `/api/perf-test/*` implemented by `ApiTestController` and `ConfigExportController`. Its Load Tester runs concurrent Guzzle requests (1-100 virtual users, 1-1000 iterations per VU, optional warmup/ramp-up/sustain/ramp-down phases) against any target URL and reports requests-per-second, latency percentiles, standard deviation, a DNS/TCP/TLS/server/download bottleneck breakdown, cache hit/miss ratios, and performance grades. Configurations and results persist in seven content entities (presets, assertions, snapshots, environment profiles, request chains, plus legacy result/setting entities). Beyond raw load testing it offers response assertions, request chaining with JSONPath variable extraction, environment profiles with `{{VARIABLE}}` templating, snapshot save/compare/diff, config import/export with URL remapping, and auto-discovery of the site's own REST and JSON:API resources. It depends only on core's REST module and also registers a set of deliberately public `/api/test/*` mock endpoints for exercising the tool.

---

- Load-test a REST endpoint by configuring virtual users and iterations and firing concurrent requests.
- Measure requests-per-second (average and peak) and error rate under load.
- Inspect latency percentiles (p50, p75, p90, p95, p99), mean, median, min, max, and standard deviation.
- Run phased load tests with warmup, ramp-up, sustain, and ramp-down stages using presets (Standard Load, Stress Test, Spike Test).
- Break down where time is spent per request: DNS lookup, TCP connect, TLS handshake, server processing (TTFB), and download.
- Track Drupal cache hit/miss ratios via the `X-Drupal-Cache` response header while under load.
- Send requests with Basic Auth, Bearer token, or custom API-key header credentials.
- Add custom headers, query parameters, and JSON/form/raw request bodies to test requests.
- Save reusable test configurations (presets) grouped automatically by URL path.
- Attach assertions to a preset: status code, response time threshold, body-contains, JSONPath value, or header check.
- Validate responses automatically and see per-assertion pass/fail after each run.
- Save response snapshots (URL, method, headers, body, metrics) and version them per endpoint.
- Compare two snapshots side by side with a metrics diff and response-body visual diff.
- Build multi-step request chains that pass values between steps via JSONPath extraction.
- Reference extracted or global variables in later chain steps with `{{variableName}}` substitution.
- Define environment profiles (name, base URL, colour, variables) and switch between dev/stage/prod targets.
- Use relative URLs that automatically resolve against the active environment's base URL.
- Export selected presets and chains to JSON, optionally stripping stored auth secrets, for sharing or migration.
- Import a config bundle with from/to URL remapping to retarget it at a different environment.
- Auto-discover enabled REST resources and JSON:API routes on the current site and populate the tester from them.
- Exercise the tool against the bundled mock endpoints (`/api/test/health`, `/echo`, `/delay`, `/status/{code}`, `/users`, `/login`, `/orders`, `/random`).
