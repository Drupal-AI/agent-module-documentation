<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Classic Modeler (eca_cm) — agent index

A core-only authoring UI for **ECA** (Events-Conditions-Actions). It registers one ECA modeller
("core") and a set of Drupal Form API routes to build ECA models. No config, no permissions, no
Drush of its own — it reuses ECA's engine and `administer eca` permission.

- **The `core` EcaModeller plugin and how a model is stored (`eca.eca.<id>`, `modeller: core`)** →
  [plugins/modeller.md](plugins/modeller.md)
- **The admin routes and the build-a-model workflow** →
  [configure/build-model.md](configure/build-model.md)

Key facts:
- Requires the `eca` module (`drupal/eca ^1||^2||^3`). Models are ECA config entities `eca.eca.<id>`.
- Create a model: `/admin/config/workflow/eca/add/core` (permission `administer eca`).
- The modeller plugin: `@EcaModeller(id = "core")`, class
  `Drupal\eca_cm\Plugin\ECA\Modeller\Core`. (ECA 3.x does not persist a `modeller` key in
  `eca.eca` config; identify models by machine id.)
- `configure` is `null` (no settings form); eca_cm adds no config schema and no permissions.
- Optional integrations: Select2 (plugin pickers), Token (token browser).
