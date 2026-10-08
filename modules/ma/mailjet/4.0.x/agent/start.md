<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailjet (mailjet) — agent index

Integrates Drupal with the **Mailjet** email platform. The base module registers a `Mail` plugin
(`mailjet_mail`) that sends Drupal's outbound mail through Mailjet's SMTP relay (via the bundled
PHPMailer), and talks to the Mailjet **REST API v3** (composer library `mailjet/mailjet-apiv3-php`)
to store the API key/secret, sync Drupal users into a Mailjet contact list, manage contact
properties, and drive several admin panels that embed the Mailjet web UI. `hook_user_insert/update/
delete` push account changes to Mailjet; a cron **queue worker** (`sync_mailjet_contact`) does the
same work asynchronously. Configuration lives under `/admin/config/system/mailjet` (route
`mailjet_settings.settings_form`), with the API credentials on the `…/api` tab
(`mailjet_api.admin_settings_form`).

The project ships **seven submodules** that add the marketing/e-commerce surface — enable only what
you need, as the whole project turns the site into a marketing console rather than a bare mail
transport.

| Submodule (machine name) | Purpose / key surface |
|---|---|
| `mailjet_list` | Read-only admin panel embedding Mailjet **contact lists** (route `list.content`, `/admin/config/system/mailjet/mailjet-panel/list`). |
| `mailjet_subscription` | Front-end **newsletter sign-up** forms: config entity `mailjet_subscription_form`, a derivative block `mailjet_signup_subscribe_block:*`, double-opt-in confirmation flow. Permission `administer subscriptions`. |
| `mailjet_campaign` | **Campaign** records: content entity `campaign_entity`, admin panel `campaign.content`, callback route `campaign.callback` (`/campaigncallback`). Depends on `commerce_order`. |
| `mailjet_event` | Receives Mailjet **event callbacks** (open/click/bounce/spam/blocked/unsub): route `event.content` (`/mailjetevent`), content entity `event_entity`, and Rules **reaction events** (`bounce_event`, `blocked_event`, `spam_event`, `click_mailjet_event`, `unsubscribe_event`, `open_event`, `typo_event`). |
| `mailjet_stats` | Read-only **statistics** dashboard panel (route `stats.content`); Commerce order-complete subscriber that tags orders with a campaign. |
| `mailjet_commerce` | **Drupal Commerce** glue: adds `field_mailjet_campaign_id` / `field_mailjet_campaign_name` to `commerce_order`, order-complete subscriber. Depends on `commerce_order` + `state_machine`. |
| `mailjet_trigger_examples` | Example **triggered-email** Views + Message templates (abandoned cart, purchase anniversary, …). Route `trigger_examples.content`. Depends on `message` + `token`. |

- Depends on (base): nothing (core-only). Libraries via composer: `mailjet/mailjet-apiv3-php ^1.5`,
  `phpmailer/phpmailer ^6.0.7`, `guzzlehttp/guzzle ^7.0`. PHPMailer must be installed (a
  `hook_requirements` install check enforces it).
- Core: `^9 || ^10 || ^11`. Package: `Mailjet`. Configure route (info.yml): `mailjet.settings`.
- Provides permissions (`administer mailjet configuration`, plus `administer subscriptions` in the
  subscription submodule). Provides config schema. No Drush commands. No custom plugin *types*
  (it provides a `Mail` plugin, a `Block` + derivative, and a `QueueWorker`).

## What you'd do → where

- **Connect the site to Mailjet (API key/secret), turn on the Mailjet mail transport, wire event
  tracking** → [configure/settings.md](configure/settings.md)
- **Understand the config keys, permissions and access checks** →
  [configure/settings.md](configure/settings.md) and [permissions/permissions.md](permissions/permissions.md)
- **Call the Mailjet API from code / sync contacts / send mail through the plugin / use the queue
  worker** → [api/services.md](api/services.md)
- **Understand the inbound callback endpoints and the Rules event integration** →
  [events/webhooks.md](events/webhooks.md)

## Key facts (real machine names)

- **Settings routes (base):** `mailjet_settings.settings_form` (`/admin/config/system/mailjet`),
  `mailjet_api.admin_settings_form` (`…/api`), `trusted_domains.custom_form` (`…/domains`),
  `save_domain.settings` (`…/domains/add-domain`), `mailjet_test_email.settings` (`…/test`),
  `mailjet_other_settings.page` (`…/mailjet-panel`), `mailjet_regester.page` (`…/register`),
  `mailjet_my_profile.page` (`…/my-profle`), `mailjet_upgrade.page` (`…/upgrade`),
  `subscribe_form.settings` (`/confirmation-subscribe`).
- **Forms:** `MailjetSettingsForm` (`mailjet_settings_form`), `MailjetApiForm` (`mailjet_api_form`),
  `DomainSettingsForm`, `DomainSaveForm`, `MailjetTestEmailForm`, `SubsribeEmailForm`
  (`subscribe_admin_form`).
- **Services:** `mailjet.factory` (`MailjetFactory`), `mailjet.handler` (`MailjetHandler` impl of
  `MailjetHandlerInterface`), `mailjet.properties_sync` (`MailjetPropertiesSync`),
  `mailjet.access_check` (access check `_mailjet_access_check`), `mailjet.breadcrumb`,
  `init_subscriber`.
- **Static API wrapper:** `Drupal\mailjet\MailjetApi` (e.g. `getApiClient()`, `syncMailjetContact()`,
  `getMailjetContactLists()`, `createApiToken()`).
- **Mail plugin:** `mailjet_mail` (`Plugin\Mail\MailjetMail`). **Queue worker:** `sync_mailjet_contact`
  (`Plugin\QueueWorker\MailjetSyncContactQueueWorker`, cron time 60s).
- **Config object:** `mailjet.settings` (keys `mailjet_username`, `mailjet_password`, `mailjet_active`,
  `mailjet_mail`, `mail_headers_allow_html_mailjet`, `apitoken`, `mailjet_title`). Install toggles
  `system.mail:interface.default` to `mailjet_mail`.
- **Permissions:** `administer mailjet configuration` (base), `administer subscriptions`
  (`mailjet_subscription`).
- **Entities:** `event_entity` (base_table `mailjet_event`), `campaign_entity`,
  `mailjet_subscription_form` (config entity).
- **Hooks (base `.module`):** `hook_mail` (`test_mail`, `activation_mail`), `hook_user_insert/update/
  delete` (contact sync), `hook_theme` + `hook_theme_registry_alter` (local-actions block override),
  `hook_menu_local_actions_alter`, `hook_preprocess_block`.
