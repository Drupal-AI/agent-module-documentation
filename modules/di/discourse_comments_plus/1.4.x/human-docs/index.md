# Discourse comments (+) — manual setup guide

**Discourse comments (+)** (`discourse_comments_plus`) connects Drupal to
[Discourse](https://www.discourse.org/), the open‑source discussion platform, so
that the conversation about a piece of Drupal content lives in a Discourse topic
while still being shown on the Drupal page. In effect, Discourse becomes your
comment system: discussion happens over there, but your visitors read (and, with
the "plus" features, contribute to) it right on the node.

The problem it solves is running a serious community discussion without building or
maintaining a forum inside Drupal. Discourse handles the hard parts — moderation,
notifications, trust levels, spam control — and this module bridges the two: it can
**publish a Drupal node as a Discourse topic**, **pull the topic's posts back** to
show as comments on the node, and (the "+" part) let visitors **log in to Discourse
via SSO and comment directly from Drupal**.

The module needs configuration before it works: you must supply your Discourse API
credentials (and, for the SSO features, an SSO secret). It depends on Drupal core's
**Field** module. Note that this module is *not* covered by Drupal's security
advisory policy, so weigh that when deciding to use it on a sensitive site, and
guard the API credentials carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Discourse API keys and SSO
   secret, then publish content and place the comments block.

## Where it lives in the admin menu

The settings form is at **Configuration → Discourse Comments → Discourse comments
settings** (`/admin/config/discourse_comments/discourse_comments_settings`). See
[Configuration](configuration/index.md) for the full workflow, including publishing
a node to Discourse and placing the comments block.
