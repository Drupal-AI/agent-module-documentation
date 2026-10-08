# Configuration

Getting Decoupled Entity Notifications working is a multi-step process: set a
secret key, adjust the settings form, schedule the cron jobs, and add the
notifications field to the bundles you want to be subscribable. Work through the
steps in order.

## 1. Set the secret key

Add a secret key to your site's `settings.php` (or, better, a per-environment file
like `settings.local.php`), replacing the placeholder with a secure, private
value:

```php
$config['de_notifications.settings']['secret_key'] = getenv('DE_NOTIFICATIONS_SECRET_KEY');
```

Using an **environment variable** for the key (as shown) is strongly recommended
over hard-coding the value — never commit a real secret to version control. This
key is used by the module to secure its notification flow, so treat it like any
other credential.

## 2. Adjust the settings form

Go to **`/admin/config/system/de_notifications`** to review and adjust the
module's settings for your site. This is where the module-wide options for how
subscriptions and notifications behave are managed.

## 3. Schedule the cron jobs

DEN does its background work on cron. Configure the schedules that suit your site
for these jobs in your cron settings:

- **Clean up unconfirmed subscriptions** — removes subscription requests that were
  never confirmed, keeping the subscription data tidy.
- **Queue: Notify Subscribers** — processes the queue that sends notifications out
  to subscribers.

Make sure cron actually runs regularly on your site, otherwise notifications won't
be delivered and stale subscriptions won't be cleaned up.

## 4. Add the notifications field to your bundles

Subscribability is turned on per entity bundle by adding the module's
`notifications_settings` field:

1. Go to the bundle you want to make subscribable — for example **Structure →
   Content types → *(your type)* → Manage fields**.
2. Add a new field of the **notifications settings** type provided by the module.
3. Enable the field for the specific entity instances you want to be subscribable.

The field carries a subfield controlling whether an entity can be subscribed to,
and a user-configurable subfield (with a description text field) for controlling
which changes send notifications.

## 5. Use the endpoints

With the key set, cron scheduled, and the field in place, your decoupled front-end
can call the module's API endpoints to create and manage subscriptions and receive
notifications. Refer to the project's documentation for the exact endpoint
contracts.

## A note on privacy and access

Subscriptions link **users to entities**, which is personal data — handle and
retain it responsibly. Just as importantly, make sure notification content only
reveals entities and fields the subscriber is permitted to see, so a subscriber is
never told about content they couldn't otherwise access. Keep subscription
management gated behind the module's permissions.
