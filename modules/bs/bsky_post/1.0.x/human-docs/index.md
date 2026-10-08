# Bluesky Post — manual setup guide

**Bluesky Post** (`bsky_post`) publishes your Drupal content to a Bluesky
account. When content is published, it creates a matching post on the Bluesky
account you have configured, so social sharing to the Bluesky / AT Protocol
network happens automatically instead of by hand.

It builds on the [BlueSky Integration](../../bsky/1.0.x/human-docs/index.md)
(`bsky`) module, which does the actual talking to Bluesky and holds the account
credentials. Bluesky Post adds the "post my content when it's published" layer on
top. It defines two permissions: **administer bsky_post configuration** for
setting the module up, and **post to bluesky** for the ability to publish posts.

Because credentials live in the underlying `bsky` module, they are kept out of
configuration and backed by an environment variable / Key entity — see that
module's guide for the secret-handling steps. Bluesky Post supports Drupal 10 and
11; this early release is **1.0.0-alpha3**.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires `bsky`).

## Where it lives in the admin menu

Configuration is gated by the **administer bsky_post configuration** permission,
where you choose the Bluesky account (through the `bsky` module) that posts are
sent to. The credentials themselves are configured in the `bsky` module — see
[BlueSky Integration](../../bsky/1.0.x/human-docs/index.md).

## How to use it

1. Install and configure `bsky` first, including storing your Bluesky app
   password securely as described in its guide.
2. Install and enable `bsky_post` (see [Installation](installation/index.md)).
3. Grant **administer bsky_post configuration** to a trusted admin and **post to
   bluesky** to the roles allowed to publish to Bluesky.
4. Configure which account posts go to, then publish content — a Bluesky post is
   created automatically.
