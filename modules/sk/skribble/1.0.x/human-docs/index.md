# Skribble Integration — manual setup guide

**Skribble Integration** (`skribble`) connects your Drupal site to the
[skribble.com](https://skribble.com) e-signature service so you can send a
document for electronic signing and store the finished, signed PDF back on your
site. The typical flow is: the module creates a signature request from a file,
redirects the signer to skribble.com to sign, and — when they return — fetches
the authoritative status from Skribble and, only once the document is genuinely
signed, downloads the signed PDF into your site's private files
(`private://skribble/`).

Under the hood the module tracks each request as its own
`skribble_signing_request` entity, so you can see and manage signing requests
alongside your content. It offers two ways to hand the source document to
Skribble: a base64-encoded upload, or a protected fetch URL that Skribble
retrieves from your server. That fetch URL is not a plain public link — it is an
HMAC-signed, time-limited download route, so the file cannot be grabbed by
guessing the address. Every step in the flow can be customised from your own
module through the hooks documented in the module's `skribble.api.php` file.

The module needs configuration before it does anything: you must enter your
Skribble account credentials and choose your options on its settings form. It has
no dependencies on other contrib modules and runs on Drupal 10 and 11. It also
adds permissions for administering and working with signing-request entities.

A note on security: credentials live in Drupal configuration (not hard-coded),
API calls use normal TLS verification, and the optional "success callback"
endpoint that Skribble can call is deliberately safe — it identifies a request by
an unguessable ID and re-checks the real status with an authenticated API call
before marking anything as signed, so a forged callback cannot fake a completed
signature.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Skribble credentials and
   choose your signing options.

## Where it lives in the admin menu

- **Settings:** **Configuration → Web services → Skribble**
  (`/admin/config/services/skribble`) — enter your Skribble user and API key and
  choose your options. Requires the *Administer site configuration* permission.
- **Signing requests:** the `skribble_signing_request` entities are administered
  at `admin/structure/skribble-signing-request`, with their own view/create/edit/
  delete permissions, and are listed under **Content**.
