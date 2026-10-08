<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ingestion & feed rendering — email_to_rss

How mail is pulled from IMAP into the local mirror, and how the mirror is served as RSS.

## Ingestion (IMAP → DB)

- **`Sync\EmailSync::run()`** iterates enabled feeds (`config('email_to_rss.settings').feeds` filtered
  by `enabled`). For each feed it reads `folder` (default `INBOX`) and `feed_limit`, then decides the
  fetch window: if the mirror already holds ≥ `feed_limit` rows it fetches `since` the newest stored
  `received_at` (`EmailStorage::latestReceivedAt`), otherwise it fetches all. It saves each returned
  message via `EmailStorage::save()` and calls `EmailStorage::prune()`. Errors are logged per feed,
  not thrown. Invoked by cron (`email_to_rss_cron` in `.module`) and by the form's "Sync all now".
- **`Source\WebklexImapSource::fetchSince()`** (service, aliased to `EmailSourceInterface`) builds a
  `Webklex\PHPIMAP\ClientManager` client from `config()` with **`validate_cert => TRUE`** and
  `protocol => 'imap'`, connects, selects `getFolderByName($folder)` (throws `RuntimeException` if
  missing), and queries `setFetchBody(TRUE)->setFetchFlags(FALSE)->fetchOrder('desc')->limit($limit)`
  (`->since()` when a date is given, else `->all()`). Each message is mapped by `toEmailMessage()`
  into an `EmailMessage` DTO; per-message mapping failures are logged and skipped.
- **`config()`** returns `host/port/encryption/username` from config plus `password` from
  `getenv('EMAIL_TO_RSS_IMAP_PASSWORD')`; NULL (skip fetch) if host/username/password empty.
- **`toEmailMessage()`** decodes the MIME subject (`iconv_mime_decode`), derives `messageId` (falls
  back to a `sha1` synthetic id when the Message-ID header is empty), reads from-name/from-email,
  builds `receivedAt` from the Date header, and extracts HTML/text bodies (`hasHTMLBody`/`hasTextBody`,
  with a hand-rolled recursive MIME walker `fallbackBodies()`/`extractTextMimeParts()` for nested
  single-part multiparts, handling base64/quoted-printable and charset via `iconv`).

## Storage — `Storage\EmailStorage` (table `email_to_rss_item`)

- `save($feedId, EmailMessage)`: dedups on (`feed_id`, `message_id`); inserts a new row (subject/from
  truncated to schema lengths) or, if a stored row lacks a body but the fetched one has one, updates
  the body. Returns TRUE only on a new insert. Invalidates cache tags `email_to_rss:list` and
  `email_to_rss:list:{feed}`.
- `recent($feedId, $limit)` / `load($feedId, $id)`: read rows (newest first) as `EmailMessage`.
- `prune($feedId, $limit)`: deletes rows beyond the newest `$limit`. `deleteAll(?$feedId)`,
  `count()`, `latestReceivedAt()`. Table has unique key (`feed_id`,`message_id`) and index
  (`feed_id`,`received_at`) (`hook_schema`). All queries use the DB API query builder (parameterized).

## Feed exposure (DB → RSS/HTML)

- **`Controller\FeedController::feed($request, $feed_id, $token)`** (route `email_to_rss.feed`,
  `_access: TRUE`) resolves the feed via `feedConfig()`, loads `EmailStorage::recent()`, and returns
  `FeedBuilder::build()` XML as a `CacheableResponse` (`application/rss+xml`) with feed cache tags +
  `url.path` context.
- **`feedConfig($feedId, $token)`** loads the feed from config and throws `NotFoundHttpException`
  (404, not 403) unless the feed exists, is `enabled`, has a non-empty stored token, and
  `hash_equals($storedToken, $token)` matches. This token check is the only gate on the feed/item
  routes.
- **`FeedController::item(...)`** (route `email_to_rss.item`) re-validates the token, loads one email
  (`EmailStorage::load`, 404 if absent) and returns an HTML page whose body is the stored email body.
- **`Feed\FeedBuilder::build($emails, $selfUrl, $feedTitle)`** builds RSS 2.0 with `content`/`dc`/
  `atom` namespaces via `DOMDocument` (formatOutput off). Per item: `title`, `link` (item URL),
  `pubDate`, non-permalink `guid` (`urn:message-id:…`), `dc:creator`, `author`, and the body in both
  `description` and `content:encoded` (CDATA, split so `]]>` cannot break out). Text-only bodies are
  `htmlspecialchars`-encoded; `removePreheaderPadding()` strips long runs of invisible padding chars.

## Tests

`tests/src/Unit/` covers `EmailSync`, `WebklexImapSource`, `FeedBuilder`, and the two delete forms.
