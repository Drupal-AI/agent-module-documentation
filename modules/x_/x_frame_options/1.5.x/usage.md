<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
X-frame-options Configuration adds an `X-Frame-Options` HTTP response header to every page so you can control whether the site may be embedded in a frame/iframe and protect against clickjacking.

---

The module (machine name `x_frame_options_configuration`, project `x_frame_options`) registers a kernel response event subscriber (`XframeSubscriber`, priority -20) that sets the `X-Frame-Options` header on every response based on a single stored directive. A settings form at `admin/config/system/x_frame_options_configuration/settings` (route `x_frame_options_configuration.settings`, permission `administer site configuration`) lets you pick the directive: `DENY` (never allow framing), `SAMEORIGIN` (only same-origin framing), `ALLOW-FROM` (allow a specific URI, entered in a second field), or `ALLOW-ALL` (which makes the subscriber **remove** the header entirely). The value lives in the config object `x_frame_options_configuration.settings` under the nested keys `x_frame_options_configuration.directive` and `x_frame_options_configuration.allow-from-uri`. The module ships no config schema and no default config, so before the form is first saved the config is empty and the subscriber falls back to emitting `X-Frame-Options: 0`; save the form once to set a real directive. Note that the `ALLOW-FROM` directive is obsolete/ignored in modern Chromium and Safari (use a Content-Security-Policy `frame-ancestors` for those). There are no permissions or Drush commands of its own.

---

- Add `X-Frame-Options: SAMEORIGIN` site-wide to reduce clickjacking risk.
- Set `X-Frame-Options: DENY` so the site can never be framed anywhere.
- Allow a specific partner site to frame the pages with `ALLOW-FROM <uri>`.
- Remove the header entirely by choosing `ALLOW-ALL` (e.g. when another layer sets it).
- Meet a security-audit requirement for an anti-framing response header.
- Configure the directive through the admin UI without touching server config.
- Store the framing policy as exportable Drupal config for deployment.
- Harden an admin/back-office site against being embedded by third parties.
- Toggle framing policy per environment via config overrides.
- Protect login/checkout pages from being wrapped in a malicious iframe.
- Apply the header uniformly to every route via a response subscriber.
- Combine with a reverse proxy / CSP strategy for defense in depth.
- Quickly switch a site from SAMEORIGIN to DENY during an incident.
- Provide a simple, UI-driven alternative to editing `.htaccess`/nginx for this header.
- Document the site's framing policy in one place (the settings form).
- Let a specific embedding partner be added via the ALLOW-FROM URI field.
- Ensure the header is present on cached and dynamic responses alike.
- Give non-server-admins control over the anti-clickjacking header.
- Audit the current directive by reading `x_frame_options_configuration.settings`.
- Turn framing protection on with a single form save after enabling the module.
