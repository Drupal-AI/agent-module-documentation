# Fediverse Social Link Field — manual setup guide

**Fediverse Social Link Field** (`fediverse_social_link_field`) extends the
[Social Link Field](https://www.drupal.org/project/social_link_field) module with
support for **Fediverse** networks. It adds four platform options: a generic
**Fediverse** option plus **Mastodon**, **Lemmy**, and **Hubzilla**. With it, a
Social Link Field on any entity can store and display links to Fediverse accounts, so
profiles and content can point at someone's Mastodon, Lemmy, or Hubzilla presence
just as they already can for the mainstream networks Social Link Field ships with.
The generic Fediverse option covers other ActivityPub services (such as PeerTube)
that do not have a dedicated platform.

It is a small add‑on: it simply adds the Fediverse platform options to Social Link
Field, which does the actual field, widget, and display work. There is no settings
page of its own — you configure everything on the Social Link Field you add to an
entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Social Link Field).

There is **no dedicated configuration page** — the Fediverse platforms simply become
available on Social Link Fields, which you configure per field as described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); it registers the
   Fediverse platforms with Social Link Field.
2. Add or edit a **Social Link Field** on the entity you want (for example a user
   profile or a content type) at that bundle's **Manage fields**.
3. In the field's settings and on the entity edit form, the Fediverse networks
   (a generic Fediverse option, Mastodon, Lemmy, and Hubzilla) now appear among the
   platform choices — add the
   account links you need.
4. Configure how the links show on the entity's **Manage display**, using Social
   Link Field's formatter as usual.
