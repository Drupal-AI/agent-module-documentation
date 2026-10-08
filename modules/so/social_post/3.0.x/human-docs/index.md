# Social Post — manual setup guide

**Social Post** (`social_post`) is the autoposting arm of the Social API family
of modules. Its job is to store each user's connection to a social network and to
push site content out to those networks automatically. The actual network
implementations — Twitter/X, Facebook, Mastodon and so on — ship as separate
provider modules that plug into this one.

Social API is split into three siblings: Social Auth (log in with a social
account), Social Widgets (embed social content), and Social Post (publish out).
This module owns the last of those. It defines a `social_post` content entity
that records the association between a Drupal user and a social account — the
user, the provider, the account identifier, a name and link, and, importantly, the
**OAuth access token** used to post on that user's behalf. Around that sit a post
manager, a data handler, a plugin manager for the network implementations, and an
admin page that lists the installed integrations.

The key thing to understand is that **Social Post does nothing visible on its
own**. Until you install at least one provider module, its integrations page is
empty. It requires PHP 8.1 or newer, the Social API module (`^4`) and core's Link
module, and runs on Drupal 9.5, 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the integrations page, the
   permissions, and stored-token handling.

## Where it lives in the admin menu

The integrations listing is at **Configuration → Social API → Social Post**
(`/admin/config/social-api/social-post`). It lists whichever provider modules you
have installed; installing Social Post by itself leaves it empty.

## Before you begin

The `social_post` entity stores each connection's OAuth access token. Treat
backups accordingly and scope the tokens minimally at the provider; see
[Configuration](configuration/index.md) for details.
