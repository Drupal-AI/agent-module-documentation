<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configuration, routes & Drush

## Install & enable

```bash
composer require drupal/mailchimp_ecommerce   # pulls mailchimp/marketing ^3.0.78
drush en mailchimp_ecommerce -y
```

Requires Drupal Commerce (`commerce`, `commerce_cart`, `commerce_checkout`, `commerce_order`,
`commerce_price`, `commerce_product`) plus `address`, `profile`, `state_machine`, and a Mailchimp
account/API key. `commerce_promotion` is optional (only its events are used, and only if present).
This branch does **not** require the contrib `mailchimp` module — it uses the first-party
`mailchimp/marketing` library. `hook_requirements` (`mailchimp_ecommerce.install`) marks the site
status as **error** until `mailchimp_ecommerce.settings:api_key` is set.

## Permission & routes

One permission, `administer mailchimp ecommerce` (`restrict access: true`,
`mailchimp_ecommerce.permissions.yml`), gates **all** routes (`mailchimp_ecommerce.routing.yml`).
Every route is an admin `_form` under `admin/config/services/mailchimp-ecommerce`:

| Route id | Path suffix | Form class |
|---|---|---|
| `mailchimp_ecommerce.store_settings` | (base) | `Form\AdminSettingsForm` |
| `mailchimp_ecommerce.product_property_map` | `/product-property-map` | `Form\ProductPropertyMapForm` |
| `mailchimp_ecommerce.order_workflow_map` | `/order-workflow-map` | `Form\OrderWorkflowMapForm` |
| `mailchimp_ecommerce.product_sync` | `/product-sync` | `Form\ProductSyncForm` |
| `mailchimp_ecommerce.order_sync` | `/order-sync` | `Form\OrderSyncForm` |
| `mailchimp_ecommerce.promo_sync` | `/promo-sync` | `Form\PromoSyncForm` |
| `mailchimp_ecommerce.store_create` | `/store-create` | `Form\StoreCreateForm` |
| `mailchimp_ecommerce.store_update` | `/store-update` | `Form\StoreUpdateForm` |
| `mailchimp_ecommerce.store_delete` | `/store-delete` | `Form\StoreDeleteForm` |

Menu link `mailchimp_ecommerce.store_settings` sits under `system.admin_config_services`
(*Configuration → Web services → Mailchimp E-Commerce*). `links.task.yml` adds Store Settings,
Product Property Map and Order Workflow Map local tabs. `configure` route =
`mailchimp_ecommerce.store_settings`.

## Config objects & schema

Schema: `config/schema/mailchimp_ecommerce.schema.yml`. Install defaults: `config/install/`.

### `mailchimp_ecommerce.settings`
- `api_key` (string) — Mailchimp API key. Server/datacenter is derived from the suffix after `-`
  (`MailchimpMarketingApiClient::__construct()` does `explode("-", $apikey)[1]`).
- `store_id` (string) — the selected Mailchimp E-Commerce store id.
- `list_id` (string) — audience id; auto-filled from the store on save.
- `double_opt_in` (bool) — require confirmation before adding subscribers.
- `batch_limit` (string) — entities per batch operation (form offers 1…10000; Mailchimp suggests
  ≤5000; sync batch code defaults to 100 when empty).

### `mailchimp_ecommerce.product_property_map`
`commerce_product.<bundle>.<mailchimp_property>` → `{use_variation: bool, drupal_field: string}`;
`commerce_product_variation.<bundle>.<mailchimp_property>` → field-name string. Read back by
`ApiHandlerBase::getPropertyMapping()` / `getMappedPropertyValue()`. Mailchimp product properties
mapped: `description`, `image_url`, and (variation only) `inventory_quantity` (a value of
`non_inventory` returns the sentinel `99999`, since Mailchimp requires a quantity).

### `mailchimp_ecommerce.order_workflow_map`
`order_types.<order_type>.{paid|pending|refunded|cancelled|shipped}` → a Commerce transition id.
`OrderEventSubscriber::orderUpdate()` does `array_search($transition, $map['order_types'][$bundle])`
to turn a fired transition into a Mailchimp state, then queues it.

## Settings form (`Form\AdminSettingsForm`)

`ConfigFormBase` editing `mailchimp_ecommerce.settings`. Injects `mailchimp_ecommerce.store_handler`,
`entity_field.manager`, `module_handler`, logger. Flow:

- `api_key` textfield with an AJAX `change` callback (`ajaxApiKeyChange()`): validates the key
  (`StoreHandler::isApiKeyValid()` → Mailchimp `ping`), then loads stores and populates the
  store `select`.
- `validateForm()` rejects an empty or invalid key.
- Once a valid key is present the form also shows: store `select`, `double_opt_in` checkbox,
  `batch_limit` select, links to store create/update/delete, and (once a `store_id` is chosen)
  links to the product/order/promo sync forms.
- `submitForm()` saves the cleaned values, then loads the chosen store via
  `StoreHandler::getStore()` and stores its `list_id`.

## Store forms

`StoreCreateForm`/`StoreUpdateForm`/`StoreDeleteForm` (extending `StoreFormBase`) call
`StoreHandler::addStore()/updateStore()/deleteStore()` / `getStore()` / `getLists()`. Create is
pre-populated from the default Commerce store; `StoreHandler::enableSyncing()/disableSyncing()`
toggle the Mailchimp store's `is_syncing` flag.

## Batch sync (back-fill) forms

`ProductSyncForm`, `OrderSyncForm`, `PromoSyncForm` are `FormBase` forms that build a Drupal
**batch** over all matching Commerce entities (`entityQuery(...)->accessCheck(FALSE)`) and, in
`batch_limit`-sized slices, call the handler `sync*()` per id. Example: `ProductSyncForm::syncProducts()`
slices `commerce_product` ids and calls `product_handler->syncProduct($id)`; a delete variant calls
`deleteProduct()`. Use these once after connecting a store to seed the existing catalog/history.

## Drush

`Commands\MailchimpEcommerceCommands` (tagged `drush.command`): `mailchimp-ecommerce:store`
(aliases `mcec:store`, `mailchimp-ecommerce-store`, `mcecstore`), optional `store_id` arg. Prints
each store's id, name, audience (`list_id`) and platform via `store_handler`. Read-only.

## Install/uninstall notes

`mailchimp_ecommerce_schema()` still declares a legacy `mailchimp_ecommerce_customer` table, but
`mailchimp_ecommerce_update_9001()` drops it — the running module keeps no local sync-state table;
de-duplication works off the `queue` table instead (see [sync/pipeline.md](../sync/pipeline.md)).
