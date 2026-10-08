<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveCampaign API (activecampaign_api) — agent index

A typed PHP client for the **ActiveCampaign v3 REST API**, packaged as a Drupal module. No end-user
UI beyond an admin credentials manager + diagnostic forms; primarily a dependency of
`contact_activecampaign`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.2.0.
Only non-core dependency: `ext-json`.

- **Credentials, the account config entity, routes, permission, admin forms** →
  [config/settings.md](config/settings.md)
- **Endpoint factory, endpoints, resources, event tracking, hooks, helper functions** →
  [api/client.md](api/client.md)

## What it provides (from source)

- **One config entity type** `activecampaign_api_account` (`src/Entity/ActivecampaignApiApiAccount.php`),
  holding `base_url`, `api_token`, `event_tracking_base_url`/`_key`/`_actid`, and an
  `endpoint_create_update_delete_error_reporting_webhook_url`. Managed at
  `/admin/config/services/activecampaign-api/account`.
- **One permission**: `manage activecampaign_api settings` (also the entity `admin_permission`).
- **Two services** (`activecampaign_api.services.yml`):
  `activecampaign_api.endpoint_factory` (`Service\EndpointFactory`) and
  `activecampaign_api.event_tracking` (`Service\EventTrackingService`).
- **Endpoint classes** (`src/Endpoint/*`, all extend `Endpoint`): `Contacts`, `ContactLists`,
  `ContactTags`, `Tags`, `Fields`, `FieldValues`, `FieldRels`, `Accounts`, `AccountContacts`,
  `AccountCustomFieldMeta`, `AccountCustomFieldData`.
- **Resource value objects** (`src/ApiResource/*`, extend abstract `ApiResource`): `Contact`,
  `ContactList`, `ContactListMembership`, `ContactTag`, `Tag`, `Account`, `AccountContact`,
  `Field` (abstract; typed subclasses Text/Textarea/Date/Datetime/Dropdown/Listbox/Radio/Checkbox/Hidden/Number),
  `FieldValue`, `FieldRel`, `AccountCustomFieldValue`, `AccountCustomFieldMeta`.
- **Three admin routes** (`activecampaign_api.routing.yml`): the account collection/add/edit/delete
  entity routes, plus `activecampaign_api.test` (Test form) and `activecampaign_api.list_fields`
  (List fields form) — all require `manage activecampaign_api settings`.
- **Two helper functions** in `.module`: `activecampaign_api_subscribe_contact_to_list()` and
  `activecampaign_api_get_account_by_contact()`.
- **Three alter hooks** (`activecampaign_api.api.php`):
  `hook_activecampaign_api_endpoint_createresource_alter`, `_updateresource_alter`,
  `_report_error_to_webhook_alter`.
- **Submodule**: `activecampaign_api_raven_context` (adds Sentry context; depends on `raven`) —
  documented at `modules/activecampaign_api_raven_context/1.2.x/`.
- **Config schema** in `config/schema/activecampaign_api.schema.yml`. No Drush, no plugin types,
  no theme, no blocks.

## Mechanism in one paragraph

Pick an account entity, hand it to `EndpointFactory::setActivecampaignApiAccount()`, then
`->get(Contacts::class)` etc. Each `Endpoint` builds its URL as `base_url . '/' . resource`, sends
the account's token as an `Api-Token` **header** (never in the URL) over Drupal's `http_client`
(Guzzle, TLS verification at secure default), and hydrates JSON into `ApiResource` objects via
`createFromJsonResponse()`. `update_8801` migrated the legacy `activecampaign_api.config` object into
the per-account entity.
