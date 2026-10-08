# Instagram Sync — manual setup guide

**Instagram Sync** (`instagram_sync`) imports Instagram posts into your Drupal
site and stores them as content. Instead of embedding a live third‑party widget,
it pulls posts — images, videos and carousels — from an Instagram account through
the Instagram API and saves them as a custom entity, so you can then display them
however you like: in Views, blocks, or anywhere else you would use entities.

Once connected, it can **auto‑sync** on a schedule you choose, keeping your local
copy of the feed fresh, and it can skip loading media data you don't need to keep
the import lean. Authentication uses a long‑lived Instagram access token that you
generate through the Instagram API and paste into the module's settings.

Because the module authenticates to Instagram/Meta with an access token, treat
that token as a secret: store it securely, keep the connection on HTTPS, and
refresh the token per Meta's policy before it expires. Imported posts are external
content, so they are escaped on display like any other untrusted text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Instagram account and
   set up the import.

## Where it lives in the admin menu

Instagram Sync adds a settings form under **Configuration** (the
`instagram_sync.settings_form` route). This is where you paste the access token
and configure the import; see [Configuration](configuration/index.md).

## How to use it

After you connect the account on the settings form and the first sync runs, the
imported posts exist as entities in Drupal. Build a **View** over the Instagram
post entity (or place a block) to render them as a feed on your site, styled to
match your theme.
