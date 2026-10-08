<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification hooks + front-end rendering

## Install & enable

```bash
drush en driplet_notify -y
```

Only dependency is `driplet` (`driplet_notify.info.yml`). No routes, permissions, config, schema, or
services — everything lives in `driplet_notify.module` and `js/notify.js`.

## Send side (`driplet_notify.module`)

Each hook fetches `\Drupal::service('driplet.service')`, builds a message on topic `driplet-notify`,
calls `->include()->setTarget('roles', …)`, and `sendMessage()`:

| Hook | `message.type` | `content` | Target role |
|---|---|---|---|
| `hook_node_insert` | `notify-persist` | "New \<type\> page \<link title\> has been created just now." | `authenticated` |
| `hook_node_update` | `notify-persist` | "\<type\> page \<link title\> has been updated." | `authenticated` |
| `hook_node_delete` | `notify-persist` | "\<type\> page \<title\> has been deleted." | `authenticated` |
| `hook_rebuild` | `notify` (+ `notifyType: default`) | "Cache was cleared at \<time\>" | `administrator` |

Content strings are built with `t()` and placeholders (`@type`, `@url`, `@title`); the message body
is the resulting string under the `content` key. `notify-persist` cards stay until dismissed;
`notify` cards are treated as timed.

## Client side

- `hook_page_attachments_alter()` attaches library `driplet_notify/notify` to every page.
- `hook_page_bottom()` outputs `<div id="driplet-notify-wrapper"></div>` as the render target.
- `js/notify.js` (`Drupal.behaviors.dripletNotify`, runs once on `document`): gets
  `DripletClient.getInstance(drupalSettings.driplet.ws_endpoint, origin + '/api/driplet/jwt')`,
  `setTopics(['driplet-notify'])`, and for each message whose `topic === 'driplet-notify'` and whose
  `type` is `notify` or `notify-persist` calls `createNotification(message, wrapper)`.
- `createNotification()` builds a `<div class="driplet-notify <notifyType|default>">`; for
  `type === 'notify'` it adds the `timed` class and removes the card after 12000ms. The card body is
  set with `content.innerHTML = message.content` and a close button (`×`) removes the card on click.

Because the card body is injected as **HTML** (`innerHTML`), only trusted, server-generated markup
should be published to the `driplet-notify` topic — the client does not sanitize it. Styling is in
`css/notify.css`.
