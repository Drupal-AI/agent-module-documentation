# JSON:API Basic Site Settings — manual setup guide

**JSON:API Basic Site Settings** (`jsonapi_site`) exposes a handful of Drupal's
site and theme configuration values over JSON:API, so a decoupled front end can
read them from Drupal instead of hard-coding its own copies. A headless front end
still needs the things a Drupal theme takes for granted — the site name for the
page title, the slogan, the logo path, which page is the front page, where 403 and
404 should go — and because these are *configuration* rather than entities, core
JSON:API has no resource for them. This module fills that gap.

Once enabled, it adds a single read-only endpoint at **`/jsonapi/site/site`**
that returns a JSON:API-shaped document containing: the site name, email, and
slogan; the front-page, 403, and 404 paths; the default language code; the default
and admin themes; and the global logo and favicon paths. There is nothing to
configure in an admin form — the endpoint works as soon as the module is on.

The endpoint is read-only and requires an authenticated caller. Requests
authenticate using the **Key Auth** module (a hard dependency), which is how a
non-browser client identifies itself: a client sends a Key Auth API key belonging
to a user account that holds Key Auth's **"use key authentication"** permission.
Ordinary browser session cookies do not apply to this route, and anonymous
requests are rejected with a 403. In practice you set up an API key for the
account your front end will use and have the front end send that key with each
request.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   bring in its Key Auth dependency.

This module has **no configuration page** — it adds no settings form. Everything
below happens either at the endpoint or in code.

## How to use it

1. Enable the module and its **Key Auth** dependency (see
   [Installation](installation/index.md)), and set up a key for the account your
   front end will use, following Key Auth's own documentation.
2. Have your front end request **`/jsonapi/site/site`**, authenticating with its
   API key. The response is a JSON:API document carrying the site and theme
   settings listed above.
3. Read the values you need from the response rather than duplicating them in the
   front end, so the two stay in step with Drupal.

Pairing this with the **JSON:API Extras** module gives your front end a fuller
picture of the backend API alongside these basic settings.

## Adding or removing values

The module provides an alter hook, `hook_jsonapi_site_data_alter(&$data)`
(documented in the module's `jsonapi_site.api.php`), for a custom module to adjust
the payload. Use it to **add** your own values for a bespoke client, or to
change or remove any of the default attributes so the response matches exactly
what your front end expects.
