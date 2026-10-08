# Social Feeds Block — manual setup guide

**Social Feeds Block** (`social_feeds_block`) renders recent posts from seven
social networks as ordinary Drupal blocks, each one fed live by that network's
official HTTP API using credentials you configure. The supported networks are
Facebook, X/Twitter, Instagram, Pinterest, YouTube, LinkedIn and Google Business
Profile.

Each network is configured independently on its own settings form, and each has
its own block plugin (for example "Facebook Posts", "Instagram Posts"), so you can
place different networks in different regions and show only the ones you use.
Behind the scenes a per-network "post collector" service fetches and caches the
posts through Drupal's HTTP client, hitting each provider's fixed HTTPS API host,
and the block renders the cached results. Caching means you can control how often
the feeds refresh, which also keeps you within each provider's API quota.

The module needs configuration before anything appears — it does nothing on
enable. You obtain API tokens or app credentials from each provider, enter them
on the relevant settings form, and then place the matching block. All of the
configuration forms, and the Instagram OAuth token-exchange route, are gated by
the **administer social_feeds_block** permission, which is marked as a restricted
permission — grant it only to trusted administrators. It requires Drupal 10.3 or
11 and PHP 8.2, and depends only on core.

A note on security worth carrying into setup: every outbound API host is a fixed
HTTPS address baked into the code (there are no request-supplied URLs, so no
server-side request forgery), and TLS verification is left at its safe default.
Be aware, though, that some Facebook Graph calls place the access token in the URL
query string, which means it can surface in server or proxy logs — keep those
logs protected accordingly.

This guide is written for a **human** setting the feeds up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per-network settings forms, the
   Instagram OAuth step, and placing the blocks.

## Where it lives in the admin menu

The module's configuration hub is at **Configuration → Web services → Social
Feeds Block** (`/admin/config/services/social-feeds-block`), from which a menu
links to each network's form. The blocks themselves are placed through
**Structure → Block layout**.
