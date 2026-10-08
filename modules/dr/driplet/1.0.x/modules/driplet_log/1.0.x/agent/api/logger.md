<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Driplet logger + real-time report page

## Install & enable

```bash
drush en driplet_log -y
```

Dependencies (`driplet_log.info.yml`): `driplet:driplet`, `drupal:dblog`. No permissions, config, or
schema shipped.

## Logger service (`src/Logger/DripletLogger.php`)

`logger.driplet_log` is a PSR-3 `LoggerInterface` (uses `RfcLoggerTrait`,
`DependencySerializationTrait`), registered with the `logger` tag in `driplet_log.services.yml` with
args `@logger.log_message_parser`, `@driplet.service`. Because it is tagged `logger`, Drupal's
logger channel factory calls it for **every** log entry.

`log($level, $message, $context)`:

1. Returns early if `$context['channel']` is `driplet_log` or `driplet_notify` (loop guard).
2. Interpolates placeholders via `parseMessagePlaceholders()` + `strtr()`.
3. Builds a Driplet message and sends it:

```php
$this->dripletService->createMessage()
  ->setMessage([
    'severity'  => $level,
    'type'      => mb_substr($context['channel'], 0, 64),
    'message'   => strip_tags($message),
    'timestamp' => $context['timestamp'],
    'uid'       => $context['uid'],
    'link'      => $context['link'] ?? NULL,
  ])
  ->setTopic('driplet-log')
  ->include()
  ->setTarget('roles', 'administrator');
$this->dripletService->sendMessage($driplet_message);
```

Any exception is caught and logged to the `driplet` channel (so a delivery failure never breaks the
request). Message text is `strip_tags()`-cleaned before sending.

## Report page (`src/Controller/LogController.php`)

Route `driplet_log.page` (`/admin/reports/driplet-log`, `_permission: access site reports`, title
"Real-time logs", menu under *Reports*). `content()` returns a render array only — a `#type => table`
with header *Severity / Type / Date / Message / User*, `#id => driplet-log-table`,
`#empty => "Waiting for logs..."` — and attaches library `driplet_log/driplet-log`. No data is
queried server-side; rows arrive over the WebSocket.

## Client script (`js/driplet-log.js`)

`Drupal.behaviors.dripletLog` (runs once, `context === document`): finds `#driplet-log-table`, gets
`DripletClient.getInstance(drupalSettings.driplet.ws_endpoint, origin + '/api/driplet/jwt')`,
`setTopics(['driplet-log'])`, and on each message with `topic === 'driplet-log'` inserts a new row at
the top (`insertRow(0)`, class `severity-<n>`). Cells are populated with `textContent` (severity,
type, formatted date, uid); the message cell renders as a link (`href = message.link`) when a link is
present, otherwise `textContent`. The table is trimmed to the latest 50 rows.
