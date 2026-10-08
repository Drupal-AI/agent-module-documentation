# Last Tweets — manual setup guide

**Last Tweets** (`last_tweets`) fetches the most recent posts from a given
**X (formerly Twitter)** account and displays them in a block. You can set a
different account per language or use a single account for the whole site, limit
how many posts are shown (three by default), and it ships with basic styling so
the feed looks presentable out of the box.

Under the hood it talks to the **X (Twitter) API** using the
[Abraham TwitterOAuth](https://github.com/abraham/twitteroauth) PHP library and a
set of X application credentials (consumer key/secret and access token/secret).
Because those credentials are secrets, this guide covers storing them safely
rather than pasting them into a form and forgetting about them.

One realistic caveat: **X's API access tiers and terms change frequently**, and
free/low‑cost read access has been repeatedly restricted. Before you rely on this
in production, confirm your X app tier still permits the read calls the module
makes. The module is currently in "maintenance fixes only" status.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   TwitterOAuth library with Composer, then enable it.
2. [Configuration](configuration/index.md) — connect your X account, store the
   API credentials securely, and place the feed block.

## Where it lives in the admin menu

Once enabled, Last Tweets provides a settings form (reachable from the
**Configuration** area) where you enter the X account and API credentials, plus a
**Last Tweets** block you place from **Structure → Block layout**
(`/admin/structure/block`). It also defines its own permission controlling who may
administer the feed.
