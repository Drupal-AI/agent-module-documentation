<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Farm Eggs is a farmOS add-on that provides a "quick form" for recording egg harvests. It gives farmers a streamlined single-screen form to log how many eggs were collected and from which assets, creating a harvest log in farmOS without stepping through the full log form.

---

- Requires the farmOS distribution modules `farm_harvest` and `farm_quick`; Drupal 9 or 10.
- Enable with `drush en farm_eggs`.
- Access the quick form under farmOS's Quick Forms UI (provided by `farm_quick`).
- Fill in the egg quantity (and applicable assets/date) and submit to create a harvest log.
- Permissions and access are inherited from farmOS's quick-form and log access system.

---

- Log daily egg harvests with minimal clicks.
- Create farmOS harvest logs of the "eggs" measure.
- Record the number of eggs collected.
- Associate the harvest with farm assets (e.g. flocks).
- Provide a purpose-built alternative to the generic log form.
- Integrate with farmOS quick-forms navigation.
- Keep egg-production records over time for reporting.
- Use farmOS's units/quantity handling for counts.
- Fit into farmOS's role/permission model.
- Support both Drupal 9 and 10 farmOS installs.
- Enable quick data entry on mobile in the field.
- Feed harvest data into farmOS dashboards and views.
- Reduce data-entry errors with a focused form.
- Complement other farm_quick add-ons.
- Serve as an example quick-form plugin (`Plugin/QuickForm/Eggs.php`).
- Track egg output per asset for flock productivity.
