<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage lists & place the subscribe block

## Admin: manage Mailgun mailing lists

- Route `mailgun_mailing_lists.admin_settings_form` →
  `/admin/config/services/mailgun/settings/mailing-lists` (a tab under the Mailgun settings page,
  menu link "Mailing Lists"). Permission: **`administer mailgun`** (from the parent module).
- The form (`MailingListsAdminForm`) lists existing Mailgun lists and has a "Create new list"
  section with fields: **List address** (email), **List name**, **Description**, **Access Level**
  (`readonly` / …). Submitting calls `mailgunClient->mailingList()->create($address, $name, $description, $access_level)`.
- Members route `mailgun_mailing_lists.list` → `.../mailing-lists/{list_address}`
  (`MailingListController::members`) shows the list's members.

All of these hit the Mailgun HTTP API and require a valid API key in the parent module
(`mailgun.settings api_key`).

## Place the subscribe block

The visitor-facing subscribe form is the Block plugin **`mailing_list_subscribe`** ("Mailing list
subscribe form"). Place it via *Structure → Block layout* or with config; its block setting
`mailing_list` holds the target list address.

```php
$theme = \Drupal::config('system.theme')->get('default');
\Drupal\block\Entity\Block::create([
  'id' => 'newsletter_subscribe',
  'plugin' => 'mailing_list_subscribe',
  'region' => 'sidebar_first',
  'theme' => $theme,
  'settings' => [
    'id' => 'mailing_list_subscribe',
    'label' => 'Subscribe',
    'label_display' => 'visible',
    'mailing_list' => 'news@mg.example.com',   // the Mailgun list address to subscribe to
  ],
  'visibility' => [],
])->save();
```

Read back the configured list:

```bash
drush cget block.block.newsletter_subscribe settings.mailing_list
```

When rendered, the block shows a single **Email** field; on submit it adds the email as a member
of the configured list (`mailingList()->member()->create(...)`). Rendering/label therefore calls
the API — but *saving* the block placement config does not.
