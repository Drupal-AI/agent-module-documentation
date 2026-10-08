# Acquia Key Provider — manual setup guide

**Acquia Key Provider** (`acquia_key_provider`) adds a **key provider** to the
Key module that reads secrets from **Acquia hosting's platform secret storage**.
With it installed, a Key entity — the thing other modules point at for an API key,
token or password — can source its value from Acquia's secrets rather than from
Drupal configuration or a file on disk.

This is a **security-positive** integration. Keeping secrets in the hosting
platform and referencing them through Key is the pattern you want, as opposed to
committing credentials into exported configuration or the repository. The trade-off
to understand honestly: once a secret lives in Acquia's platform storage, its
protection rests on **Acquia's platform controls** — this module is the bridge, not
an access-control layer of its own.

It depends on the **Key** module and does nothing on its own; its whole job is to
appear as a provider option when you create or edit a Key entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the Key module it requires.
2. [Configuration](configuration/index.md) — create a Key entity that uses the
   Acquia provider.

## Where it lives in the admin menu

The module has no settings page of its own. It surfaces as a **provider choice** on
the Key add/edit form under **Configuration → System → Keys**
(`/admin/config/system/keys`). See [Configuration](configuration/index.md).

## How to use it

On an Acquia-hosted site, store your secret in Acquia's platform secret storage,
then create a Key entity that selects the **Acquia** key provider so Drupal reads
the value from the platform. Other modules that consume Key entities (AI providers,
API integrations, and so on) can then reference that Key and never touch the raw
secret. Full steps are in [Configuration](configuration/index.md).
