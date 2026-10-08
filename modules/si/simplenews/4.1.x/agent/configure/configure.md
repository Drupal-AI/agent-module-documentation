# Configure newsletters, issues & sending

## The three entities

| Concept | Type | Where | Notes |
|---|---|---|---|
| **Newsletter** | `simplenews_newsletter` **config** entity (`config_prefix: newsletter`) | `/admin/config/services/simplenews` | A list/category subscribers join. One ships by default (`default`). |
| **Subscriber** | `simplenews_subscriber` **content** entity (base table `simplenews_subscriber`) | `/admin/people/simplenews` | Keyed by email; multi-value `subscriptions` field references newsletters. Status: `INACTIVE`(0), `ACTIVE`(1), `UNCONFIRMED`(2). |
| **Issue** | a **node** whose content type has the `simplenews_issue` field | node add/edit + `/node/{node}/simplenews` tab | The actual email. Field tracks status, sent_count, error_count, subscribers. |

## Admin routes

| Route | Path | Purpose (permission) |
|---|---|---|
| `simplenews.newsletter_list` | `/admin/config/services/simplenews` | List newsletters — the `configure` route (`administer newsletters`) |
| `simplenews.newsletter_add` | `.../add` | Add a newsletter |
| `entity.simplenews_newsletter.edit_form` | `.../manage/{id}` | Edit a newsletter |
| `entity.simplenews_subscriber.collection` | `/admin/people/simplenews` | Subscribers list (`administer simplenews subscriptions`) |
| `simplenews.subscriber_import` | `/admin/people/simplenews/import` | Mass subscribe |
| `simplenews.subscriber_unsubscribe` | `/admin/people/simplenews/unsubscribe` | Mass unsubscribe |
| `simplenews.subscriber_export` | `/admin/people/simplenews/export` | Export subscribers |
| `simplenews.settings_newsletter` | `/admin/config/services/simplenews/settings/newsletter` | Newsletter defaults (`administer simplenews settings`) |
| `simplenews.settings_subscription` | `.../settings/subscription` | Subscription/opt-in settings |
| `simplenews.settings_mail` | `.../settings/mail` | Send-mail settings |
| `simplenews.settings_prepare_uninstall` | `.../settings/uninstall` | **Prepare uninstall** (required before uninstalling) |
| `simplenews.node_tab` | `/node/{node}/simplenews` | Per-issue send / test / status |

## Enable issues on a content type

Edit the content type form: Simplenews adds a control (via `simplenews_form_node_type_form_alter`)
to attach the `simplenews_issue` field. Once attached, each node of that type becomes a newsletter
issue and gains the **Newsletter** tab to send now, send a test, or schedule.

## Front-end subscription

- **Block** `simplenews_subscription_block` ("Simplenews subscription") — place it and pick which
  newsletters it offers; supports default-checked newsletters, a message, and a manage link.
- **Page** `/simplenews/subscriptions` (`simplenews.subscriptions`, needs `subscribe to newsletters`).
- **User tab** `/user/{user}/simplenews` — logged-in users manage their own subscriptions.
- Hash-authenticated links (`/simplenews/confirm|add|remove/...`) handle **double opt-in** confirm
  and one-click unsubscribe without login.

## Settings — `simplenews.settings` config object

Edit via the settings forms above or `drush cset simplenews.settings <key>`. Defaults:

| Key | Default | Meaning |
|---|---|---|
| `hash_expiration` | `86400` | Lifetime (s) of confirmation/manage hash links |
| `newsletter.format` | `plain` | Default format for new newsletters (`plain`/`html`) |
| `newsletter.priority` | `0` | Default mail priority |
| `newsletter.receipt` | `TRUE` | Default request-read-receipt |
| `newsletter.issue_tokens` | `FALSE` | Show token browser on node edit |
| `subscriber.sync_fields` | `TRUE` | Sync fields between user account and subscriber |
| `subscription.skip_verification` | `FALSE` | If TRUE, skip double opt-in for anonymous |
| `subscription.tidy_unconfirmed` | `7` | Delete unconfirmed subscriptions after N days |
| `subscription.confirm_subject` / `confirm_body` | token strings | Opt-in confirmation email |
| `subscription.confirm_subscribe_page` / `confirm_unsubscribe_page` | `""` | Redirect after confirm |
| `mail.use_cron` | `TRUE` | Drain the spool during cron (vs. immediate) |
| `mail.throttle` | `20` | Mails sent per cron run |
| `mail.textalt` | `FALSE` | Generate plain-text alternative for HTML mail |
| `mail.spool_progress_expiration` | `3600` | Reset stuck in-progress spool rows after (s) |
| `mail.spool_expire` | `0` | Days to keep sent mails in spool (0 = delete immediately) |
| `mail.debug` | `FALSE` | Debug logging |

Per-**newsletter** settings live on the config entity: `name`, `format`, `subject`, `from_name`,
`from_address`, `priority`, `receipt`, `hyperlinks`, `access`, `new_account`, `reason`,
`allowed_handlers` (restrict which recipient handlers may be used), `weight`.

## Sending model

1. Publishing/activating an issue (or the **Send** action `simplenews_send_action`) calls
   `SpoolStorage::addIssue()`, writing one **spool** row per recipient (recipients chosen by the
   issue's **recipient handler**, default `simplenews_all` = all active subscribers).
2. `hook_cron` runs `simplenews.mailer->sendSpool(throttle)`, then `spool_storage->clear()`, then
   `mailer->updateSendStatus()`, then `subscription_manager->tidy()`. With `mail.use_cron = FALSE`
   the mailer attempts an immediate batched send instead.
3. The **Stop** action (`simplenews_stop_action`) halts an in-progress send.

Schema: `config/schema/simplenews.schema.yml`. Config exports with `drush config:export`.
