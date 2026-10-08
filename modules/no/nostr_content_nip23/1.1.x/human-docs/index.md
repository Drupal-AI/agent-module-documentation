# Nostr long-form content (NIP-23) — manual setup guide

**Nostr long-form content (NIP-23)** (`nostr_content_nip23`) publishes your
long‑form, Markdown‑formatted Drupal content to the **Nostr** network — the
decentralised social protocol — as NIP‑23 long‑form events (event kinds 30023 and
30024). Once published, any Nostr client that supports reading those event kinds
can display your content, so a Drupal article can reach the wider Nostr ecosystem.

The content of a NIP‑23 event must be Markdown, and an event can be sent to
multiple relays. This is a young module (a 1.1.x alpha) and currently works for a
**single Drupal user**. It relates to two sibling modules you may want alongside it:
**Nostr Simple Publish** (for short notes) and **Nostr internet identifier
(NIP‑05)** (for a verifiable `name@domain` handle).

Because Nostr events are cryptographically signed, the module signs with your
**Nostr private key (nsec)**. Treat that key as a secret: keep it in an environment
variable (or a key file **outside your web root**), never commit it to version
control, and never paste it where it could be exported with configuration. Anyone
who obtains the private key can post to Nostr as you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — check the PHP/GMP requirement, install
   with Composer, and enable it.

There is **no admin settings form** for this module. Its one piece of setup — the
signing key — is handled outside the UI and described below.

## Signing key and relays

To sign and broadcast events the module needs your Nostr key material. Keep the
**private key** secret:

- Store the private key in an **environment variable** on this project rather than
  in the database or configuration. With DDEV you can save it without committing it:

  ```bash
  ddev dotenv set .ddev/.env --nostr-private-key=<hex-private-key>
  ddev restart
  ```

  (The flag `--nostr-private-key` becomes the variable `NOSTR_PRIVATE_KEY` inside
  the web container.) If you instead keep the key in a file, put that file
  **outside the web root** so it can never be served.
- Nostr keys are used in their **hex** form here, not the bech32 `npub`/`nsec`
  form. Convert with a tool such as `https://damus.io/key/` if needed.
- Content is broadcast to one or more **relays**; pick relays you trust (find
  options at `https://nostr.watch`).

Never commit the private key, and rotate it if you suspect it has been exposed.
