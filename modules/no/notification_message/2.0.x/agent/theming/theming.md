<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

Two theme hooks (`notification_message_theme()` in `.module`), templates in `templates/`,
theme functions in `templates/notification_message.theme`.

## Theme hooks

| Hook | Template | Render var | Use |
|---|---|---|---|
| `notification_message` | `notification-message.html.twig` | `elements` (`#notification_message`, `#view_mode`) | A single rendered message. |
| `notification_messages` | `notification-messages.html.twig` | `element` (`#block`, `#messages`) | The block wrapper around the message list. |

## Template suggestions

`notification_message` (per message) — added by
`notification_message_theme_suggestions_notification_message()`:

```
notification_message__<view_mode>
notification_message__<bundle>
notification_message__<bundle>__<view_mode>
notification_message__<id>
notification_message__<id>__<view_mode>
```

`notification_messages` (the block wrapper) — added by
`notification_message_theme_suggestions_notification_messages()`, derived from the block's
selected types and display mode:

```
notification_messages__types__<type1_type2 | all>   // sorted type ids joined by _, or "all"
notification_messages__display__<display_mode>
```

## Dismiss behavior

- Library `notification_message/notification.dismiss` (`notification_message.libraries.yml`,
  `assets/js/notification-message.dismiss.js`) is attached whenever the block renders
  messages. It provides the cookie-based close/dismiss handling.
- Whether a dismiss control appears is driven by the message **type**'s
  `notification_dismiss.show` and `notification_dismiss.button_text` (see
  [../configure/messages.md](../configure/messages.md)); the type getters are
  `getNotificationDismissShow()` and `getNotificationDismissButtonText()`.
