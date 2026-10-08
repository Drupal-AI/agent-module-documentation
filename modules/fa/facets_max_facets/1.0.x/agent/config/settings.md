<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config

## Route & access

- Route `facets_max_facets.settings` — path `/admin/config/search/facets/max-facets`, title *Facets max facets*
  (`facets_max_facets.routing.yml`). Requirement `_permission: 'administer facets'` (reuses the core Facets
  permission; the module defines no permission of its own).
- Admin menu link `facets_max_facets.settings` under `system.admin_config_search`, weight 200
  (`facets_max_facets.links.menu.yml`).

## Form

File: `src/Form/SettingsForm.php` — `final class SettingsForm extends ConfigFormBase`.

- `getFormId()` → `facets_max_facets_settings_form`.
- `getEditableConfigNames()` → `['facets_max_facets.settings']`.
- `buildForm()` renders two required fields:
  - `max_active_facets` — `#type => number`, `#min => 0`. Description notes **0 disables the limit entirely**.
  - `limit_message` — `#type => textarea`. Default text mentions using `:max-count` as the placeholder for the
    configured maximum.
- `submitForm()` casts `max_active_facets` to `(int)`, saves both values via
  `configFactory()->getEditable('facets_max_facets.settings')->set(...)->save()`, then calls `parent::submitForm()`.

Being a standard `ConfigFormBase`, the form is submitted by POST and protected by Drupal's Form API CSRF token;
there is no state-changing GET route.

## Config object

`config/install/facets_max_facets.settings.yml` (shipped defaults):

- `max_active_facets: 5`
- `limit_message: 'Facet searching is limited to :max-count facets. To further refine your search remove some
  facets and try other facets instead.'`

Schema `config/schema/facets_max_facets.schema.yml`:

- `facets_max_facets.settings` (`config_object`): `max_active_facets` (`integer`), `limit_message` (`text`).
- Also declares an (unused-by-code) `facets.facet` third-party-settings mapping with a `respect_global_max`
  boolean — see [../plugins/respect-global-max-facets.md](../plugins/respect-global-max-facets.md).

## Operate

1. Set `max_active_facets` to a value comfortably above normal usage (or `0` to turn the cap off).
2. Write a `limit_message`; include `:max-count` where the number should appear.
3. Enable the **Respect global max facets** processor on each facet that should honor the cap.
