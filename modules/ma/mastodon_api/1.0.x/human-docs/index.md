# Mastodon API — manual setup guide

**Mastodon API** (`mastodon_api`) integrates Drupal with the **Mastodon API**, the
interface to the decentralised, federated social network (the "fediverse"). It lets
you **"toot"** — post statuses — to a Mastodon instance from within the Drupal admin
interface, and acts as a base client that other modules can build on to post
statuses, fetch timelines, or otherwise interact with Mastodon. It has few
dependencies, so it fits into most Drupal sites.

You can register more than one Mastodon **instance** to connect to, validate each
one's authentication, pull an instance's configuration, and then push a status from
the "Push Status" tab, choosing which instance to send to. An optional submodule,
**Mastodon API Entity**, attaches the push form to a content entity type and
pre‑fills it with that entity's content, so you can format an item and toot it with
one click.

> **Handle the access token as a secret.** Authentication to Mastodon is done with
> an access token per instance. The module deliberately **never stores the token in
> the site's exported configuration** — that would be a security risk — so it keeps
> it in the Drupal **State API** (which lives with the database) or lets you provide
> it from `settings.php` for secure deployment. Do not commit the token to version
> control, and treat it like any other credential. See
> [Configuration](configuration/index.md) for the safe ways to store it. This
> module also makes **outbound network requests** to whatever Mastodon instance you
> configure, so it needs egress to that host.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create the Mastodon application,
   connect one or more instances, store the token securely, and send your first
   toot.

## Where it lives in the admin menu

The configuration lives at **Configuration → Web services → Mastodon API**
(`/admin/config/services/mastodon`), with sub‑tabs for **Instances**, **Validate
Auth**, **Push Status**, and (with the submodule) **Entity**.
