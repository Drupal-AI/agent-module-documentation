# Media Entity Twitter — manual setup guide

**Media Entity Twitter** (`media_entity_twitter`) adds a "Twitter" *media source*
to Drupal's core Media system, so editors can reference a Twitter/X post just by
pasting its URL and have it render as a live, embedded tweet. Tweets become
first‑class, reusable media entities — the same way images or remote videos do —
that you can add through the Media Library and reference from any content type.

Under the hood the module registers a media source plugin (id `twitter`). You
create a Media type whose source is "Twitter," give it a source field for the
tweet URL, and the module extracts the tweet's `id` and author `user` from
twitter.com/x.com status URLs. Out of the box — with no API keys at all — that is
enough to embed tweets and show a default icon thumbnail. If you supply Twitter
API credentials, the module can pull much richer metadata (the tweet text,
retweet count, author name, attached image, profile image, created time) and map
those onto fields.

Display is handled by a **Twitter embed** field formatter, which renders the
tweet with Twitter's own `widgets.js` so it looks and behaves like a native
embed. There is no standalone admin settings page — everything is configured on
the Media type's source form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Twitter API library) and enable the module.
2. [Configuration](configuration/index.md) — create the Twitter media type, set
   the source field, optionally add API credentials, and choose the embed
   formatter.

## Where it lives in the admin menu

There is no dedicated settings page. You work on core Media's screens: create the
type at **Structure → Media types → Add media type**
(`/admin/structure/media/add`) and configure its source and display under
**Structure → Media types → (your type) → Manage fields / Manage display**.

## How to use it

Once the Twitter media type exists, editors add a tweet by opening the Media
Library (or the media type's add form) and pasting a tweet URL into the "Tweet
URL" field. Reference that media from a node via a Media reference field, and the
Twitter embed formatter renders the interactive tweet on the page.
