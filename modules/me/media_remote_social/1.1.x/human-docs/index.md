# Media Remote Social — manual setup guide

**Media Remote Social** (`media_remote_social`) adds a ready-made "Remote social"
media type so editors can embed Facebook and Instagram posts as ordinary Drupal
media. It builds on the oEmbed support already in core's Media module, extending it
to cover these two social providers, so a pasted post URL is turned into a proper
embed that displays inside your site.

Under the hood it stores the Facebook/Instagram oEmbed **access token** through the
[Key](https://www.drupal.org/project/key) module rather than in plain
configuration, which keeps the credential out of your exported config and version
control. Because of that, the module depends on both core **Media** and **Key**,
and it defines its own permissions.

Keep in mind that the embedded posts are **remote content pulled from Facebook and
Instagram at display time** — your visitors' browsers load markup and assets from
those platforms, so the usual third-party embedding and privacy considerations
apply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Media and Key dependencies.

This module has **no settings form of its own**. Setup happens on the media type it
provides and on a Key entity that holds your access token — both described under
"How to use it" below.

## How to use it

1. Store your Facebook/Instagram oEmbed **access token** as a
   [Key](https://www.drupal.org/project/key). Go to **Configuration → System →
   Keys** (`/admin/config/system/keys`), add a key, and choose a secret-friendly
   provider (for example the environment-variable provider) so the token is never
   written into plain config. Keeping credentials in environment variables via Key
   is the recommended pattern on this site.
2. Point the module's "Remote social" media type at that key so it can authenticate
   its oEmbed requests to the providers.
3. Grant the module's permissions to the roles that should create or manage remote
   social media, at **People → Permissions** (`/admin/people/permissions`).
4. Editors can now add a Facebook or Instagram post by creating a **Remote social**
   media item and supplying the post URL — the post renders as an embed wherever
   that media is displayed.
