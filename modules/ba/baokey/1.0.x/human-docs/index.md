# BaoKey — manual setup guide

**BaoKey** (`baokey`) is a key provider for Drupal's **Key** module that reads
secrets from an [OpenBAO](https://openbao.org) — or HashiCorp Vault — **KV
version 2** secrets engine over HTTP. OpenBAO is the open-source fork of Vault. In
plain terms: instead of storing an API key, password or encryption key inside
Drupal, you keep it in your vault, and BaoKey fetches it on demand whenever
Drupal's Key API asks for it.

The benefit is that secrets never live in Drupal's configuration or database.
They stay in OpenBAO, where they can be rotated and audited centrally, and Drupal
consumes them through the same standard Key API that other providers (environment
variable, file, config) plug into. You can use it for both authentication keys
and encryption keys, and it will optionally strip trailing line breaks or
Base64-decode a value on the way out.

When a key is read, BaoKey issues an authenticated `GET` to
`{vault_url}/v1/{path}` using an `X-Vault-Token` header and returns the matching
value; it matches the requested key by the Key entity's label within the secret
payload. The HTTP call uses Guzzle's **default TLS certificate verification** —
TLS is not disabled — and the connection URL and token are read from
`settings.php`, not from the database. Read failures are logged to the `baokey`
channel and return null gracefully. It depends on the **Key** module and runs on
Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **A documentation note worth knowing.** The module's `info.yml` declares a
> `baokey.settings` config route, but the module ships **no routing** for it — so
> there is no standalone admin settings page. All configuration happens in
> `settings.php` (the connection) and on each **Key** entity (the secret path).
> See [Configuration](configuration/index.md).

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in Key,
   and enable it.
2. [Configuration](configuration/index.md) — set the OpenBAO connection in
   `settings.php` and create Key entities that use the BaoKey provider.

## How to use it

Point BaoKey at your OpenBAO/Vault server in `settings.php`, then create Key
entities that use the "Vault" (BaoKey) provider, each pointing at a secret path.
Any module that consumes a key through the Key API will then transparently read
that secret from your vault.
