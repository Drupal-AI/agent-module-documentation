<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

## Install / enable
`drush en views_autocomplete_api` (core `views` is the only dependency). No libraries, no external
services. Nothing works until you attach the route to a textfield (see routes/autocomplete.md).

## Config object `views_autocomplete_api.settings`
- Install default (`config/install/views_autocomplete_api.settings.yml`): `highlight: 1`.
- Schema (`config/schema/views_autocomplete_api.schema.yml`): `type: config_object`, one mapping key
  `highlight` (`type: boolean`, label "Highlight search in result").
- Consumed only in `ViewsAutocompleteApiManager::getData()` — when TRUE, the matched substring in each
  suggestion label is wrapped by `highlightStr()`. When FALSE, labels are returned unmodified.

## Settings form `ViewsAutocompleteApiConfigForm` (`src/Form/…`)
- `getFormId()` = `views_autocomplete_api_settings_form`; extends `ConfigFormBase`; editable config =
  `['views_autocomplete_api.settings']`.
- Renders a single checkbox `highlight` (default from config) and saves it in `submitForm()` via
  `configFactory()->getEditable(...)->set('highlight', …)->save()`.
- Route `views_autocomplete_api.vaa_config_form` → path `/admin/config/views-autocomplete-api`,
  `_permission: 'administer views autocomplete api'`.

## Caveat: undefined permission
The module ships **no `*.permissions.yml`**, yet the settings route requires
`administer views autocomplete api`. An undefined permission cannot be granted to any role, so as shipped
the settings form is **effectively unreachable through the UI** for every user. To toggle `highlight` in
practice, either set the config directly
(`drush cset views_autocomplete_api.settings highlight 0`) or define the permission in a small custom
module. This is a functional gap, not a feature.

## No Drush services on disk
`composer.json` declares `extra.drush.services["drush.services.yml"] = ">=12"`, but **no `drush.services.yml`
file is present** in the release — the module provides no Drush commands.
