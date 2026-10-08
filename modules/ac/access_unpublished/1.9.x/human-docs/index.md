# Access Unpublished — manual setup guide

**Access Unpublished** (`access_unpublished`) lets you share a private preview link
to a single piece of unpublished content — so a proofreader, client, or reviewer can
see a draft **without needing a Drupal account**. Think of it as the Google-Docs-style
"anyone with the link can view" for your unpublished nodes.

It works by generating **access tokens**. From the edit form of any unpublished
content, you click **Generate token** and the module hands you a shareable URL — the
normal page URL with a secret token added as a query parameter (by default
`?auHash=…`). Anyone who opens that URL can view that one unpublished item, **view
only, never edit**, for as long as the token is valid. Tokens can expire after a set
lifetime (a day, a week, and so on) or never expire, and you can revoke a link
instantly by deleting its token.

Because access is granted per token *and* per permission, you stay in control: a role
(even the anonymous role) can only preview via a link if you've granted it the
matching per-content-type permission, and you can scope that to specific bundles
(e.g. only articles). Optional extras include automatically deleting tokens when
content is published, letting cron clean up expired tokens, and adding HTTP headers
such as `X-Robots-Tag: noindex` on token-viewed pages to keep drafts out of search
engines.

The module depends only on core's **Options** module and adds an `access_token`
content entity behind the scenes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the token manager service, the
`access_token` entity, and the duration-options hook — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — generate and share a token, manage the
   token list, grant the right permissions, and tune the global settings.

## Where it lives in the admin menu

- **Generate a token** — on the edit form of any unpublished content, in the advanced
  sidebar under **Temporary unpublished access**.
- **All issued tokens** — **Content → Access Tokens**
  (`/admin/content/access_token`), where you can renew or delete them.
- **Global settings** — **Configuration → Content authoring → Access Unpublished**
  (`/admin/config/content/access_unpublished`).
