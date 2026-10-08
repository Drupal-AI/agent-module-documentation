<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Dumper

Request Dumper is a debugging aid for inspecting incoming HTTP requests — especially API calls
and webhooks whose payloads are otherwise hard to capture. It registers an HTTP middleware that,
**only when dumping is explicitly enabled**, writes each matching request's body and headers to
timestamped files under a chosen non-public stream wrapper (`temporary://` by default; the
`public` scheme is deliberately excluded).

Dumping is controlled from an admin form and can be turned on in two ways:
- **Timed:** enable for a fixed duration (60s–30min) and optionally restrict to specific HTTP
  methods and a path prefix (e.g. `/jsonapi/node/`).
- **Always-on URL:** generate a random-token endpoint `/request-dumper/always/{token}` intended
  for capturing webhook traffic; it returns `{"result":"success"}` and dumps whatever is posted.

This is the Drupal 11-only release (`core_version_requirement: ^11`); it drops support for
Drupal 9 and 10.

---

## Installation & configuration

- Install with `drush en request_dumper`.
- Configure at *Configuration → Development → Request Dumper*
  (`/admin/config/development/request-dumper`, permission **administer site configuration**).
- Dumping is **off by default** — nothing is written until an admin submits the form with a
  duration or enables the always-on URL.
- Choose the **dump file location** (any writeable non-public wrapper; `public` is excluded so
  dumps are not web-served), the methods to capture, and an optional path prefix.
- Use the *Cleanup existing files* option to delete previously captured dumps.
- The always-on route is protected by a `hash_equals` check against a random base64 token stored
  in state.
- Note: the page cache may respond before the request reaches the dumper; disable the page cache
  to capture all anonymous requests.

---

## Use cases

- Capture the exact body of an incoming webhook for debugging.
- Inspect headers of API requests hitting the site.
- Debug JSON:API / REST payloads by restricting to a path prefix.
- Record only specific HTTP methods (POST/PATCH/etc.) during a test.
- Provide a throwaway endpoint to point a third-party webhook at.
- Reproduce integration issues by examining raw request content.
- Time-box request capture so logging auto-disables after minutes.
- Store dumps in a private/temporary or remote wrapper, never public.
- Clean up captured files from the UI after debugging.
- Verify signatures or tokens a partner claims to be sending.
- Diagnose malformed requests from an upstream system.
- Keep dumps out of the webroot for safety.
- Troubleshoot content negotiation and header handling.
- Confirm what a load balancer/proxy forwards to Drupal.
- Support short, controlled debugging windows in production.
- Audit exactly what a client posts during onboarding.
- Inspect the decoded request URI alongside captured headers.
