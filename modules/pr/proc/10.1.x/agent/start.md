<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Proc (Client-side PGP) — agent index

Provides **client-side (browser) OpenPGP encryption via OpenPGP.js** (server stores ciphertext it can't read;
`proc_janitor`/`proc_metadata_transitioner`/`proc_reporting` submodules). Depends on core `file`, `options`,
`user`, `views`. Provides permissions. Version **10.1.123**. Core `^9||^10||^11`.

Security/privacy — encryption is **client-side**: security hinges on **key management** (protect the private key
on the client, never send it to the server; lost keys = lost data; trusted HTTPS delivery). Encryption, not
access gating.
