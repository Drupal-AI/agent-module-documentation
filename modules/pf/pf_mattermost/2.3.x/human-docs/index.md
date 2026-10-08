# Push Framework Mattermost — manual setup guide

**Push Framework Mattermost** (`pf_mattermost`) adds a **Mattermost channel** to
the [Push Framework](https://www.drupal.org/project/push_framework), so your
Drupal site can post notification content straight into a **Mattermost channel**.
It's an easy way to route site events — content changes, admin/ops alerts,
DANSE‑driven notifications — into the team chat where people are already watching,
rather than into an inbox.

Under the hood it authenticates to Mattermost with a **personal access token**,
converts the notification's HTML into Markdown/plain text, and creates a post in
the target channel using the Gnello Mattermost PHP driver (over Guzzle, with
normal TLS certificate verification in place). It also provides a **DANSE
recipient‑selection plugin**, so if you use DANSE you can select Mattermost as a
recipient for content events.

To connect it you need three things from Mattermost: your server's **domain/URL**,
a **personal access token**, and the **id of the channel** you want to post to.
Those are entered on the module's settings form. The token is stored in the
module's configuration (in plain text — standard for this channel), so restrict
who can reach the settings form and generate a token with only the access it
needs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Push Framework.
2. [Configuration](configuration/index.md) — enter your Mattermost domain, token,
   and channel id, and enable the channel.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Push framework → Mattermost**
(`/admin/config/system/push_framework/mattermost`), gated by the *Administer site
configuration* permission. See [Configuration](configuration/index.md).
