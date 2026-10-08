<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

## Install / enable

`drush en entity_tracer -y`. No composer requirements (no `composer.json`; distributed via the
drupal.org packaging script) and no declared module dependencies in `entity_tracer.info.yml`.
It relies on core's Field API at runtime (`Drupal\field\Entity\FieldConfig`), so the `field`
module must be present (it is on any standard content site).

## Settings form

`Drupal\entity_tracer\Form\EntityTracerSettingsForm` (extends `ConfigFormBase`), form id
`entity_tracer_entity_tracer_settings`, route `entity_tracer.entity_tracer_settings` at
**`/admin/config/development/entity-tracer-settings`**, permission **`configure entity tracer`**.
Menu link: *Configuration → Development → Entity tracer settings*
(`entity_tracer.links.menu.yml`).

Fields (`buildForm()`):

- **Entities** — `checkboxes` of all *content* entity types. `getContentEntities()` iterates
  `entity_type.manager` definitions and keeps those whose `getGroupLabel()` renders as
  `"Content"`.
- **Max Depth** — `number`, default `10`. Caps trace recursion to avoid timeouts on long
  reference chains.

`submitForm()` splits the checkbox values into `enabled_entity_types` (keyed by machine name,
value = the machine name for checked boxes) and `disabled_entity_types` (value `0`), then saves
`enabled_entity_types`, `disabled_entity_types`, and `max_depth` into `entity_tracer.settings`.

## Config object & schema

Config object **`entity_tracer.settings`** (`getEditableConfigNames()`); schema in
`config/schema/entity_tracer.schema.yml` (`type: config_object`, label "Entity tracer settings"):

- `enabled_entity_types` — sequence of strings (entity-type machine names to trace).
- `disabled_entity_types` — sequence of strings (unchecked types).
- `max_depth` — integer.

(The schema nests these under a `tracerping` key; the form and `Tracer` read them as top-level
config keys via `->get('enabled_entity_types')` / `->get('max_depth')`.)

No `config/install/` defaults ship — the object is created on first save; `Tracer` and the
tracer form treat missing `enabled_entity_types` as "nothing enabled" and `max_depth` falls back
to `10` in the settings form default.

## Caching note

Changing settings invalidates the cache tag `config:entity_tracer.settings`, which drops the
cached `entity_tracer_chain_complete` entry so the next trace rebuilds with the new selection.
