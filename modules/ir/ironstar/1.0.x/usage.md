<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ironstar provides platform support and configuration recipes for Drupal sites hosted on the Ironstar platform.

---

Ironstar provides support integration and recipes for the Ironstar hosting platform (an Australian
managed Drupal/AWS hosting provider). It bundles platform-specific configuration and helpers — the
kind of environment integration a host ships so that Drupal behaves correctly on its infrastructure
(caching, reverse proxy, environment settings, deployment conventions) — along with a settings form
(`ironstar.settings`) for platform options.

Use it on sites hosted with Ironstar to align Drupal with the platform's expectations. Like other
host-integration modules, its value is operational rather than feature-facing; the security-relevant
angle is typically reverse-proxy/trusted-host and environment handling, which should follow the host's
guidance. It provides its own permissions for administering the platform settings. On non-Ironstar
infrastructure it has no purpose.

---

- Integrate Drupal with the Ironstar platform.
- Apply Ironstar hosting recipes.
- Configure platform options at ironstar.settings.
- Align Drupal with Ironstar infrastructure.
- Handle reverse-proxy/environment settings.
- Provide host-specific helpers.
- Administer platform settings via permission.
- Follow the host's caching conventions.
- Support deployment on Ironstar.
- Bundle Ironstar configuration.
- Serve operational (not feature) value.
- Use only on Ironstar-hosted sites.
- Follow host guidance for trusted hosts.
- Manage environment-specific settings.
- Integrate with Ironstar's AWS hosting.
- Ship platform recipes.
- Configure caching for the platform.
- Provide no purpose off-platform.
- Support Ironstar-managed Drupal.
- Handle platform deployment conventions.
