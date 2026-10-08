# Inbound callbacks and the Rules event integration

The base module has no inbound event callback of its own; the event/campaign callback endpoints ship
with the `mailjet_event` and `mailjet_campaign` submodules, which must be enabled for those routes to
exist. The base module does provide the `/confirmation-subscribe` route used by the subscription
flow.

## Mailjet event callback — `mailjet_event`

- **Route:** `event.content` → path `/mailjetevent`, controller
  `EventCallbackController::callback` → `_mailjet_event_alter_callback()`. Declared routing
  requirement: `_access: 'TRUE'`.
- **Intent:** receive Mailjet's server-to-server event notifications (open/click/bounce/spam/blocked/
  unsub) and record them as `event_entity` records for the matching Drupal account, which in turn can
  drive the Rules reaction events below.
- **Configuring Mailjet:** paste `<base_url>/mailjetevent` as the ENDPOINT URL in Mailjet's trigger
  settings (the base Settings form also shows this URL and lets you toggle which event types Mailjet
  should POST — see [../configure/settings.md](../configure/settings.md)).

### Event entity — `event_entity`

Content entity (`Entity\Event`, base table `mailjet_event`). Base fields: `event_id`, `uuid`,
`event_type` (string), `event_field` (`map`), `langcode`, `created`, `changed`. Uninstall handler
route `event.uninstall` (`/admin/modules/uninstall/entity/event_entity`, `_mailjet_access_check`).

### Rules reaction events (`mailjet_event.rules.events.yml`)

`mailjet_event` declares Rules **events** in the `Mailjet` category that other Rules can react to:
`bounce_event`, `blocked_event`, `spam_event`, `click_mailjet_event`, `unsubscribe_event`,
`open_event`, `typo_event` (each with a `logger_entry` context). It also ships optional reaction-rule
configs under `config/optional/rules.reaction.mailjet_*_event.yml` that trigger on
`rules_entity_insert:event_entity` and branch on `event_entity.event_type.value` (e.g. `== unsub`);
their action lists are empty by default — fill them in to act on incoming events. There are matching
`Event\*Event` classes (`BounceEvent`, `BlockedEvent`, `ClickEvent`, `OpenEvent`, `SpamEvent`,
`UnsubscribeEvent`, `TypoEvent`).

## Campaign callback — `mailjet_campaign`

- **Route:** `campaign.callback` → path `/campaigncallback`, controller
  `CampaignCallbackController::callback` → `_mailjet_campaign_alter_callback()`. Declared routing
  requirement: `_access: 'TRUE'`.
- **Intent:** react to Mailjet's campaign/newsletter notifications — rewrite campaign HTML with
  tracking links and create `campaign_entity` records. This code path uses several APIs removed in
  modern core (`\Drupal::entityManager()`, `watchdog()`) and is effectively non-functional on
  Drupal 10/11.

## Confirmation-subscribe endpoint — base module

- **Route:** `subscribe_form.settings` → path `/confirmation-subscribe`, form `SubsribeEmailForm`.
  Declared routing requirement: `_access: 'TRUE'`.
- **Intent:** the recipient-facing confirmation step of the `mailjet_subscription` double-opt-in flow.
  `SubscriptionSignupPageForm` emails a confirmation link to this path carrying `sec_code`, `list`,
  `properties` and `others` (the subscription-form id); `SubsribeEmailForm::buildForm()` reads those
  query parameters, prepares the contact via `mailjet_prepare_subscription_contact()`, and calls
  `MailjetApi::syncMailjetContact($list_id, ['Email' => $email, ...])` to add the contact to the list,
  then dispatches a `MailjetSubscriptionEvent`. See the subscription entity keys in
  [../configure/settings.md](../configure/settings.md).
