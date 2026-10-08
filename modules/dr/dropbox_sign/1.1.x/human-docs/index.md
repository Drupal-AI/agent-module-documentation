# Dropbox Sign — manual setup guide

**Dropbox Sign** (`dropbox_sign`) integrates the
[Dropbox Sign](https://sign.dropbox.com) electronic‑signature API (formerly
HelloSign) into Drupal. It lets your site generate and process eSignature
requests — sending documents out for signing (embedded in your own pages or by
email) and handling the status callbacks Dropbox Sign sends back when signers act.
It's the modern successor to the old HelloSign module, updated for Dropbox Sign's
current API.

This is primarily a developer‑facing integration: it exposes a Drupal service
(`dropbox_sign`) that your code calls to create signature requests, fetch signing
URLs, and cancel or manage requests, plus a template placeholder tag
(`[sig|req|signer1]`) for embedding signature fields in document templates. The
admin side is a single settings form where you enter your Dropbox Sign
credentials and a few options. It depends on the **Encryption** module and
requires the **Dropbox Sign PHP SDK**.

Because this handles legally meaningful signatures and sends documents to a
third‑party service, security matters. The module stores your API key
**encrypted** (via the Encryption module) and decrypts it only at the point of
use, and its public callback endpoint verifies the authenticity of each incoming
event with an HMAC hash and rejects replays. On your side, keep the API key
protected, always talk to Dropbox Sign over HTTPS, and remember that the documents
and signer data involved are sensitive and handled by Dropbox Sign under their
terms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Dropbox Sign PHP SDK), enable the module and its Encryption dependency.
2. [Configuration](configuration/index.md) — enter your API key and client ID,
   set CC addresses and test mode, and handle the API key securely.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → System → Dropbox Sign
API** (`/admin/config/system/dropbox-sign`). The module also registers a public
callback route (`/process-dropbox-sign-callback`) that Dropbox Sign posts to when
signature events occur — you don't visit this yourself; you register its URL in
your Dropbox Sign account.

## How to use it

1. Create a Dropbox Sign account and, within it, a client for your domain (this
   yields the client ID).
2. Install and enable the module and the Dropbox Sign PHP SDK (see
   [Installation](installation/index.md)).
3. Enter your API key and client ID on the settings form and set your options
   (see [Configuration](configuration/index.md)).
4. In your custom code, call the `dropbox_sign` service to create signature
   requests and fetch signing URLs — for example
   `\Drupal::service('dropbox_sign')->getSignatureRequestApi()` and
   `->createSignatureRequest(...)`.
5. Register the callback URL in your Dropbox Sign account so status updates flow
   back to your site.
