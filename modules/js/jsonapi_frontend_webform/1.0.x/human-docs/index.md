# JSON:API Frontend Webform — manual setup guide

**JSON:API Frontend Webform** (`jsonapi_frontend_webform`) is an optional add-on
for the [JSON:API Frontend](https://www.drupal.org/project/jsonapi_frontend)
module that teaches the resolver how to handle **Webform** pages in a hybrid
headless setup. Drupal Webforms are interactive routes rather than JSON:API
content entities — they need Drupal's server-side rendering and submission
handling — so a decoupled front end cannot simply render them client-side like a
node.

This add-on extends `/jsonapi/resolve` so that Webform routes (including aliased
paths such as `/contact`, which maps to `/form/contact`) resolve as
**non-headless**. In the resolve response it returns a `drupal_url`, which tells
your front end to redirect or proxy the visitor to Drupal for the actual form —
no iframes required. It also respects route access, treating a restricted form as
"not found" rather than exposing its existence.

The approach here is deliberately hybrid-first and cross-framework: rather than
attempting fully headless form rendering and submission, it keeps forms where they
already work (on Drupal) and just makes the front end aware of that. There is no
admin settings form of its own — the configuration you care about lives on the
base JSON:API Frontend module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Webform and JSON:API Frontend.

## Where it lives in the admin menu

This module adds **no admin page** and has no settings form. The settings that
matter are on the base **JSON:API Frontend** module at **Configuration → Web
services → JSON:API Frontend** (`/admin/config/services/jsonapi-frontend`) — in
particular your Drupal URL/origin and proxy secret if you use frontend-first mode.

## How to use it

1. Enable **Webform**, **JSON:API Frontend**, and then this module.
2. Configure JSON:API Frontend at `/admin/config/services/jsonapi-frontend`,
   especially the Drupal URL/origin and (for frontend-first setups) the proxy
   secret.
3. Make sure your front end's routing/proxy forwards Webform routes — typically
   `/form/*` — to Drupal, whether you run in split-routing or frontend-first mode.

With that in place, when your front end resolves a Webform path it receives a
`drupal_url` and knows to hand the visitor over to Drupal to render and submit the
form.
