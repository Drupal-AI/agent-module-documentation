# Social Post X — manual setup guide

**Social Post X** (`social_post_x`) is a provider module for
[Social Post](../../../social_post/3.0.x/human-docs/index.md) that lets a Drupal
site post content automatically to an X account (formerly Twitter) through the X
API. It builds on the Social Post framework, so it is a plug-in rather than a
standalone tool.

You connect it by supplying X API OAuth credentials on its settings form. It
provides its own permissions and runs on a wide range of Drupal versions (8.8, 9,
10 and 11). It has no access-control role beyond that permission — its job is
simply to authenticate to the X API and post.

A few things to be deliberate about. Store the X OAuth **credentials and tokens
as secrets** — in an environment variable or a Key entity, not in exported
configuration that lands in version control. The module talks to the X API over
HTTPS. And because a public post reaches your whole audience the moment it is
sent, restrict who can trigger posts and be considered about what gets
auto-posted.

This guide is written for a **human** setting the integration up through the
admin UI. If you want terse, token-cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — entering the X API credentials.

## Where it lives in the admin menu

The module provides its own settings form (config route
`social_post_x.settings_form`) where you enter the X API credentials. Its posting
integration also appears within Social Post's integrations page at
**Configuration → Social API → Social Post**.
