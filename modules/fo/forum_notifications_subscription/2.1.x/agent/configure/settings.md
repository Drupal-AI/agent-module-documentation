# Settings (configure)

One admin settings form. Route `forum_notifications_subscription.settings` →
`/admin/config/system/forum_notifications_subscription`, permission `administer site configuration`,
form `Form\ForumNotificationsSubscriptionSettingsForm` (form id
`forum_notifications_subscription_settings`). It edits the single config object
`forum_notifications_subscription.settings`. Config translation is enabled
(`forum_notifications_subscription.config_translation.yml`), so per-language message templates are
possible; the notification sender switches the config-override language to the *recipient's*
preferred language before rendering (see [../api/notifications.md](../api/notifications.md)).

Every field falls back with `$config->get('<key>') ?? $config->get('settings.<key>')` — the
`settings.*` prefix is a legacy layout the code still reads (there is a `@todo` to drop it). Write new
values at the top-level keys below.

## Config keys — `forum_notifications_subscription.settings`

| Key | Form field | Install default | Purpose |
|---|---|---|---|
| `forum_label_on` | Forum subscribe button label | `Subscribe to this forum` | Link text when not subscribed to a forum. |
| `forum_label_off` | Forum unsubscribe button label | `Unsubscribe from this forum` | Link text when subscribed to a forum. |
| `topic_label_on` | Topic subscribe button label | `Subscribe to this forum topic` | Link text when not subscribed to a topic. |
| `topic_label_off` | Topic unsubscribe button label | `Unsubscribe from this forum topic` | Link text when subscribed to a topic. |
| `post_subject` | Forum → Single Subject | `Post subject` | Subject for a single "new topic" email. Tokens: `fns_topic`. |
| `post_message` | Forum → Single Message | `Post message` | Body for a single "new topic" email. Tokens: `fns_topic`. |
| `post_dd_message` | Forum → Daily Digest Message | (empty) | Per-topic line placed in the daily digest. Tokens: `fns_topic`. |
| `forum_default_frequency` | Forum default frequency | `Single Emails` | Frequency assigned to a *new forum* subscription. |
| `comment_subject` | Topic → Single Subject | `Comment subject` | Subject for a single "new comment" email. Tokens: `fns_comment`. |
| `comment_message` | Topic → Single Message | `Comment message` | Body for a single "new comment" email. Tokens: `fns_comment`. |
| `comment_dd_message` | Topic → Daily Digest Message | (empty) | Per-comment line placed in the daily digest. Tokens: `fns_comment`. |
| `topic_default_frequency` | Topic default frequency | `Single Emails` | Frequency assigned to a *new topic* subscription. |
| `dd_subject` | Daily Digest Subject | (empty) | Subject of the once-a-day digest email. Tokens: `fns_dd`. |
| `dd_header_message` | Daily Digest Header Message | (empty) | Header prepended above the digest blocks. Tokens: `fns_dd`. |
| `cron` | "Send single emails when cron run" | `0` | When TRUE, single emails are queued (`single_email_queue`) and sent by cron; when FALSE they are sent inline during the topic/comment save. Does **not** affect digests (always queued). |

Frequency values are the exact strings `Single Emails` and `Daily Digest Emails` (compared with `==`
throughout the code — do not translate the stored value).

Config schema (`config/schema/forum_notifications_subscription.settings.schema.yml`) types the label
keys as `label`, the message keys as `text`, and — note — `forum_default_frequency`,
`topic_default_frequency` and `cron` are declared as `sequence`s even though the form and code store
scalars; keep that in mind if validating config programmatically.

## Set from code

```php
\Drupal::configFactory()->getEditable('forum_notifications_subscription.settings')
  ->set('forum_label_on', 'Follow this forum')
  ->set('post_subject', 'New topic in [fns_topic:forum_name]')
  ->set('post_message', "Hi [fns_topic:user_name],\n[fns_topic:poster_name] posted [fns_topic:topic_name]: [fns_topic:topic_url]")
  ->set('forum_default_frequency', 'Daily Digest Emails')
  ->set('cron', TRUE)
  ->save();
```

## Enable the subscribe link on the display

The link is an **extra field** (`hook_entity_extra_field_info`) with id
`forum_notifications_subscription`, added to the `node.forum` and `taxonomy_term.forums` view
displays. It is hidden until you enable the "Subscription link" component on the relevant display
(`/admin/structure/types/manage/forum/display`, `/admin/structure/taxonomy/manage/forums/overview/display`,
or in Twig `{{ content.forum_notifications_subscription }}`). See
[../api/routes.md](../api/routes.md) for what the link renders.

## Per-user frequencies & the shipped View

Each subscriber changes their own frequencies from the fieldset injected into their account edit form
(`/user/{uid}/edit`, see [../api/notifications.md](../api/notifications.md)). The module also installs
the View `your_subscription_settings` (base table `forum_notification_frequency`) which you can add to
the user profile display so users can see their subscriptions.
