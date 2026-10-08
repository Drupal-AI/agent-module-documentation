<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito webform (castorcito_webform) — agent index

Sub-module of **[Castorcito](../../../../1.2.x/agent/start.md)**. Adds one cfield type that embeds
a Webform. Package `Castorcito`, version 1.2.1-beta5, core `^10.2 || ^11`, GPL-2.0-or-later.

## Dependencies

- `castorcito:castorcito`
- `webform:webform` (contributed Webform module)

## What it provides

- **cfield plugin** `webform` — `src/Plugin/CastorcitoComponentField/Webform.php`, class `Webform`
  extends `Drupal\castorcito\ConfigurableComponentFieldBase` (a `CastorcitoComponentField`
  plugin).
  - `defaultModel()`: `['value' => '', 'webform_id' => '']`.
  - `defaultConfiguration()` / `submitConfigurationForm()` inherit the base (no extra settings).
  - The parent manager's `processCfieldsSettings()` injects a webform entity-autocomplete URL for
    this cfield type.
- **SDC** `components/castorcito_webform/castorcito_webform.twig`: renders the selected webform via
  `drupal_entity(cfield_data.type, cfield_data.webform_id)` (Twig Tweak). The embedded Webform
  enforces its own access/validation/submission. Override with
  `replaces: 'castorcito_webform:castorcito_webform'`.
- **Update hook** `castorcito_webform_update_10101` — removes the obsolete `url_autocomplete`
  setting from existing webform cfields.

No permissions, routes, services, or config schema of its own.

## Usage

Enable it (and Webform), then add a **Webform** cfield when building a component. See the parent
plugin doc:
[../../../../1.2.x/agent/plugins/component-fields.md](../../../../1.2.x/agent/plugins/component-fields.md).
