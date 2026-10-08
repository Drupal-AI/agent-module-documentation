<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Canvas LMS is a tiny base module that stores two shared settings — institution name and Canvas environment — for the other modules in the Instructure Canvas LMS integration ecosystem.

---

Canvas LMS is a **"parent"/base module** for the Instructure Canvas LMS integration modules (Canvas API, Canvas LTI). It does one thing: it holds two pieces of configuration that those modules read — the **institution** (the subdomain used in the `https://<institution>.instructure.com` URL) and the **environment** (`test`, `beta`, or `production`). It provides a single admin settings form (`CanvasLmsSettingsForm`) writing the `canvas_lms.settings` config object, plus a *Configuration → Canvas LMS* landing menu. It ships **no API client, no HTTP calls, no entities, no permissions, no plugins, no Drush commands and no credential storage of its own** — consuming modules build the actual Canvas base URL from these two values and handle their own API tokens. Both admin routes require `administer site configuration`. Works across Drupal core 8–11.

---

- Install this module as the shared base for Canvas API / Canvas LTI integrations.
- Set your Canvas **institution** name (the `*.instructure.com` subdomain) once, in one place.
- Choose which Canvas **environment** to target: Test, Beta, or Production.
- Let multiple Canvas modules read one consistent institution/environment pair.
- Provide the values a consuming module uses to assemble the Canvas host (e.g. `https://<institution>.instructure.com`).
- Switch a whole site between Canvas Test and Production by changing one radio.
- Group all Canvas-related admin pages under a single *Configuration → Canvas LMS* menu section.
- Read `canvas_lms.settings:institution` from another module's service or form.
- Read `canvas_lms.settings:environment` to decide which Canvas subdomain suffix to use.
- Export the two settings via configuration management (`drush cex`) to promote them between site environments.
- Restrict who can change Canvas connection settings to site administrators only.
- Avoid duplicating the institution/environment config in every Canvas submodule.
- Serve as the dependency other Canvas ecosystem modules declare.
- Point a staging site at Canvas Beta while production points at Canvas Production.
- Keep Canvas endpoint configuration out of code and in config.
- Provide a stable config key (`canvas_lms.settings`) other modules can depend on.
- Give site builders a simple two-field form instead of hand-editing config.
- Act as the discovery point ("where do I set my Canvas institution?") for the integration.
- Coordinate a shared environment choice so all Canvas modules hit the same instance.
- Use it purely as a settings container — add the API/LTI modules for actual Canvas functionality.
