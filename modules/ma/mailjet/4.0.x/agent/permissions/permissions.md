# Permissions and access checks

## Declared permissions

| Permission | Provided by | Definition |
|---|---|---|
| `administer mailjet configuration` | base `mailjet` (`mailjet.permissions.yml`) | title "Administer Mailjet", `restrict access: true`. |
| `administer subscriptions` | `mailjet_subscription` (`mailjet_subscription.permissions.yml`) | Create/edit subscription forms; `admin_permission` of the `mailjet_subscription_form` config entity, and the requirement on `entity.mailjet_subscription_form.list` and `mailjet_labels_form.settings`. |

There are two stray, unused permission files whose contents are not wired to anything:
`mailjet_subscription/mailjet_subscriptione.permissions.yml` (note the extra `e`; defines
`administer  subscriptions` with a double space).

## Access checks used by routes

- **`_mailjet_access_check`** → `Drupal\mailjet\Access\MailjetConfigurationAccessCheck` (service
  `mailjet.access_check`). Grants when the current user has **`access administration pages`**, and
  flashes a "enter your Mailjet API keys" warning when credentials are not yet configured. Used by most
  base admin routes and by the submodule admin panels (`list.content`, `stats.content`,
  `campaign.content`, `trigger_examples.content`, `event.uninstall`, `campaign.uninstall`).
- **`_permission: 'access administration pages'`** → used directly by `mailjet_api.admin_settings_form`
  (the API key/secret form).
- **`_access: 'TRUE'`** → the inbound callback/confirmation routes `event.content` (`/mailjetevent`),
  `campaign.callback` (`/campaigncallback`) and `subscribe_form.settings` (`/confirmation-subscribe`).
  See [../events/webhooks.md](../events/webhooks.md).
- **Entity access** → the subscription CRUD routes use `_entity_create_access` / `_entity_access`
  against `mailjet_subscription_form`, whose access handler is
  `Drupal\mailjet_subscription\SubscriptionFormController` and whose `admin_permission` is
  `administer subscriptions`.

To grant an operator full control of the base module, assign both `access administration pages` and
`administer mailjet configuration` (and `administer subscriptions` for the sign-up forms).
