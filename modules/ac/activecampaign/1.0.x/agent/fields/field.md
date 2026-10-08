<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# active_campaign_field field type, widgets & formatter

Lets any fieldable entity store an ActiveCampaign **form id** and render that form's hosted embed.

## Field type

`Plugin/Field/FieldType/ActiveCampaignItem` — id `active_campaign_field`, label *"Active campaign
field"*, extends core `StringItemBase`. One property/column `value` (a `text` column) holding the AC
form id. `default_widget = activecampaign_form_select_list`, `default_formatter = activecampaign_form`.
Storage schema for the type is also declared in `config/schema/activecampaign.schema.yml`
(`field.storage_settings.activecampaign`).

Add it like any field on *Manage fields* of a node type, custom block type, etc. To use it in Layout
Builder, add the field to a **custom block type** and place that block.

## Widgets (both inject `activecampaign.api`)

- **`activecampaign_form_select_list`** (`FieldWidget/ActiveCampaignFormSelectListWidget`, the
  default) — `formElement()` calls `api->getForms()` and builds a `#type => select` of
  `id => name`, preselecting the stored id.
- **`activecampaign_form_autocomplete`** (`FieldWidget/ActiveCampaignFormAutocompleteWidget`) — a
  `#type => textfield` with `#autocomplete_route_name => 'activecampaign.autocomplete.forms'`. Shows
  the stored form as `"<name> (<id>)"` (title via `api->getFormTitle()`); `massageFormValues()`
  extracts the id back out with `EntityAutocomplete::extractEntityIdFromAutocompleteInput()`.

Both call the live ActiveCampaign API when the entity edit form is built.

## Formatter

`Plugin/Field/FieldFormatter/ActiveCampaignFormFormatter` — id `activecampaign_form` (default),
`field_types = { active_campaign_field }`, injects `@config.factory`. `viewElements()` reads
`activecampaign.settings.url` as `#base_url`, the item value as `#id`, and returns
`#theme => 'activecampaign_form_formatter'` per delta. Render cache is tagged
`config:activecampaign.settings` merged with the entity's cache tags.

### Theme / template

`activecampaign_theme()` (`activecampaign.module`) registers `activecampaign_form_formatter`
(template `templates/activecampaign-form-formatter.html.twig`, variables `id`, `base_url`). The
template output is:

```
<div class="_form_{{ id }}"></div><script src="{{ base_url }}/f/embed.php?id={{ id }}" type="text/javascript" charset="utf-8"></script>
```

i.e. it loads ActiveCampaign's hosted embed script for that form. `base_url`/`id` come from
site config and the (admin/editor-chosen) field value.

## Autocomplete route

`activecampaign.autocomplete.forms` → `Controller\FormAutocompleteController::handleAutocomplete`,
path `/admin/activecampaign/autocomplete/forms`, `_permission: 'access content'`. Reads `?q`,
`Xss::filter`s it, calls `api->searchForms()`, and returns a `JsonResponse` of
`['label'=>name, 'value'=>"name (id)"]`. Only used to feed the autocomplete widget.
