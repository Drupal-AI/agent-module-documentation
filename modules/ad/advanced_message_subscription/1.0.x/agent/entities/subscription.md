<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, routes, permissions & access

## Install

```bash
composer require drupal/advanced_message_subscription
drush en advanced_message_subscription -y
```

Pulls in `message` and `token`. To actually deliver notifications, also enable `message_notify`.
Configure at *Structure → Subscription types* (`entity.adv_message_subscription_type.collection`).

## Two entity types

### `adv_message_subscription_type` — config (bundle) entity
`src/Entity/AdvancedMessageSubscriptionType.php`, `#[ConfigEntityType]`, `config_prefix:
adv_message_subscription_type`, `bundle_of: advanced_message_subscription`. Exported keys
(`config_export`): `id`, `label`, `uuid`, `name_pattern`, `add_link_text`, `manage_link_text`,
`notify`, `plugin`, `configuration`. Schema in
`config/schema/advanced_message_subscription.entity_type.schema.yml` (the `configuration` sub-mapping
is keyed by the selected plugin id, e.g. `advanced_message_subscription.plugin.entity`).

- `getPlugin()` lazily builds a `DefaultSingleLazyPluginCollection` from the `plugin` id +
  `configuration`; `notify()` returns the notify flag; `getNamePattern()`/`getAddLinkText()`/
  `getManageLinkText()` expose the string settings.
- `createAccess(?DataProvider)` delegates to the plugin's `createAccess()` (forbidden if no plugin),
  adding the `user` cache context. Form: `Form/AdvancedMessageSubscriptionTypeForm.php` (label,
  machine name, token `name_pattern`, add/manage link text, `notify`, plugin select + AJAX plugin
  config). Storage `AdvancedMessageSubscriptionTypeStorage::loadByPluginId()` filters types by plugin.
- Routes: `AdminHtmlRouteProvider` at `/admin/structure/adv_message_subscription_types` (add / manage
  /{type} / delete). All gated by `admin_permission` = `administer advanced_message_subscription types`.

### `advanced_message_subscription` — content entity
`src/Entity/AdvancedMessageSubscription.php`, `#[ContentEntityType]`, extends
`EditorialContentEntityBase` (revisionable + publishable), `EntityOwnerTrait`. Base fields
(`baseFieldDefinitions()`): `name` (string, required, the label), `status` (boolean, default TRUE),
`uid` (owner, default = current user), `created`, `changed`. `base_table: advanced_message_subscription`,
`revision_table: adv_message_subscription_rev`, `show_revision_ui: TRUE`. `field_ui_base_route:
entity.adv_message_subscription_type.edit_form` — configurable fields are added per subscription type.
`preSave()` sets the owner to the current user if unset, then calls `postCreate()` →
`$type->getPlugin()->applySubscriptionData($this)` (the plugin populates the reference field).

## Generated routes (no routing.yml)

From the entity `links` + `handlers.route_provider.html` =
`Routing/AdvancedMessageSubscriptionHtmlRouteProvider` (extends `AdminHtmlRouteProvider`):

| Route / link | Path | Access requirement |
|---|---|---|
| collection | `/admin/content/advanced-message-subscription` | `_permission: administer advanced_message_subscription types` |
| add-page | `/subscription/add` | `_entity_create_any_access` |
| add-form | `/subscription/add/{adv_message_subscription_type}/{data}` | `_entity_create_access` **and** `_advanced_message_subscription_add` |
| canonical | `/subscription/{id}` | remapped to the **edit form** → `advanced_message_subscription.update` |
| edit-form | `/subscription/{id}` | `_entity_access: advanced_message_subscription.update` |
| delete-form | `/subscription/{id}/delete` | `_entity_access: advanced_message_subscription.delete` |
| delete-multiple / revision routes | under the above | entity access + admin |

The route provider overrides two things: `getAddFormRoute()` appends a `/{data}` param (default `''`),
and adds requirement `_advanced_message_subscription_add` (the custom access check); `getCanonicalRoute()`
returns the **edit-form** route, so the "view" link of a subscription is actually its edit form.

## Permissions & access handlers

Two permissions (`advanced_message_subscription.permissions.yml`):
`administer advanced_message_subscription types` (`restrict access: true`) and
`manage own advanced_message_subscriptions`.

- **Subscription create** — `AdvancedMessageSubscriptionAccessControlHandler::createAccess()`: allowed
  if the account has `manage own advanced_message_subscriptions` (OR admin). This backs the route's
  `_entity_create_access`.
- **Subscription view / update / delete** — `AdvancedMessageSubscriptionAccessControlHandler::access()`:
  requires `manage own advanced_message_subscriptions` **AND** `entity.getOwnerId() == account.id()`
  (owner-only), OR the admin permission via the parent handler. So a user manages only their own
  subscriptions.
- **Add-route custom check** — `Access/AdvancedMessageSubscriptionAddAccessChecker` (tag
  `applies_to: _advanced_message_subscription_add`): forbids unless the route's
  `adv_message_subscription_type` is a real type with a plugin, then returns
  `$type->createAccess(new DataProvider($routeMatch))` (the plugin also validates the `{data}` param /
  target-entity access). This is ANDed with `_entity_create_access`, so the permission gate still applies.
- **Type view** — `AdvancedMessageSubscriptionTypeAccessControlHandler::checkAccess()` grants `view`
  to holders of `manage own advanced_message_subscriptions` (needed to render the add form); other ops
  fall through to the admin permission.

List builder `AdvancedMessageSubscriptionListBuilder` renders the admin collection (id, name, status,
user, created, changed). Two `system.action` config items ship in `config/install/` for bulk
save/delete of subscriptions.
