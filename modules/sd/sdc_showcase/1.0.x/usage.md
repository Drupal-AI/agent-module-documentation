<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SDC Showcase auto-generates browsable preview pages for every Single Directory Component (SDC) on the site, with fake data and variation matrices, rendered in the front-end theme.

---

Each discovered component gets a detail page with a schema reference table and a matrix of rendered variations (baseline, enum/boolean sweeps, edge cases, combinations), all seeded with deterministic fake data so previews are reproducible. Components can be grouped into multi-component "collections" that simulate real page layouts, and single variations can be rendered in isolation for iframe screenshotting by tools like BackstopJS or Playwright. Data is produced by pluggable `SdcDataGenerator` plugins and can be overridden per component via `*.stories.yml` / override files. A Drush command surface (`ShowcaseCommands`) exists for listing/building from CI.

Operationally the module ships an access layer on top of Drupal permissions. The settings route (`/admin/config/development/sdc-showcase`) is gated by `administer sdc showcase`. The public showcase routes use a custom `_sdc_showcase_access` check whose default `access_mode: open` requires the `access sdc showcase` permission; opt-in `http_auth` / `query_string` modes let anonymous CI tools in with a credential (compared with `hash_equals`), and `disabled` mode 403s everything. Security posture is sound: the default is permission-gated and only an explicit admin opt-in opens anonymous access. Typical setup is enabling the module, granting `access sdc showcase` to QA roles, and optionally choosing an access mode and seed.

---

- Browse all discovered SDCs at `/sdc-showcase`.
- Open a component detail page with its props/slots schema table.
- Review a matrix of auto-generated variations for a component.
- Isolate a single variation at `/sdc-showcase/{component}/{variation}` for screenshotting.
- Compose a multi-component collection page that mimics a real layout.
- Wire up BackstopJS/Playwright visual regression against variation URLs.
- Enable `iframe_mode` to render bare variation pages for capture tools.
- Set a deterministic `seed` so fake data is reproducible across runs.
- Toggle variation layers (baseline / sweep / edges / combinations) globally.
- Cap the number of generated variations with `global_max_variations`.
- Restrict which SDC providers appear via `enabled_providers`.
- Customise slot placeholder text (short/medium/long/empty/image).
- Grant `access sdc showcase` to QA/reviewer roles only.
- Lock the showcase on production with `access_mode: disabled`.
- Expose it to headless CI with `http_auth` (Basic Auth) mode.
- Expose it to scripted access with `query_string` (`?sdc_key=`) mode.
- Override a component's demo data with a `*.stories.yml` file.
- Write a custom `SdcDataGenerator` plugin for realistic field data.
- List components/collections from the command line via the Drush command.
- Verify components render in the real front-end theme, not the admin theme.
- Catch overflow/wrapping bugs by feeding long slot content.
