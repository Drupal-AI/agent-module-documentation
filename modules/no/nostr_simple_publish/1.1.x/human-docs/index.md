# Nostr Simple Publish — manual setup guide

**Nostr Simple Publish** (`nostr_simple_publish`) is a small, deliberately
opinionated module for broadcasting **short notes** from Drupal to the **Nostr**
network, the decentralised social protocol. It adds a **"Publish to Nostr"**
fieldset to node forms so that, when you save a node, its content can be announced
to a Nostr relay and appear in Nostr clients.

By default it takes the note text from the node's **body** field (you can point it
at a different field), signs the event with your Nostr key, and sends it to the
configured relay. Once a node has been published it can't be published again — the
resulting Nostr event id is recorded in the module's `nostr_simple_publish` table.
The fieldset is protected by a **publish to nostr network** permission, and a
separate permission governs who can view the debug output after a post attempt.

This is an early alpha and, by design, is **not** a full Nostr client or relay —
it does one thing. It currently works for a **single Drupal user**. It relates to
two sibling modules: **Nostr long-form content (NIP‑23)** for Markdown articles,
and **Nostr internet identifier (NIP‑05)** for a verifiable `name@domain` handle.

Publishing requires your Nostr **public and private keys** plus a relay. The
private key is a secret — keep the key files **outside your web root** and never
commit them. Anyone who obtains the private key can post to Nostr as you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — check the PHP/GMP requirement, install
   with Composer, and enable it.
2. [Configuration](configuration/index.md) — provide your keys and relay in
   `settings.php`, grant the permissions, and choose which field is published.

## Where it lives in the admin menu

There is no central admin settings form. Configuration is done in
**`settings.php`** (keys, relay, content fields) and on **People → Permissions**
(`/admin/people/permissions`). The actual publishing happens from the **"Publish to
Nostr"** fieldset on the node edit form.
