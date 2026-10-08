# Telegram integration — manual setup guide

**Telegram integration** (`tg_integration`) connects your Drupal site to Telegram
in two directions. When content is published, it automatically posts an
announcement of the node (or other content entity) to a Telegram channel — by
default the post includes the title and a link back to the node, plus an optional
custom message field. And in the other direction, it can display the comments made
on that Telegram post underneath the content on your site, so the discussion
happening on Telegram surfaces alongside the original.

In short, it lets you syndicate your content to a Telegram audience and bring the
resulting conversation back onto the page. It is configured from its own settings
form and sits in the Web services package. This module supports Drupal 8.8, 9, 10,
and 11, and installs with no other module dependencies.

Two security points are worth keeping in mind. First, the module talks to Telegram
using a **bot token** — treat that token as a secret, because anyone who obtains it
can post as your bot. Store it securely and never commit it. Second, if you enable
the display of Telegram comments on your content, that text is **external, user-
supplied input** coming from Telegram: make sure it is sanitised and escaped on
output so untrusted content cannot inject scripts into your pages. The module has no
access-control role of its own. It is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.
2. [Configuration](configuration/index.md) — connect your Telegram bot and channel
   and choose what gets posted and displayed.

## Where it lives in the admin menu

Once enabled, the module's settings live on its configuration form
(`tg_integration.settings`), where you connect your Telegram bot and choose the
channel to post to and how comments are displayed.
