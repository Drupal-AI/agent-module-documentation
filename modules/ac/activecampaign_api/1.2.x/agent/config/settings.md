<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Credentials & configuration

## Install / enable

`drush en activecampaign_api`. No library or non-core module dependency (`composer.json` requires
only `ext-json`). Enabling creates the `activecampaign_api_account` config entity type; there are no
`config/install/*` defaults, so no account exists until you add one.

## The account config entity

`activecampaign_api_account` is a `ConfigEntityType` defined in
`src/Entity/ActivecampaignApiApiAccount.php` (interface `ActivecampaignApiAccountInterface`). You may
create **multiple** accounts. `config_export` (and the schema in
`config/schema/activecampaign_api.schema.yml`) persist these keys:

| Key | Getter | Purpose |
|---|---|---|
| `id`, `label` | `id()`, `label()` | machine name + human label |
| `base_url` | `getBaseUrl()` | ActiveCampaign API base URL, e.g. `https://<account>.api-us1.com/api/3` |
| `api_token` | `getApiToken()` | API token, sent as the `Api-Token` request header |
| `event_tracking_base_url` | `getEventTrackingBaseUrl()` | event-tracking endpoint URL |
| `event_tracking_key` | `getEventTrackingKey()` | event-tracking key (sent in query string) |
| `event_tracking_actid` | `getEventTrackingActId()` | event-tracking account id |
| `endpoint_create_update_delete_error_reporting_webhook_url` | `getEndpointCreateUpdateDeleteErrorReportingWebhookUrl()` | optional external webhook that failed create/update/delete calls are POSTed to |

All keys are typed `string` in schema.

## Routes & permission

All routes (`activecampaign_api.routing.yml`) require the single permission
`manage activecampaign_api settings` (`activecampaign_api.permissions.yml`), which is also the
entity's `admin_permission`; entity edit/delete additionally go through
`ActivecampaignApiAccountAccessControlHandler`.

- `entity.activecampaign_api_account.collection` — `/admin/config/services/activecampaign-api/account`
  (list builder `ActivecampaignApiAccountListBuilder`). Menu link under
  *Configuration → Web services* (`links.menu.yml`).
- `activecampaign_api_account.form_add` / `.edit_form` / `.delete_form` — add/edit/delete an account
  via `Form\ActivecampaignApiAccountForm` (delete uses core `EntityDeleteForm`).
- `activecampaign_api.test` — `/…/test`, `Form\TestForm`: pick an account, type a raw `resource`
  name + `id`, and it runs `Endpoint::get()` and dumps the result (`print_r` into an escaped
  `t()` placeholder — no XSS). Selections are remembered in `state`.
- `activecampaign_api.list_fields` — `/…/list-fields`, `Form\ListFieldsForm`: lists all custom
  fields for the chosen account (id / title / typed class).

The account form (`ActivecampaignApiAccountForm::form()`) renders `base_url` and the webhook URL as
`#type => url`, and `api_token`, `event_tracking_key`, `event_tracking_actid` as plain
`#type => textfield`. On save it redirects to the collection and logs a notice with the label.

## Upgrade path

`activecampaign_api_update_8801()` (`.install`) migrates a legacy single `activecampaign_api.config`
object (`base_url`, `api_token`, event-tracking + webhook keys) into a new
`activecampaign_api_account` entity keyed by the host of the base URL, then deletes the old config
object. It no-ops if either `base_url` or `api_token` is empty.

## Selecting an account in code

```php
$account = \Drupal::entityTypeManager()
  ->getStorage('activecampaign_api_account')
  ->load('my_account_id');
/** @var \Drupal\activecampaign_api\Service\EndpointFactoryInterface $factory */
$factory = \Drupal::service('activecampaign_api.endpoint_factory');
$factory->setActivecampaignApiAccount($account);
// $factory->isConfigured() is TRUE only when base_url AND api_token are set.
```

See [../api/client.md](../api/client.md) for what to do with the factory.
