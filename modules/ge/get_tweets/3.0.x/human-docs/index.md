# Get Tweets — manual setup guide

**Get Tweets** (`get_tweets`) imports posts from **X/Twitter** into your Drupal
site as **nodes**. On a schedule (via cron) it pulls tweets from one or more
feeds — by hashtag or by user name — and stores each tweet, along with its data,
as native content you can display, theme, and archive like anything else on the
site.

It can import several feeds at once, create linked URLs from the URLs, hashtags,
and mentions inside a tweet, pull hashtags/mentions/images into separate fields
(saving both the external image link and a local copy), and optionally delete old
tweets so the archive doesn't grow forever.

A few important caveats before you start. The module supports **only the paid
Twitter v1.1 API** — API v2 is not supported, and fetching tweets requires a paid
X/Twitter subscription. You must **register an application** with X/Twitter first
to obtain a **Consumer Key** and **Consumer Secret**. Because imported tweets are
external data, treat their text and media as untrusted input when you display
them, and be mindful of X/Twitter's API terms and rate limits.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register your X/Twitter app, store
   the API credentials safely, and set up the feeds you want to import.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Web services → Get
Tweets** (`/admin/config/services/get-tweets`), where you enter your API
credentials and configure the import.

## How to use it

At a high level: register an app with X/Twitter to get your Consumer Key and
Secret, store those credentials, tell the module which accounts or hashtags to
follow, and then let cron do the importing. Each run brings new tweets in as
nodes. See [Configuration](configuration/index.md) for the step‑by‑step.
