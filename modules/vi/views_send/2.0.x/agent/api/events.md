# Views Send — events & services (for Rules and custom code)

## Symfony events (`src/Event/`)

Dispatched around sending/spooling; also surfaced to the **Rules** module via
`views_send.rules.events.yml`:

- `MailAddedEvent` (`views_send.mail_added`) — a single message was added to the spool.
- `AllMailAddedEvent` (`views_send.all_mail_added`) — a batch of messages finished being added
  to the spool.
- `MailSentEvent` (`views_send.mail_sent`) — a message was sent.

Subscribe with a normal `EventSubscriberInterface` service, or react in Rules if the Rules
module is enabled.

## Mail assembly (`hook_mail`)

`views_send_mail($key, &$message, $params)` builds the outgoing message for key `direct`:
sets `subject`, `body`, and merges `$params['headers']` into `$message['headers']`. The `node`
key is a stub (`@todo`). Header assembly lives in `_views_send_headers()` (priority/receipt
headers + `Precedence: bulk` + the user's "Additional headers", parsed one `Key: Value` per
line).

## Service

- `views_send.mime` (`Service\ViewsSendMime`, interface `ViewsSendMimeInterface`) — MIME/HTML
  handling, gated on the Mime Mail module (`module_handler` injected). Used when producing HTML
  bodies / attachments.

## Storage

Spooled messages live in the `views_send_spool` DB table (subject is HTML-stripped on insert;
recipients come from the selected View rows). Cron drains it via
`views_send_send_from_spool()` / `views_send_clear_spool()`.
