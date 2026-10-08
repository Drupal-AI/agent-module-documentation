# Inbound callbacks and the Rules event integration

The base module has no inbound callback of its own; the callback endpoints ship with the
`mailjet_event` and `mailjet_campaign` submodules, which must be enabled for these routes to exist.

## Mailjet event callback — `mailjet_event`

- **Route:** `event.content` → path `/mailjetevent`, controller
  `EventCallbackController::callback` → `_mailjet_event_alter_callback()`. Routing requirement:
  `_access: 'TRUE'`.
- **Mechanism:** reads the raw request body (`php://input`), `json_decode`s it, and — when the event's
  `email` / `original_address` matches a Drupal account (`user_load_by_mail`) — deletes any existing
  `event_entity` for that user's UUID and creates a new one with `event_type => $event->event` and
  `event_field => serialize($event)`.
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
  `CampaignCallbackController::callback` → `_mailjet_campaign_alter_callback()`. Routing requirement:
  `_access: 'TRUE'`.
- **Mechanism:** reads `php://input`; on a `html saved successfully` response it fetches the campaign's
  HTML from Mailjet (`NewsletterDetailcontent` / `CampaigndraftDetailcontent`), rewrites links to add a
  `?token=<campaign_id>` tracking param, and PUTs the HTML back; on `campaign added successfully` it
  creates a `campaign_entity` record. This code path uses several APIs removed in modern core
  (`\Drupal::entityManager()`, `watchdog()`) and is effectively non-functional on Drupal 10/11.

## Confirmation-subscribe endpoint — base module

- **Route:** `subscribe_form.settings` → path `/confirmation-subscribe`, form `SubsribeEmailForm`.
  Routing requirement: `_access: 'TRUE'`.
- **Mechanism:** part of the `mailjet_subscription` double-opt-in flow. `SubscriptionSignupPageForm`
  emails a confirmation link to this path carrying `sec_code` (base64 email), `list`, `properties`
  (base64 JSON) and `others` (subscription-form id); `SubsribeEmailForm::buildForm()` reads those
  query parameters and calls `MailjetApi::syncMailjetContact($list_id, ['Email' => $email, ...])` to
  add the contact to the list. See the subscription entity keys in
  [../configure/settings.md](../configure/settings.md).
