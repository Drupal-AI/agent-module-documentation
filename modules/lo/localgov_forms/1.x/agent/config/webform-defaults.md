<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install-time webform.settings overrides, schema & custodian codes

The module has **no settings form of its own**. It configures Webform at install time and ships a
config schema plus one Webform options entity.

## What install does (`localgov_forms.install`)

`localgov_forms_install($is_syncing)` calls `localgov_forms_apply_webform_config()` unless the site
is syncing config **or** `$settings['localgov_forms_skip_webform_config']` is TRUE. The config is
declared in `localgov_forms_webform_config()`:

**Overrides** (always set on `webform.settings`):

| Key | Value |
|---|---|
| `settings.default_ajax` | `TRUE` |
| `settings.default_ajax_progress_type` | `fullscreen` |
| `settings.default_ajax_effect` | `none` |
| `settings.default_form_submit_once` | `TRUE` |
| `settings.default_form_disable_back` | `TRUE` |
| `settings.default_form_unsaved` | `TRUE` |
| `settings.default_submission_log` | `TRUE` |
| `settings.default_confirmation_message` | `Thank you, your form has been successfully submitted.` |
| `settings.default_wizard_prev_button_label` / `default_wizard_next_button_label` | `Previous` / `Next` |
| `settings.default_preview_prev_button_label` | `Previous` |

**Additions** (only set when the key is currently `NULL`): ~50 `element.excluded_elements.<type>`
entries (address, color, date, datelist, datetime, entity_autocomplete, managed_file, most
`webform_*` elements, etc.) that hide rarely-used element types from the editor palette. Because
these are additive-only, they never clobber an operator's existing exclusions.

### Preserving an existing webform.settings

Add before enabling the module (removable afterwards):

```php
$settings['localgov_forms_skip_webform_config'] = TRUE;
```

Note the README's known caveat: the address lookup element can error if these settings are absent
at install time (drupal.org work item 3584172).

## Update hook

`localgov_forms_update_8001()` creates the `local_custodian_codes_gb` Webform options entity from
`config/install/webform.webform_options.local_custodian_codes_gb.yml` — but only if it does not
already exist and is not staged in sync. Fresh installs get it via the config/install file directly.

## Config schema

`config/schema/localgov_forms.webform.settings.schema.yml` defines a `localgov_forms.webform.settings`
`config_object` mirroring Webform's own `settings`/`assets`/`form`/`element`/`html_editor`/`file`/
`mail`/`export`/`handler`/`variant`/`batch`/`purge`/`test`/`ui`/`libraries`/`requirements` mappings.
It exists so the module's overrides validate against strict config-schema tooling. (`provides_config_schema: true`.)

## Local custodian codes (GB)

`config/install/webform.webform_options.local_custodian_codes_gb.yml` — a Webform options entity
(`id: local_custodian_codes_gb`, label *Local custodian codes (GB)*, category *Geographic*)
mapping GB local-authority custodian codes → names (e.g. `9051: 'Aberdeen City'`). Enforced module
dependency `webform`. Used to populate the **Local authority** restriction select on the address
lookup element (constant `UKAddressLookup::LOCAL_CUSTODIAN_WEBFORM_OPTION_ENTITY_ID`).

## Related suggestions

`composer.json` suggests `drupal/config_ignore` (so editor-built webforms are not deleted on config
sync — ignore `webform.webform.*` and `webform.webform_options.*`) and `drupal/token_environment`.
