<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Farm Eggs is a farmOS add-on that provides a "quick form" for recording egg harvests. It gives farmers a streamlined single-screen form to log how many eggs were collected and from which layer assets, creating a harvest log in farmOS without stepping through the full log form. It also adds a "Produces eggs" checkbox to animal and group assets so those assets can be offered on the form.

---

- Requires farmOS 4 (`farmos/farmos: ^4`) and Drupal 11 (`core_version_requirement: ^11`).
- Depends on the farmOS modules `farm_animal`, `farm_harvest`, `farm_quantity_standard`, and `farm_quick`.
- Enable with `drush en farm_eggs`.
- Access the quick form at `/quick/eggs` (also listed under farmOS's Quick Forms UI provided by `farm_quick`).
- Using the form requires the `create harvest log` permission (declared on the quick-form plugin).
- To make an asset selectable on the form, edit an animal or group asset and check "Produces eggs".
- Fill in date, quantity, optionally select layer asset(s) and add notes, then submit to create a harvest log of measure `count` with units `egg(s)`.
- The submit handler also copies the selected assets' current locations onto the harvest log.

---

- Log daily egg harvests with minimal clicks at `/quick/eggs`.
- Create farmOS harvest logs recording a `count` quantity in `egg(s)` units.
- Record the number of eggs collected on a chosen date.
- Associate the harvest with layer assets (animal/group) marked "Produces eggs".
- Auto-populate the log's location from the selected assets' locations.
- Flag which animal/group assets produce eggs via the added `produces_eggs` boolean field.
- Auto-select the layer asset when only one egg producer exists.
- Provide a purpose-built alternative to the generic log form.
- Integrate with farmOS quick-forms navigation.
- Keep egg-production records over time for reporting.
- Fit into farmOS's role/permission model via `create harvest log`.
- Enable quick data entry on mobile in the field.
- Feed harvest data into farmOS dashboards and views.
- Reduce data-entry errors with a focused form.
- Serve as an example quick-form plugin (`src/Plugin/QuickForm/Eggs.php`).
