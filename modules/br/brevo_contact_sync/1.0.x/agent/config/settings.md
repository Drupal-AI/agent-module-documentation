<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapping configuration — `brevo_contact_sync.settings`

Source: `src/Form/BrevoContactMappingForm.php`, `brevo_contact_sync.routing.yml`,
`brevo_contact_sync.links.menu.yml`, `brevo_contact_sync.links.task.yml`.

## Install / prerequisite

1. Install and configure **`sendinblue_api`** first, and authorize it with a Brevo API key
   (stored by that module in config object `sendinblue_api.config`, key `api_key`).
2. Enable `brevo_contact_sync`. It ships no install file, no default config and no schema — the
   config object `brevo_contact_sync.settings` is created only when the form is first saved.

## Route & access

- Route id **`brevo_contact_sync.mapping`**, path
  `/admin/config/services/sendinblue-api/contact-mapping`, `_form` =
  `BrevoContactMappingForm`, `_title` "Brevo Contact Mapping", `_admin_route: TRUE`.
- Permission requirement: **`administer sendinblue api configuration`** — this permission is
  declared by the `sendinblue_api` module, not by this one (this module has no `.permissions.yml`).
- Surfaced twice: a menu link (`brevo_contact_sync.links.menu.yml`, parent
  `system.admin_config_services`) and a local task tab labelled "Mapping"
  (`brevo_contact_sync.links.task.yml`, base route `sendinblue_api.config`).

## Form behaviour (`buildForm`)

- Reads `$this->sendinblueApi->getConfig()`; if `api_key` is empty it renders only a message
  ("You must authorize Sendinblue API…") and returns — no mapping UI.
- Populates dropdowns from Brevo, live:
  - **List** select (`lists`, required, `#weight -10`): options from
    `sendinblueApi->getMailingLists()` keyed by `list_id` → `name`; default = stored
    `selected_list`.
  - **Mapping Field** options: `sendinblueApi->getCustomFields(FALSE)->custom_fields`, i.e. the
    Brevo account's contact attributes, keyed by name.
- **User Field** options: `entity_field.manager->getFieldDefinitions('user','user')`, filtered to
  base fields `['name','uid','mail','status','roles']` plus any field whose name starts with
  `field_`.
- **Value** options (`ref_value`) come from `fieldContent()`, which maps each user field's type to
  the sub-values it can emit: `string/email/integer/decimal/float/boolean` → `string_value`;
  `list_string` → `list_string_value` / `list_string_key`; `address` → country/name/line1-3/
  locality/postal_code/administrative_area/etc.; `link` → `link_url` / `link_label`;
  `entity_reference` → `entity_reference_target_id` / `entity_reference_name`; `image`/`file` →
  `file_uri` / `file_full_url`.
- The mappings table is an AJAX-driven repeater: **Add Mapping** (`::addMapping`) appends a blank
  row, per-row **Remove** (`::removeMapping`) deletes it (row 0's Remove is disabled); both refresh
  the `#mappings-wrapper` via `::ajaxCallback`.

## Config object written (`submitForm`)

`getEditableConfigNames()` = `['brevo_contact_sync.settings']`. On save:

```
brevo_contact_sync.settings:
  selected_list: <Brevo list id chosen in the "lists" select>
  mappings:
    - user_field: <machine name, e.g. mail | name | field_phone>
      ref_value:  <e.g. string_value | list_string_key | address_locality | link_url>
      mapping_field: <Brevo contact attribute name>
    - ...
```

There is **no config schema** in the module, so these keys are untyped for config
inspection/translation. `selected_list` is stored as chosen; the sync hook coerces it to
int(s).
