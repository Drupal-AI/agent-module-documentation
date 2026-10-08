# BlueSky Integration — manual setup guide

**BlueSky Integration** (`bsky`) connects Drupal to Bluesky, the social network
built on the AT Protocol. It is primarily a **building block for other modules**:
it provides the plugins and API client used to post to, and read from, Bluesky,
rather than a ready-made posting screen of its own. (The companion
[Bluesky Post](../../bsky_post/1.0.x/human-docs/index.md) module builds on it to
publish your Drupal content automatically.)

When it talks to Bluesky it makes outbound HTTPS calls to the Bluesky API and
authenticates with your account credentials — in practice a Bluesky **app
password** rather than your main account password. Those credentials are handled
through the **Key** module, which is the right way to keep a secret out of your
exported configuration. It ships in the **Integrations** package and this early
release is **1.0.0-alpha4**.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires the Key module).

## Where it lives in the admin menu

BlueSky Integration mostly works behind the scenes for other modules, so its
main job is to hold your Bluesky credentials as a **Key** entity. See the
credential steps below and in [Installation](installation/index.md).

## How to use it

1. Install and enable `bsky` and the **Key** module (see
   [Installation](installation/index.md)).
2. In Bluesky, create an **app password** for your account (Settings → App
   Passwords) rather than using your real login password.
3. Store that secret safely instead of pasting it into Drupal config. With DDEV,
   put it in an environment variable — for example
   `ddev dotenv set .ddev/.env --bsky-app-password=<value>` then `ddev restart`
   — and never commit `.ddev/.env`.
4. Create a **Key** entity (Configuration → System → Keys) that reads from that
   environment variable, so the secret is referenced by name and never written
   into exported configuration.
5. Point BlueSky Integration at that Key, then let it (or a module built on it,
   such as Bluesky Post) make the authenticated calls to Bluesky over HTTPS.
