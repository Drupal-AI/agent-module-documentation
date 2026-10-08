<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete Extras — widget settings, menu-link form, config & JS

All logic lives in `src/Hook/AutocompleteExtrasHooks.php` (service id = the class FQN, autowired).
Constants: `DEFAULT_MATCH_LIMIT = 10`, `DEFAULT_MIN_LENGTH = 1`.

## Install / enable

```
drush en autocomplete_extras -y
```

No dependencies are declared in `autocomplete_extras.info.yml`. Link-widget support requires core's
`link` module (the `LinkWidget` class is referenced with a `use`; if `link` is absent that branch is
simply never hit). Core `^10.3 || ^11`.

## Per-widget settings (Manage form display)

`fieldWidgetThirdPartySettingsForm()` (`#[Hook('field_widget_third_party_settings_form')]`) adds
settings to the widget's gear/settings panel **only** when the widget is a `LinkWidget` or an
`EntityReferenceAutocompleteWidget` (otherwise returns `[]`):

- `min_length` — `#type => number`, `#min => 1`, title "Minimum length to trigger autocomplete".
  Default = existing third-party value or `DEFAULT_MIN_LENGTH` (1).
- `match_limit` — `#type => number`, `#min => 0`, title "Number of results", "Use 0 to remove the
  limit." **Added only when the widget does not already have a core `match_limit` setting** (i.e.
  link widgets get it; entity-reference autocomplete widgets already expose core's own `match_limit`,
  so this module reuses that instead of adding a duplicate).

Stored as widget **third-party settings** under provider `autocomplete_extras`. Schema:
`config/schema/autocomplete_extras.schema.yml` →
`field.widget.third_party.autocomplete_extras` (type `autocomplete_extras.third_party_settings`)
with integer `match_limit` and `min_length`.

`fieldWidgetSettingsSummaryAlter()` (`#[Hook('field_widget_settings_summary_alter')]`) appends the
summary lines "Autocomplete suggestion list size: N/unlimited" and "Min length to trigger
autocomplete: N" (limit 0 → shown as "unlimited").

## Applying the settings (form alter)

`fieldWidgetCompleteFormAlter()` (`#[Hook('field_widget_complete_form_alter')]`) runs on form build:

1. Bails unless the widget is `LinkWidget` or `EntityReferenceAutocompleteWidget`, and unless
   `getThirdPartySettings('autocomplete_extras')` is non-empty.
2. Chooses the target element key: `uri` for link widgets, `target_id` for entity-reference.
   `match_limit` = third-party value (link) or the widget's own core `match_limit` (entity-ref);
   `min_length` = third-party value.
3. Handles both single and multi-value widgets (iterates `#max_delta` when present) and sets, per
   item: `#selection_settings['match_limit'] = $match_limit` and
   `#attributes['data-min-length'] = $min_length`.
4. Attaches library `autocomplete_extras/autocomplete_extras`.

`match_limit` flows into **core's** autocomplete route + selection handler, which cap the suggestion
list — the module issues no query and exposes no route of its own. `min_length` is enforced only in
the browser (see JS below).

## Menu Link Content (site-wide)

`formMenuLinkContentMenuLinkContentFormAlter()`
(`#[Hook('form_menu_link_content_menu_link_content_form_alter')]`) reads config object
`autocomplete_extras.settings`. When `menu_link_content.enabled` is TRUE it sets on the menu-link
form's link field:

- `$form['link']['widget'][0]['uri']['#selection_settings']['match_limit']` = configured value or 10.
- `$form['link']['widget'][0]['uri']['#attributes']['data-min-length']` = configured value or 1.
- attaches the library.

### Settings form & config

- Route `autocomplete_extras.settings` → `/admin/config/user-interface/autocomplete-extras`,
  `_permission: 'administer site configuration'`, `_admin_route: TRUE`
  (`autocomplete_extras.routing.yml`). Menu link: `autocomplete_extras.links.menu.yml`, parent
  `system.admin_config_ui`.
- Form `src/Form/AutocompleteExtrasSettingsForm.php` (extends `ConfigFormBase`, form id
  `autocomplete_extras_settings`, editable config `autocomplete_extras.settings`). Fields: a
  `menu_link_content[enabled]` checkbox, plus a `#states`-hidden fieldset with `match_limit`
  (`#min 0`) and `min_length` (`#min 1`). `submitForm()` casts `enabled` to bool and only writes the
  numeric values when `is_numeric()`.
- Config schema `autocomplete_extras.settings` (config_object): `menu_link_content` mapping →
  `enabled` (boolean), `match_limit` (integer), `min_length` (integer).

Example config (`config/sync/autocomplete_extras.settings.yml`):

```yaml
menu_link_content:
  enabled: true
  match_limit: 20
  min_length: 3
```

## Client-side behavior

`js/autocomplete_extras.js` — `Drupal.behaviors.autocompleteExtras`: uses `once('autocomplete-extras',
'input.form-autocomplete', context)`, reads `data-min-length`, and if `> 0` calls
`$el.autocomplete('option', 'minLength', minLength)`. Library
`autocomplete_extras.libraries.yml` → deps `core/drupal.autocomplete`, `core/once`; plus
`css/autocomplete_extras.css`. Because `min_length` is a client-side jQuery UI option only, it is a
usability gate, not a server-side constraint.
