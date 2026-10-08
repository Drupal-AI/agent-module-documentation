# Proc (Client-side PGP) — manual setup guide

**Proc** (`proc`) brings **client-side, in-browser OpenPGP encryption** to Drupal
using [OpenPGP.js](https://openpgpjs.org/). Content is encrypted in the visitor's
browser *before* it reaches the server, so Drupal only ever stores ciphertext it
cannot read — which means even administrators, sysadmins, or the hosting provider
cannot access the underlying data. The library ships inside the module, so there's
nothing extra to download.

Proc works in two modes. In **stand-alone mode**, it provides forms for
encrypting, decrypting, and re-encrypting arbitrary files or text (re-encryption
is a decrypt-then-encrypt step, handy for updating the set of recipients or
rotating keys). In **field mode**, it provides a field *type* for encrypting and
decrypting files or text from within any fieldable form, plus a field formatter
and an inline decryption mode that decrypts and renders content on the fly — the
project describes the download-decrypt-render flow as smooth enough that users
barely notice the cryptography happening behind it.

The most important thing to understand is the **security model**. Because
encryption happens on the client, security hinges entirely on **key management**:
the private key and its passphrase live with the user, must be protected on the
client, and are never sent to the server. That's the source of Proc's strength —
and its sharpest edge. There is genuinely no server-side recovery: a lost
passphrase means the content encrypted for that key is effectively lost for good.
Client-side JavaScript crypto also depends on the code being delivered over
trusted **HTTPS**, and Proc uses the browser's cache API (which is typically
disabled without HTTPS outside localhost). Confirm the whole key-handling flow
fits your threat model before relying on it, and remember that Proc provides
*encryption*, not access-control gating.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   choose the optional submodules.

There is **no site-wide settings form** in the base module — you use it through
its stand-alone encryption forms and through the encrypted field type you add to
your content, described below.

## How to use it

- **Stand-alone mode** — use the module's encryption / decryption / re-encryption
  forms to encrypt arbitrary files or text, or to re-encrypt existing content for
  a new set of recipients or after a key rotation.
- **Field mode** — add Proc's encrypted **field type** to a content type (or any
  fieldable entity). Content entered there is encrypted client-side on save;
  Proc's field formatter and inline decryption mode handle decryption and
  rendering for permitted recipients when the content is viewed.
- **Manage keys carefully** — protect the private key/passphrase on the client and
  never transmit it to the server. Because lost keys mean lost data, establish a
  key-handling and backup practice with your users before storing anything
  important.
- **Serve over HTTPS** — deliver the site (and therefore the crypto code) over
  trusted HTTPS so the client-side code is trustworthy and the browser cache API
  stays enabled.

## Optional submodules

Proc ships three submodules you can enable as needed: **`proc_janitor`**,
**`proc_metadata_transitioner`**, and **`proc_reporting`**. Enable only the ones
your workflow calls for (see [Installation](installation/index.md)).
