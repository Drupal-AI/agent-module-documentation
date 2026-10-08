<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# subscription_manager — connector plugins

## Plugin type
- Annotation: `@SubscriptionManagerConnector` (`src/Annotation/SubscriptionManagerConnector.php`).
- Manager: `SubscriptionManagerConnectorManager` (service `plugin.manager.subscription_manager.connector_manager`), discovers plugins under `Plugin/SubscriptionManagerConnector/`.
- Interface: `SubscriptionManagerConnectorInterface` — implement `redirectToPortal($user_id)` and `redirectToSubscribe($user)` (return `RedirectResponse`).

## Selection / fallback
- Each Subscription entity stores its connector plugin id (`getConnectorPluginId()`).
- If the stored connector is no longer installed, the controller falls back to the `default_connector` config value (avoids `PluginNotFoundException`).
- The default connector is set on the admin form (`SubscriptionManagerAdminForm`).

## Entities
- `SubscriptionEntity` / `SubscriptionPlanEntity` (+ interfaces, list builders, access control handlers, HTML route providers, ViewsData).
- Access control handlers gate view/update/delete on the entities.

## Writing a connector
1. Create `src/Plugin/SubscriptionManagerConnector/MyProvider.php` with the annotation.
2. Implement portal/subscribe redirects to the provider's hosted pages.
3. If you expose a public post-purchase return URL keyed by `order_id`, mint/verify tokens with `subscription_manager.post_purchase_token` — never auto-login on a bare `order_id`.
