<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon SNS — settings

## Route & form

- Route `amazon_sns.settings` (`amazon_sns.routing.yml`): path
  `/admin/config/services/amazon-sns`, `_form: SnsSettingsForm`, requirement
  `_permission: 'administer site configuration'`.
- Menu link `amazon_sns_menu` (`amazon_sns.links.menu.yml`) under `system.admin_config_services`
  (*Configuration → Services*).
- `configure: amazon_sns.settings` in `amazon_sns.info.yml` links it from the module list.

## Form — `SnsSettingsForm`

File `src/Form/SnsSettingsForm.php`, extends `ConfigFormBase`. Form ID `amazon_sns_settings`,
editable config `amazon_sns.settings`. One checkbox:

- **Enable logging of all inbound SNS notifications** → `log_notifications`. Description: turn on
  to help debug SNS problems; it logs message IDs and the associated SNS topic. `submitForm()`
  saves the value to `amazon_sns.settings`.

## Config object — `amazon_sns.settings`

- Default (`config/install/amazon_sns.settings.yml`): `log_notifications: false`.
- Schema (`config/schema/amazon_sns.schema.yml`): type `config_object`, mapping
  `log_notifications` → `boolean` ("Log all inbound notifications").

## Effect

When `log_notifications` is TRUE, `SnsNotificationSubscriber::logNotification()` writes an
info-level entry to the `amazon_sns` logger channel for each `Notification`, recording
`MessageId` and `TopicArn`. When FALSE (default) no notification logging occurs; subscription
confirmations are always logged by `SnsSubscriptionConfirmationSubscriber` regardless of this
setting.

## Set it programmatically

```php
\Drupal::configFactory()
  ->getEditable('amazon_sns.settings')
  ->set('log_notifications', TRUE)
  ->save();
```
Or `drush cset amazon_sns.settings log_notifications 1`.
