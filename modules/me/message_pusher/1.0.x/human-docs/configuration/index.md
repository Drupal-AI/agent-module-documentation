# Configuration

Message Pusher has no admin settings form. Two things make it work: the **Pusher
credentials**, configured through the Pusher API module in `settings.php`, and the
**`pusher` notifier**, which you invoke when you send a Message. Channel behavior is
driven by tokens and has sensible defaults.

## Provide the Pusher/Soketi credentials (settings.php)

The app credentials are handled by the [Pusher API](https://www.drupal.org/project/pusher_api)
module and read from `$settings['pusher_api']` in `settings.php`. Because these are
secrets (app key, secret, app id), keep them out of committed configuration — store
each value in an environment variable and reference it from `settings.php` with
`getenv()`.

With DDEV, save the values into the container environment, for example:

```bash
ddev dotenv set .ddev/.env --pusher-key=<key> --pusher-secret=<secret> --pusher-app-id=<id>
ddev restart
```

Then reference them in `settings.php` (keep `.ddev/.env` out of version control):

```php
$settings['pusher_api']['default']['options'] = [
  'key'    => getenv('PUSHER_KEY'),
  'secret' => getenv('PUSHER_SECRET'),
  'app_id' => getenv('PUSHER_APP_ID'),
  // ...cluster/host options per Pusher API's documentation.
];
```

**Self-hosting:** Pusher.com works out of the box, but for in-house or EU-hosted
real-time you can point `$settings['pusher_api']['default']['options']` at a
[Soketi](https://soketi.app/) host instead — it speaks the Pusher protocol and needs
no code changes on the Drupal or client side.

## Channels (token-driven)

Which client receives a message is decided by the channel pattern. The default is
`private-user.{uid}`, matching the Pusher user convention. Available tokens:

- `{uid}` — the recipient user id.
- `{template}` — the message template machine name.
- `{linked_entity_type}` / `{linked_entity_id}` — when those base fields exist on the
  Message entity.

You can fan one Message out to several channels in a single send via
`additional_channels`, and the event name defaults to the message template machine
name (override it per send if you need to). Access checks adapt to the pattern — a
`{uid}` is only required when the channel pattern actually uses it, which is what makes
owner-less broadcast channels (for example a static `announcements` channel) possible.

## Sending a message through the notifier

Delivery is programmatic. Create a Message and send it through the `pusher` notifier,
for example:

```php
$message = \Drupal\message\Entity\Message::create([
  'template' => 'mention_news',
  'uid' => $recipientUid,
  'linked_entity_type' => 'node',
  'linked_entity_id' => $node->id(),
]);
$message->save();

\Drupal::service('message_notify.sender')->send($message, [], 'pusher');
```

## Payloads and rendered HTML

By default the rendered `pusher` view-mode HTML is **not** included in the payload.
Pusher caps payloads at roughly 10 kB, and rendered HTML can leak privileged content
into a channel — so only opt in to including it when you are sure the channel's
audience is allowed to see that content.

## Verify it worked

With [Pusher User](https://www.drupal.org/project/pusher_user) installed, an
authenticated page subscribes the current user to their own `private-user.{uid}`
channel and re-broadcasts each event, so you can listen client-side. Send a test
message through the `pusher` notifier and confirm it arrives. The bundled `README.md`
has the full payload shape and test instructions.
