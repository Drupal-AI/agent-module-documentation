# Secret Login — manual setup guide

**Secret Login** (`secret_login`) lets a person log in simply by visiting a URL
you have configured. An administrator defines a secret path and maps it to a user
account; when someone visits that URL, they are logged in as that account without
entering a username or password. The intended use is convenience — quickly
getting into an admin or staff account through a predefined link. The module can
also mint a one-time token URL for a configured user, with a token that stays
valid for about an hour before a new one is generated.

> The secret path you choose acts as the credential for the mapped account, so
> choose a long, high-entropy path (not a memorable slug). See
> [Configuration](configuration/index.md) for details.

The module has no module dependencies and ships no submodules. It supports Drupal
9 through 11 (and is declared for 12). It provides its own permission and config
schema, and its behavior is entirely driven by the secret URLs an administrator
configures — it does nothing until you create one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a secret URL and choose
   good paths.

## How to use it

Once you have configured a secret path mapped to a user, visiting
`/secret-login/access/<your-path>` logs the visitor in as that user and redirects
to that user's page. The optional token flow issues a one-time login URL for a
configured user that expires after roughly an hour. Be deliberate about which
accounts you expose and choose hard-to-guess paths.
