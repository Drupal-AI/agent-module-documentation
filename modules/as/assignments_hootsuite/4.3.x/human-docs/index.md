# Assignments Hootsuite — manual setup guide

**Assignments Hootsuite** (`assignments_hootsuite`) connects the
[Assignments](../../assignments/4.1.x/human-docs/index.md) module to **Hootsuite**,
the social‑media management platform. It extends assignment workflows so they can
post to — or otherwise interact with — the social accounts Hootsuite manages,
through Hootsuite's API.

The connection is authenticated with **OAuth2**, handled via the `oauth2_client`
module. Once you have registered an app with Hootsuite and entered its credentials,
assignments on your site can drive social posting rather than you posting by hand
in Hootsuite. This is an integration module: it depends on both **Assignments**
(the entity it extends) and **OAuth2 Client** (for authentication), and supports
Drupal 10 and 11.

Because it can publish to real social accounts, treat its access with care. The
Hootsuite API settings are gated by the **Administer hootsuite api settings**
permission — grant that only to trusted operators — and the API credentials should
be stored securely rather than committed to configuration. See
[Configuration](configuration/index.md) for how to set the credentials up with an
environment variable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its dependencies.
2. [Configuration](configuration/index.md) — register a Hootsuite app, store its
   credentials securely, and connect via OAuth2.

## Where it lives in the admin menu

The Hootsuite API settings are available to users with the **Administer hootsuite
api settings** permission. Grant it (**People → Permissions**) only to the trusted
operators who should manage social posting. See
[Configuration](configuration/index.md).
