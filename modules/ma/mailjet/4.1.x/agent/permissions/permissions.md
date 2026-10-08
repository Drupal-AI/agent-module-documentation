# Permissions and access checks

## Declared permissions

| Permission | Provided by | Definition |
|---|---|---|
| `administer mailjet configuration` | base `mailjet` (`mailjet.permissions.yml`) | title "Administer Mailjet", description "Perform administration tasks for the Mailjet email service.", `restrict access: true`. |
| `administer subscriptions` | `mailjet_subscription` (`mailjet_subscription.permissions.yml`) | Create/edit subscription forms; `admin_permission` of the `mailjet_subscription_form` config entity, and the requirement on `entity.mailjet_subscription_form.list` and `mailjet_labels_form.settings`. |

There are two stray, unused permission files whose contents are not wired to anything:
`mailjet_subscription/mailjet_subscriptione.permissions.yml` (note the extra `e`; defines
`administer  subscriptions` with a double space).

## Access checks used by routes

- **`_mailjet_access_check`** → `Drupal\mailjet\Access\MailjetConfigurationAccessCheck` (service
  `mailjet.access_check`). In this release it grants when the current user holds the module's own
  **`administer mailjet configuration`** permission (`AccessResult::allowedIfHasPermission(...)`) and
  carries no side effects — the "enter your Mailjet API keys" reminder is emitted separately by
  `EventSubscriber\InitSubscriber`. Used by most base admin routes and by the submodule admin panels
  (`list.content`, `stats.content`, `campaign.content`, `trigger_examples.content`, `event.uninstall`,
  `campaign.uninstall`).
- **`_permission: 'administer mailjet configuration'`** → used directly by
  `mailjet_api.admin_settings_form` (the API key/secret form) and `mailjet_register.page`.
- **`_access: 'TRUE'`** → the inbound callback/confirmation routes `event.content` (`/mailjetevent`),
  `campaign.callback` (`/campaigncallback`) and `subscribe_form.settings` (`/confirmation-subscribe`).
  See [../events/webhooks.md](../events/webhooks.md).
- **Entity access** → the subscription CRUD routes use `_entity_create_access` / `_entity_access`
  against `mailjet_subscription_form`, whose access handler is
  `Drupal\mailjet_subscription\SubscriptionFormController` and whose `admin_permission` is
  `administer subscriptions`.

To grant an operator full control of the base module, assign `administer mailjet configuration` (and
`administer subscriptions` for the sign-up forms). Because `administer mailjet configuration` exposes
the live Mailjet API key/secret and the site mail transport, keep it to trusted administrators.
