<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, admin routes & permissions

## Install & enable

```bash
composer require drupal/advanced_notifications   # pulls minishlink/web-push ^9.0
drush en advanced_notifications -y
```

Dependencies: core `rest`, `serialization`, `user`. PHP 8.1 with `ext-mbstring`, `ext-curl`,
`ext-openssl`. The browser Push API requires the site be served over **HTTPS**. `hook_requirements`
(runtime) raises an error until a VAPID public key is set.

## Admin routes (`advanced_notifications.routing.yml`)

All under **Configuration → Web services → Advanced Notifications**
(`/admin/config/services/advanced-notifications`, menu links in `*.links.menu.yml`):

| Route | Path | Permission | Form |
|---|---|---|---|
| `advanced_notifications.parent` | `/admin/config/services/advanced-notifications` | `administer web push settings` | menu block |
| `advanced_notifications.settings` (**configure**) | `…/default-settings` | `administer web push settings` | `Form\SettingsForm` |
| `advanced_notifications.vapid` | `…/vapid` | `administer web push sensitive settings` | `Form\VAPIDForm` |
| `advanced_notifications.security` | `…/security` | `administer web push sensitive settings` | `Form\SecurityForm` |
| `entity.web_push_subscription.collection` | `/admin/content/advanced-notifications/subscriptions` | `access list subscriptions` | list |
| `advanced_notifications.campaign_report` | `/admin/content/advanced-notifications/report` | `administer web push campaigns` | `CampaignReportController::report` |

Campaign CRUD routes (`/admin/content/advanced-notifications/notifications…`) come from the
`Campaign` entity's `AdminHtmlRouteProvider` and are gated by its `admin_permission`
(`administer web push campaigns`). The `…/web-push/…` paths are legacy aliases that 301-redirect
via `AdvancedNotificationsRedirectController` (same permissions).

## Permissions (`advanced_notifications.permissions.yml`)

- `access list subscriptions` — view the subscription list.
- `administer web push subscriptions` *(restricted)* — entity `admin_permission` for subscriptions
  (delete). Also gates the subscribe/bell subscription JS attach implicitly via the REST perm below.
- `administer web push settings` — default settings + parent menu.
- `administer web push sensitive settings` *(restricted)* — VAPID keys and flood/security settings.
- `administer web push campaigns` *(restricted)* — create/schedule/send/report campaigns.
- `restful post web_push_subscription` — core REST permission (from the REST resource) letting a
  role register a subscription. **No role is granted this on install** (update 10207 documents that
  it stays admin-controlled); grant it to the roles that may subscribe (often `authenticated`, and
  `anonymous` only if you accept anonymous subscriptions).

## Config objects & schema

Schema: `config/schema/advanced_notifications.schema.yml`. Install defaults in `config/install/`.

**`advanced_notifications.settings`** (`SettingsForm::$configId`) — default push + prompt options:
`ttl` (int, default 2419200 = 28 days), `urgency` (`normal`), `topic` (''), `batchSize` (1000),
`defaultNotificationIcon` (''), `displayBlock` (bool — whether the subscribe block renders),
`enableAutoPrompt` (bool), `autoPromptDelay` (ms, 3000), `autoPromptTrigger` (`page_load`),
`autoPromptPaths` (Drupal path patterns; empty = all), `debugMode` (bool),
`enableManualPrePrompt` (bool, default 1), `manualPrePromptMessage` (string),
`notificationDisplayMode` (`days`|`count`), `notificationDisplayDays` (7),
`notificationDisplayCount` (10). The last three govern what the bell shows.

**`advanced_notifications.vapid`** (`VAPIDForm::$configId`) — `publicKey`, `privateKey`. The form's
"Generate keys" uses `AuthenticationHelper::genrateKeys()` → `Minishlink\WebPush\VAPID::createVapidKeys()`.
Only the **public** key is exposed to the page (see the delivery doc); the private key is used
server-side by `AuthenticationHelper::getAuth()` when signing pushes.

**`advanced_notifications.security`** (`SecurityForm::$configId`) — flood control on the subscribe
endpoint: `enable` (bool), `threshold` (int, default 2), `window` (seconds, default 3600).

## Post-install checklist

1. `advanced_notifications.vapid` → generate/save VAPID keys (required, else a runtime requirement
   error).
2. `advanced_notifications.settings` → set default icon, prompt behaviour, bell display window.
3. `advanced_notifications.security` → optionally enable flood control.
4. People → Permissions → grant `restful post web_push_subscription` to trusted roles.
5. Place the **Advanced Notifications block** (subscribe UI) and/or the **notification bell** block.
6. Create campaigns at `/admin/content/advanced-notifications/notifications/add`; send now or
   schedule (cron delivers scheduled ones).
