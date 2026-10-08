<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Country Alter UI is an admin settings form that rewrites Drupal's built-in country list — renaming or adding entries, filtering countries out, and optionally sorting alphabetically — via a `hook_countries_alter()` implementation.

---

Country Alter UI provides a single configuration form at `/admin/config/regional/countries` (menu: Configuration → Regional and language) where a site administrator edits how the core country list appears everywhere Drupal's country manager is used. In one textarea you supply `code|name` lines that add new countries or override the label (and code) of existing ones; a multi-select lets you filter specific ISO country codes out entirely; and a checkbox sorts the final list alphabetically by name. The settings are saved to the `country_alter_ui.settings` config object and applied at runtime by the module's `hook_countries_alter()` implementation (`CountryAlterUiHooks::countriesAlter()`), so country/address fields and any other consumer of `\Drupal::service('country_manager')->getList()` show the customized list with no theming or code changes. The module requires only Drupal core (`^10.3 || ^11 || ^12`), defines no permissions of its own (the form is gated by core's `administer site configuration`), ships no entities, plugins or Drush commands, and has no external services.

---

- Rename a built-in country label (e.g. show "United States" as "USA") without patching core.
- Correct or localize the display name of a country used in address/country fields.
- Add a country entry (or pseudo-region) that core's standard list does not include.
- Override the name attached to an existing ISO code by supplying `code|name`.
- Remove countries you never ship to by filtering out their ISO codes.
- Restrict a country selector down to a small set by filtering out everything else.
- Present the country dropdown in alphabetical order of the (possibly renamed) labels.
- Apply one central country customization across every country field on the site.
- Feed a customized list to the Address module's country selector (it uses the core country list).
- Manage all three behaviors — override, filter, sort — from one admin form.
- Keep customizations in exportable configuration (`country_alter_ui.settings`) for deployment.
- Ship the country customizations between environments via config sync.
- Adjust the country list per environment by overriding the config object.
- Provide a non-developer, UI-only way for site builders to curate country options.
- Ensure consistency between forms and displayed country names site-wide.
- Bulk-relabel several countries at once by entering multiple `code|name` lines.
- Hide deprecated or politically sensitive entries by filtering their codes.
- Reduce a long country dropdown to the handful relevant to your audience.
- Standardize country naming to match a brand or style guide.
- Re-sort a manually edited list so added entries are not stuck at the bottom.
- Roll back all customizations by clearing the textarea and filter select and saving.
