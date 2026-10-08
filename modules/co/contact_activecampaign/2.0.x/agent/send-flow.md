<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact ActiveCampaign — submit → queue → send flow

Covers `contact_activecampaign.module`, `Plugin/QueueWorker/MessageQueueWorker.php`, and
`Service/ContactFormManager::sendToActiveCampaign()`.

## 1. Capture (synchronous, on form submit)

`contact_activecampaign_entity_insert()` fires on every entity insert; it returns immediately unless
the entity is a `\Drupal\contact\Entity\Message` (a core Contact submission). For each configured
`activecampaign_api_account` config entity, it calls `ContactFormManager::isEnabled($form, $account)`
and, when enabled, pushes an item onto the **`contact_activecampaign_message`** queue holding
`{contact_message_id, activecampaign_api_account_id}`. Nothing is sent to ActiveCampaign during the
web request — only queued. A submission can be queued once per enabled account.

## 2. Drain (asynchronous, on cron)

`MessageQueueWorker` (`@QueueWorker id="contact_activecampaign_message"`, `cron time = 30`s) loads the
`contact_message` and the `activecampaign_api_account`; if either is gone it logs an error and drops
the item. Otherwise it calls `ContactFormManager::sendToActiveCampaign($message, $account)`.

Error handling:
- `activecampaign_api\Exception` with HTTP **503** → `SuspendQueueException` (AC temporarily down; retry
  the queue later).
- `activecampaign_api\Exception` already reported to the error webhook → swallowed (not re-thrown).
- Any other exception → logged via `Error::logException` and re-thrown (item stays on the queue).

## 3. Send (`ContactFormManager::sendToActiveCampaign`)

1. **Gate** — `shouldSendToActiveCampaign()`: returns false if not enabled; then checks `send_when`:
   `always`, or `checkbox_checked:<field>` (send only when a boolean form field equals `'1'`).
2. **Resolve contact** — only method implemented is `DETERMINE_AC_CONTACT_METHOD_EMAIL` (`'email'`):
   `getActiveCampaignContactByEmail()` looks up the AC contact by the submitted email (the form field
   mapped to the special `contact:email` option). If none found and *Create when non-existing* is off,
   it stops; otherwise it builds a new `Contact` (empty id ⇒ create later).
3. **Resolve account** (only if the AC subscription `supportsAccounts()`): finds the account linked to
   the existing contact, else a new `Account`.
4. **Apply field mapping** — for each `field:column => group:property` entry, the matching
   FieldMapper plugin extracts the value (`hook_contact_activecampaign_mapped_field_value_alter` can
   rewrite it), empties are skipped, and the value is routed by `group`:
   - `contact` → `$contact->$property` (built-in: firstName, lastName, phone).
   - `field` → `$contact->fieldValues[]` (AC custom contact field by id).
   - `account` / `accountcustomfieldmeta` → onto the `Account` (only when accounts are supported;
     flags that the contact must be linked to an account).
5. **Persist contact** — empty id ⇒ `Contacts::create()`, else `Contacts::update()`. Logged either way.
6. **Persist / link account** (when account fields were set): find by name
   (`DETERMINE_AC_ACCOUNT_METHOD_NAME`), else create (auto-naming
   `Company for contact_message N at <host>` if no name), then create an `AccountContact` link.
7. **List subscriptions** — for every AC contact list, the saved `ListSubscriptionSetting`
   (`Ignore` / `Subscribe` / `Unsubscribe`) is applied via `ContactLists::updateStatus()`, but only if
   its configured "required checked" boolean form fields are all `'1'`.
8. **Tags** — each configured tag id is added via `ContactTags::create()`; a "Tag not found" error is
   swallowed, anything else re-thrown.

## Error-reporting context hook

`sendToActiveCampaign()` stashes `{contact_form, contact_message}` in a static, and
`contact_activecampaign_activecampaign_api_report_error_to_webhook_alter()` uses it to enrich the
dependency's error-webhook payload (only when the account has an error-reporting webhook URL) with the
contact form id/label, message id, absolute message URL, and the site host.

## Config storage

Per form + account settings live in a `config_object` named
`contact_activecampaign.<contact_form_id>.<account_id>` (schema `contact_activecampaign.*.*`). Keys:
`enabled`, `send_when`, `determine_ac_contact_method`, `create_nonexisting`,
`determine_ac_account_method`, `create_nonexisting_account`, `field_mapping` (array),
`list_subscription` (a PHP-`serialize()`d array of `ListSubscriptionSetting`, restored with
`allowed_classes` limited to that class), `tag_ids` (array).
