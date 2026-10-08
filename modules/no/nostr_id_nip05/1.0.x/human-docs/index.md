# Nostr internet identifier (NIP-05) — manual setup guide

**Nostr internet identifier (NIP-05)** (`nostr_id_nip05`) turns your Drupal site
into the authority for one or more **NIP‑05** identifiers — the `name@domain`
handles used on the **Nostr** network. It serves the standard
`/.well-known/nostr.json` file, which maps names to Nostr **public keys**, so Nostr
clients can verify that a handle really belongs to your domain.

The mechanism is simple. Most Nostr clients make a request like
`https://example.com/.well-known/nostr.json?name=bob` and expect a JSON document
with a `names` object mapping each name to a hex‑formatted public key, for example:

```json
{ "names": { "bob": "b0635d6a9851d3aed0cd6c495b282167acf761729078d975fc341b22650b07b9" } }
```

If the returned key matches the key in the user's Nostr profile, the client
concludes the handle is genuinely tied to your domain. You maintain that mapping
through an admin settings form.

Everything this module publishes is **public by design** — the `/.well-known/nostr.json`
endpoint exposes public keys only, and it is meant to be readable by anyone. There
are no private keys involved and nothing secret to protect here. It supports Drupal
10 and 11 with no third‑party dependencies. Related modules are **Nostr Simple
Publish** and **Nostr long-form content (NIP‑23)**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the name → public‑key mappings
   that populate `/.well-known/nostr.json`.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Nostr internet
identifier (NIP‑05)** (`/admin/config/system/nostr-id-nip05`). The public file it
serves is at `/.well-known/nostr.json` on your domain.
