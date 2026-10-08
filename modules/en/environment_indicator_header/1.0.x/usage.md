<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Environment Indicator Header emits the current release string in a `Release` HTTP response header.

---

Environment Indicator Header is a small add-on to the Environment Indicator module. On every response it sets a `Release` HTTP header whose value is the current release string stored in the `environment_indicator.current_release` Drupal state key. That state value is the same one Environment Indicator uses for its "current release" version identifier, typically set from deployment tooling with `drush state:set environment_indicator.current_release <release>`. The module ships a single state-reader service and a single response event subscriber; it has no settings form, routes, permissions or configuration objects, and it depends on the `environment_indicator` module. When the state key is empty (the default) no header is added.

---

- Add a `Release` HTTP header carrying the deployed release string to responses.
- Confirm which release answered a request without loading an admin page.
- Surface the deployed version to automated checks and monitoring probes.
- Verify a deployment landed by inspecting response headers with `curl -I`.
- Expose the release to a reverse proxy, CDN or load balancer for logging.
- Correlate a bug report with the exact release that produced it.
- Read the release from CI/CD smoke tests after a deploy.
- Distinguish which environment served a cached response by its release value.
- Feed the release string into synthetic monitoring assertions.
- Tag error-tracking events with the release seen in the response header.
- Check the release from a shell script instead of the admin toolbar.
- Complement Environment Indicator's visual toolbar with a machine-readable signal.
- Publish the release set via `drush state:set environment_indicator.current_release`.
- Let ops tooling detect stale deploys by comparing header values across nodes.
- Expose the release to browser dev tools for quick front-end debugging.
- Drive blue/green or canary checks that compare the `Release` header per host.
- Confirm a rolling deployment replaced every application server.
- Include the release in HTTP-level audit or access logs.
- Give QA a header to assert against in API and end-to-end tests.
- Provide a lightweight release marker without editing settings.php.
- Report the release to uptime checks that only read headers.
- Trace requests through a stack by the release header at each hop.
- Verify the state-driven release value is propagating after `drush state:set`.
