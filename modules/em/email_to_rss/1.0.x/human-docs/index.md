# Email to RSS — manual setup guide

**Email to RSS** (`email_to_rss`) turns the messages in an IMAP mailbox folder
into a private RSS feed, so newsletters and other email‑only content can be read
in any feed reader instead of cluttering your inbox. You point it at an IMAP
account and folder, it fetches the messages, and Drupal publishes them as an
RSS 2.0 feed at a secret, token‑protected URL.

It is the reverse of Drupal core's Aggregator (which *consumes* feeds): Email to
RSS *produces* a feed from email. It fetches messages on a schedule via cron (or
on demand), supports HTML bodies through `content:encoded`, deduplicates by
Message‑ID, and gives you manual **Sync now** and **Delete all entries** actions.
It has no other module dependencies, but it does need the `webklex/php-imap`
library (installed automatically with Composer) and an IMAP‑accessible mailbox.

The module needs configuration before it does anything: you must supply the IMAP
connection details and set the mailbox password through an environment variable.
Two things are security‑sensitive and worth understanding up front. First, the
feed URL contains a secret **token** and is otherwise public — anyone who has the
link can read the email content, and links can leak through browser history, the
`Referer` header, proxy logs, or casual sharing. Treat the URL as a password, use
a high‑entropy token, prefer HTTPS, and don't point the feed at a mailbox that
holds confidential mail. Second, the IMAP password is deliberately kept out of
Drupal configuration and read from an environment variable instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   the IMAP library) and enable the module.
2. [Configuration](configuration/index.md) — set up the IMAP connection, the
   password environment variable, and the feed, then run a sync.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Web services → Email to
RSS**. That page is where you enter the IMAP host, port, encryption, username and
folder, set the feed entry limit, see the private feed URL, and use the **Sync
now** and **Delete all entries** actions.
