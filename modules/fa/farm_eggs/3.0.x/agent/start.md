<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Farm Eggs — agent orientation

farmOS contrib add-on (farmOS 4 / Drupal 11) providing an egg-harvest "quick form".

- Requires `farmos/farmos: ^4`; module deps: `farm_animal`, `farm_harvest`, `farm_quantity_standard`, `farm_quick`. Only usable inside a farmOS install.
- Single quick form: `src/Plugin/QuickForm/Eggs.php` — a `farm_quick` QuickForm registered with the `#[QuickForm(id: 'eggs', ...)]` attribute; requires the `create harvest log` permission. Reachable at `/quick/eggs`.
- Form fields: `date` (datetime, required), `quantity` (number, required, min 0, step 1), `assets` (checkboxes of active non-archived assets whose `produces_eggs` field is TRUE; auto-selected if only one), `notes` (text_format). Submit creates a `harvest` log via `QuickLogTrait::createLog()` with a `count` quantity in `egg(s)` units, the selected assets, and those assets' current locations (via `AssetLocationInterface`).
- `src/Hook/FieldHooks.php` implements `hook_farm_entity_bundle_field_info` to add a `produces_eggs` boolean field to `animal` and `group` asset bundles (OOP `#[Hook]` implementation).
- No custom routes/controllers, no config entities, no permissions.yml, no drush commands, no libraries. Access/permissions inherited from farm_quick and farmOS log access (`create harvest log`). No notable security surface.
