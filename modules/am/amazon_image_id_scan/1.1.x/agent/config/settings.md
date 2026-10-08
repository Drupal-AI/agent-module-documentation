<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

## Install / enable

```
composer require drupal/amazon_image_id_scan   # pulls aws/aws-sdk-php ^3.294
drush en amazon_image_id_scan -y
```

The core `image` module must be enabled (the widget extends it). The module ships **no**
`config/install` defaults and **no** `config/schema` — the config object
`amazon_image_id_scan.settings` is created only when the settings form is first saved, and its
values are therefore schema-less (untyped).

## Route & permission

- Route `amazon_image_id_scan.admin_settings` — path `/admin/config/amazon_image_id_scan/configuration`,
  `_form: \Drupal\amazon_image_id_scan\Form\ConfigurationForm`, requirement
  `_permission: 'administer site configuration'`, `_admin_route: TRUE`
  (`amazon_image_id_scan.routing.yml`).
- Menu link `amazon_image_id_scan.admin_settings` under `system.admin_config_media`
  (Configuration → Media), weight 98 (`amazon_image_id_scan.links.menu.yml`).
- `amazon_image_id_scan.permissions.yml` declares one permission, `amazon_image_id_scan load_s3`
  (`restrict access: true`). It is **not used** by any route, service or check in the codebase.

## `ConfigurationForm` (src/Form/ConfigurationForm.php)

A `ConfigFormBase` (`getFormId()` = `amazon_image_id_scan_admin_settings`,
`getEditableConfigNames()` = `['amazon_image_id_scan.settings']`). Marked `@codeCoverageIgnore`.
The whole form is `#tree => TRUE` and rendered as `vertical_tabs` labelled "Amazon rekognition";
it attaches library `amazon_image_id_scan/amazon_image_id_scan.main`. UI strings are Spanish.

Two kinds of tabs:

1. **`rekognition_tab`** (details group) — the AWS credentials plus the list of validation profiles:
   - `rekognition_tab[key]` — textfield, `#required`, AWS access key.
   - `rekognition_tab[secret]` — textfield, `#required`, AWS secret key.
   - `rekognition_tab[tab_config]` — a repeatable list (via `multipleField()` + `tabConfig()`); each
     entry has a `label` and a numeric row key. Each numeric key becomes the id of a validation
     profile ("Config id scan").
2. **One details tab per numeric profile key** — built in a loop over `tab_config`. For profile
   `$key` the form exposes three repeatable groups, each rendered by `multipleField()`:
   - `{$key}_positivo` (`containerPositivos`): rows of `label` + `percentage` (number, max 100) +
     `error_description`. "Labels the document must have" at/above the confidence percentage.
   - `{$key}_negativo` (`containerNegativos`): rows of `label` + `error_description`. Forbidden labels.
   - `{$key}_regular_expresion` (`containerRegularExpresion`): rows of `label` (a PCRE pattern,
     e.g. `/^\d+$/`) + `error_description`. Regex the OCR text must match.

The repeatable-row machinery is home-grown: `multipleField()` renders existing rows plus an
"Agregar item" add button (submit `submitAddDetails` + AJAX `wrapperDetails`); each row has an
"Eliminar item" delete button (`submitDeleteItem`). `add_<name>` / `delete_item_<name>` counters
are tracked in `$form_state`.

`submitForm()` saves `rekognition_tab` into `amazon_image_id_scan.settings` and, for each numeric
key in `rekognition_tab[tab_config]`, saves `$form_state->getValue($key)` into the config key
`$key`. So the stored config looks like:

```yaml
# amazon_image_id_scan.settings
rekognition_tab:
  key: 'AKIA...'                 # AWS access key
  secret: '...'                  # AWS secret key
  tab_config:
    1: { label: 'ID card' }      # numeric profile id -> label
'1':                             # profile config, keyed by the numeric id
  1_positivo:
    - { label: 'Document', percentage: 90, error_description: 'Not an ID document' }
  1_negativo:
    - { label: 'Screenshot', error_description: 'Screenshots are not accepted' }
  1_regular_expresion:
    - { label: '/^\d+$/', error_description: 'ID number not found' }
```

A profile id is later selected on the field widget (see [fields/widget.md](../fields/widget.md),
the *Config id scan* setting), and `Rekognition::document()` reads `config[$prefix.'_positivo']`
etc. where `$prefix` is that numeric id.

## Credential handling notes

- The Rekognition client region is hardcoded to `us-east-1` and version `latest`
  (`Rekognition::connect()`); credentials come only from `rekognition_tab[key]`/`[secret]`. There is
  no Key-module / env-variable option — credentials live directly in this config object. Operators
  who sync/export config should treat `amazon_image_id_scan.settings` accordingly.
