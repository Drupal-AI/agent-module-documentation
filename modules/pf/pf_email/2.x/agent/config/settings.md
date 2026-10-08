<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push Framework Email — channel, mail, and settings

## Install / enable
`composer require drupal/pf_email` then enable `pf_email` (pulls in `push_framework ^2.3`).
No permissions, services, or Drush commands are added.

## The channel plugin
`src/Plugin/PushFrameworkChannel/Email.php` — annotation `@ChannelPlugin(id = "email",
label = "Email", description = "Provides the email channel plugin.")`, extends
`Drupal\push_framework\ChannelBase`.

- `create()` calls the parent then injects `plugin.manager.mail` into `$this->mailManager`.
- `getConfigName(): 'pf_email.settings'` — tells the framework which config object holds this
  channel's `active` / `use_default_settings` state.
- `applicable(UserInterface $user): bool` — returns `$this->active` (the channel is applicable
  to every user whenever it is switched on; no per-user opt-in logic here).
- `send(UserInterface $user, ContentEntityInterface $entity, array $content, int $attempt): string`
  - Resolves the language: `$user->getPreferredLangcode()`, or `array_keys($content)[0]` if that
    language is missing from `$content`.
  - `mailManager->mail('pf_email', 'notification', $user->getEmail(),
    $user->getPreferredLangcode(), ['subject' => …, 'body' => …, 'is html' => …])`.
  - Returns `ChannelBase::RESULT_STATUS_SUCCESS` when `$message['result']` is truthy, else
    `RESULT_STATUS_FAILED` (the framework uses this for retry/attempt accounting).

Note the recipient is `$user->getEmail()` — the framework-chosen user's registered address; the
module never accepts an address from a request. Subject/body come from `$content`, which the
Push Framework renders from its notification templates.

## hook_mail — message assembly
`pf_email_mail(string $key, array &$message, array $params)` in `pf_email.module`, key
`notification`:
- `$message['subject'] = $params['subject']`.
- Appends `$params['body']` to `$message['body']`.
- If `$params['is html']`: sets `$message['headers']['Content-Type'] =
  'text/html; charset=UTF-8; format=flowed'` and wraps the body with
  `Markup::create('<html …><head><base href="<site root>" target="_blank"><meta charset="utf-8">
  </head><body>')` … `</body></html>`. The `<base href>` is built from
  `Url::fromUri('internal:/', ['absolute' => TRUE, 'https' => TRUE])` (empty string if that
  throws `EntityMalformedException`), so relative links in the HTML body resolve to the site.
- Plain-text mode adds no wrapper.

## Settings form
Route `pf_email.settings` → `/admin/config/system/push_framework/email`, requirement
`_permission: 'administer site configuration'` (`pf_email.routing.yml`). Exposed as a menu link
(`pf_email.links.menu.yml`, parent `push_framework.settings`) and a local task
(`pf_email.links.task.yml`; note its map key is the harmless typo `pg_email.settings`).

`src/Form/Settings.php` extends `Drupal\push_framework\Form\Settings` and overrides only:
- `getFormId(): 'pf_email_settings'`.
- `getEditableConfigNames(): ['pf_email.settings']`.

All actual form fields are inherited from the framework's channel-settings form, so the exposed
options (e.g. per-notification default behavior) are defined by `push_framework`, not here.

## Config object
`config/install/pf_email.settings.yml` ships defaults:
```yaml
active: 1
use_default_settings: 1
```
`active` gates `applicable()` (whether the email channel fires). There is **no**
`config/schema/` directory in this module — the keys validate against the base channel schema
defined by `push_framework`.

## Operating it
1. Configure a working mail transport for the site (core mail, SMTP, Symfony Mailer, …); this
   module only formats messages and calls the mail manager.
2. Enable `pf_email`; the `email` channel appears in the framework's channel list.
3. At `/admin/config/system/push_framework/email` confirm the channel is active.
4. The framework invokes `Email::send()` per recipient when a notification is dispatched;
   delivery success/failure is reported back through the return value.
