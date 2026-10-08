<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA HubSpot actions

40 ECA Action plugins in `src/Plugin/Action/`, all declared with
`#[Action(id: 'eca_hubspot_<x>', category: 'HubSpot', type: 'system')]` +
`#[EcaAction(version_introduced: '1.0.0')]`. Config schema for each is
`action.configuration.eca_hubspot_<x>` in `config/schema/eca_hubspot.schema.yml`. Each action's
`execute()` reads its config, runs ECA token replacement, calls a `HubSpotService` method
(see [../api/service.md](../api/service.md)), and optionally writes the result to a token.

## Install / enable

`drush en eca_hubspot` — pulls in `eca` and `hubspot_api`. Configure HubSpot credentials in the
`hubspot_api` module (`/admin/config/services/hubspot-api`) before running any action; this module
adds no settings page and no permissions. Actions appear in the ECA modeler under category
**HubSpot** and can be attached to any ECA event/condition flow.

## Shared mechanics (base classes)

`HubSpotActionBase` (extends ECA `ConfigurableActionBase`; injects `eca_hubspot.hubspot`):
- `getObjectId($key)` — token-replaced object id from config.
- `mergeYamlSettings($base, $key)` — parses a config field as YAML (`Symfony\…\Yaml::parse`) and
  recursively merges it into `$base` (`mergeArraysRecursive`); parse errors are logged, base kept.
- `addYamlPropertiesField()` — adds the `additional_properties` textarea (custom HubSpot fields).
- `addTokenOutputField()` — adds the `token_name` textfield (weight 50).
- `storeResponseToken($response)` — if `token_name` set and `$response` non-null, calls
  `tokenService->addTokenData(<token>, $response)`.
- All input fields set `#eca_token_replacement = TRUE`.

`HubSpotSearchActionBase` (extends the above) — default config `filters/sort_by/limit(=100)/token_name`;
`execute()` parses `filters` YAML, clamps `limit` to 1–100 (else 100), calls the subclass
`performSearch()`, stores the result token. Subclasses implement `getObjectType()`,
`getObjectLabel()`, `getFilterExample()`, `getBlockFilterExample()`, `performSearch()`.

`token_name` output holds the formatted response: `{id, properties{}, created_at, updated_at,
associations?}` for single objects, `{total, results[]}` for searches, arrays of IDs / pipeline
structures for associations / pipelines.

## Actions by object

Each object type has **Create / Update / Get / Delete / Search** (7 objects = 35 actions). Config
keys below are from the schema; all are `string` unless noted.

- **Contact** (`create_contact`, `update_contact`, `get_contact`, `delete_contact`, `search_contacts`):
  create/update fields `firstname, lastname, email, phone, company, lifecyclestage` (select: subscriber,
  lead, marketingqualifiedlead, salesqualifiedlead, opportunity, customer, evangelist, other, or
  `token`), `lifecyclestage_token` (used when stage = `token`), `additional_properties` (YAML),
  `token_name`; update adds `contact_id`. `get_contact` takes `contact_id_or_email` (email
  auto-detected via `FILTER_VALIDATE_EMAIL`) + `properties` (comma list). `delete_contact` takes
  `contact_id` (archive). Create uses `replaceClear` for name/phone/company.
- **Company** (`create_company` … `search_companies`): create/update fields `name, domain, industry,
  phone, city, state`, `additional_properties`, `token_name`; update adds `company_id`. `get_company`
  takes `company_id_or_domain` (a value containing `.` and non-numeric is looked up by domain) +
  `properties`. `delete_company` takes `company_id`.
- **Deal** (`create_deal` … `search_deals`): fields `dealname, dealstage, pipeline, amount, closedate,
  associated_contact_ids, associated_company_ids` (comma-separated id lists), `additional_properties`,
  `token_name`; update adds `deal_id`. `get_deal` takes `deal_id, properties, include_associations`
  (boolean). `delete_deal` takes `deal_id`.
- **Lead** (`create_lead` … `search_leads`): fields `lead_name, lead_type, lead_label,
  associated_contact_id, associated_company_ids`, `additional_properties`, `token_name`; update adds
  `lead_id`. `get_lead` takes `lead_id, properties, include_associations`. `delete_lead` takes `lead_id`.
- **Ticket** (`create_ticket` … `search_tickets`): fields `subject, content, pipeline, stage, priority`
  (LOW/MEDIUM/HIGH), `associated_contact_ids, associated_company_ids, associated_deal_ids`,
  `additional_properties`, `token_name`; update adds `ticket_id`. `get_ticket` takes `ticket_id,
  properties, include_associations`. `delete_ticket` takes `ticket_id`.
- **Note** (`create_note` … `search_notes`): fields `content, additional_properties,
  associated_contact_ids, associated_company_ids, associated_deal_ids, token_name`; update adds
  `note_id`. `get_note` takes `note_id, properties`. `delete_note` takes `note_id`. Service adds
  `hs_timestamp` automatically if absent.
- **Task** (`create_task` … `search_tasks`): fields `subject, body, due_date, priority`
  (NONE/LOW/MEDIUM/HIGH), `task_type` (TODO/EMAIL/CALL), `owner_id, additional_properties,
  associated_contact_ids, associated_company_ids, associated_deal_ids, token_name`; update adds
  `task_id`. `get_task` takes `task_id, properties`. `delete_task` takes `task_id`.

Search actions (`search_*`) all share config `filters` (YAML filter groups), `sort_by`, `limit`,
`token_name`. Filter entries: `{propertyName, operator, value|values|highValue}`; operators EQ, NEQ,
LT/LTE/GT/GTE, CONTAINS_TOKEN, HAS_PROPERTY, NOT_HAS_PROPERTY, IN, NOT_IN. Example subclass
`SearchContacts::performSearch()` → `hubspotService->searchContacts()`.

## Associations & pipelines (5 actions)

- `associate_objects` (`AssociateObjects`) — config `from_object_type, from_object_id,
  to_object_type, to_object_id` (all required); → `HubSpotService::associateObjects()` (v4 API).
- `disassociate_objects` (`DisassociateObjects`) — same fields; → `disassociateObjects()`.
- `get_associations` (`GetAssociations`) — config `object_type, object_id, to_object_type, token_name`;
  → `getAssociations()` returns array of related ids.
- `list_pipelines` (`ListPipelines`) — config `object_type` (select: deals/tickets/leads/appointments/
  courses/listings/orders/services), `object_type_custom` (overrides the select if set), `token_name`;
  → `listPipelines()` returns pipelines with `id/label/displayOrder/stages[]`.
- `get_pipeline` (`GetPipeline`) — config `object_type, object_type_custom, pipeline_id, token_name`;
  → `getPipeline()`.

Object type strings accepted by association/pipeline actions: `contact, company, deal, lead, ticket,
note, task` (associations) and object plural for pipelines. Type ids are resolved in
`HubSpotService::getAssociationTypeId()`.
