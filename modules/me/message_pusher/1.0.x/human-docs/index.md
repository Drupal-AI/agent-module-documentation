# Message Pusher — manual setup guide

**Message Pusher** (`message_pusher`) delivers Message entities to subscribed clients
**in real time** over the [Pusher](https://pusher.com/) protocol — either the hosted
Pusher.com service or a compatible self-hosted server such as
[Soketi](https://soketi.app/) or pws. It hooks into
[Message Notify](https://www.drupal.org/project/message_notify) as a notifier plugin
(id `pusher`), so it sits right next to the email notifier and inherits all the
standard Message Notify behavior (save on success, save on fail, rendered
view-modes).

The transport is generic — anything you can model as a Message entity can ride it:
in-app notifications and mention/reply alerts rendered as bell pop-ups, activity
streams and timelines, chat threads, live dashboards, and owner-less broadcast
announcements. Which client receives a message is decided by **token-driven channel
resolution**; the default channel pattern is `private-user.{uid}` (matching the
Pusher "user" convention), with tokens available for the template machine name and a
linked entity type/id. You can fan one message out to several channels at once and
override the event name per send.

Setup differs from most modules in that the **credentials live in the
[Pusher API](https://www.drupal.org/project/pusher_api) module**, configured through
`$settings['pusher_api']` in `settings.php` — not on a form in this module. Message
Pusher depends on [Message](https://www.drupal.org/project/message),
[Message Notify](https://www.drupal.org/project/message_notify) and Pusher API, and
supports Drupal 10.2+, 11 and 12. A recommended companion,
[Pusher User](https://www.drupal.org/project/pusher_user), auto-subscribes logged-in
users to their own channel on the web so no extra JavaScript is needed to receive
notifications.

This is an early release (1.0.0-alpha1) — production-shaped, but the API may still
shift before a stable 1.0.0. Because delivery is programmatic (you send a Message
through the notifier from code), the bundled `README.md` carries the full payload and
API reference; this guide covers installation and the credential/notifier setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Message, Message Notify and Pusher API.
2. [Configuration](configuration/index.md) — provide the Pusher/Soketi credentials via
   `settings.php`, understand channels, and send through the `pusher` notifier.

## Where it lives in the admin menu

Message Pusher has no settings form of its own (`configure` is null). Its credentials
are configured in `settings.php` via the Pusher API module, and it is used
programmatically as a Message Notify notifier — see
[Configuration](configuration/index.md).
