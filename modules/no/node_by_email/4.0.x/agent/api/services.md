<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services / API

Four services in `node_by_email.services.yml`. Ingestion also runs from `hook_cron` in `node_by_email.module`
(only when `now - state('node_by_email.last_run') > cron_interval`).

## `node_by_email.imap_connection` — `IMAPService`
Args: `@config.factory`, `@logger.channel.node_by_email`.
- `connection($str='', $user='', $pass='')` — opens `@imap_open` (falls back to config values); returns `true`
  on success or an error string. Sets `fromEmail` from config on success.
- `getImapConnection()` — connects and returns the raw IMAP stream (or falsey).
- `getUnseenEmailList()` — `imap_search($conn, 'FROM "'.$fromEmail.'" UNSEEN')`; array of message ids.
- `getEmailHeader($mid, $format='TEXT/PLAIN')` — returns `[datetime, from, fromName, replyTo, replyToName,
  subject, to, body]`; returns `[]` (skips) if the sender mailbox is `mailer-daemon`/`postmaster`.
- `getEmailBody($mid, $format='html')` — TEXT/HTML part, falling back to TEXT/PLAIN.
- `setUnseenMail($mid)` — sets `\Seen \Flagged` on the message (misnamed; it marks Seen).

## `node_by_email.mid_to_node` — `MidToNodeService`
Args: `@node_by_email.imap_connection`, `@config.factory`.
- `createNodeFromMid($mid)` — reads the header, then for each configured `node_types` creates a node
  `{type, title: subject, body: {value: body}, uid: author_uid}`, sets published/unpublished per
  `publishing_option`, saves, and marks the mail Seen. **Note:** body is stored with **no `format`** key.

## `node_by_email.email_to_node` — `EmailToNode`
Args: `@node_by_email.mid_to_node`, `@messenger`. Batch-API callbacks used by the Unseen Emails form:
- `createNode($mid, $total, &$context)` — one batch op per message; wraps `createNodeFromMid` with progress.
- `createNodeFinishedCallback($success, $results, $operations)` — messenger summary.

## `logger.channel.node_by_email`
Standard logger channel used for IMAP connection errors.

## Example (programmatic ingest)
```php
$imap = \Drupal::service('node_by_email.imap_connection');
$mids = $imap->getUnseenEmailList() ?: [];
$mid2node = \Drupal::service('node_by_email.mid_to_node');
foreach ($mids as $mid) {
  $mid2node->createNodeFromMid($mid);
}
```
