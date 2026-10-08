# Google API PHP Client — manual setup guide

**Google API PHP Client** (`google_api_client`) is an integration layer that wraps
the official `google/apiclient` PHP library so other Drupal modules can talk to
Google's APIs — Calendar, Drive, Gmail, and the rest. It has **no end-user feature of
its own**; instead it stores your Google account credentials, runs the OAuth2 (or
service-account) authentication flow, keeps the access token refreshed, and hands
ready-to-use Google service objects to whatever module needs them.

It supports two styles of Google account. A **Google API Client** account is for the
interactive, user-consent OAuth2 flow: it stores a client id, client secret, and
developer key, and you click an *Authenticate* link to grant access. A **Google API
Service Client** account is for server-to-server access with no interactive consent:
it stores a Google **service-account JSON key** and is used by background code. A
settings page with a **Scan Library** button reads the installed client library to
discover which Google services and scopes are available, so the account forms can
offer them as options.

Because this module holds Google credentials, treat those credentials as **secrets**.
Client secrets and service-account JSON keys should come from environment variables or
private files — never hard-coded and never committed to your configuration. See the
[Configuration](configuration/index.md) page for the recommended way to add an account
without leaking secrets into config.

This guide is written for a **human** setting up Google integration in the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Google client libraries) and enable the module.
2. [Configuration](configuration/index.md) — the Scan Library step, adding OAuth and
   service accounts, and how to keep credentials out of committed config.

## Where it lives in the admin menu

- **Settings / Scan Library:** *Structure → Google API Client settings*
  (`/admin/structure/google_api_client_settings`) — the module's configure page,
  with the **Scan Library** button.
- **OAuth accounts:** *Configuration → Web services → Google API Client*
  (`/admin/config/services/google_api_client`).
- **Service accounts:** *Configuration → Web services → Google API Service Client*
  (`/admin/config/services/google_api_service_client`).

Everything is behind the single **administer google api settings** permission.

## How to use it

The typical setup: install the module and its Google libraries, run **Scan Library**
so the service/scope options populate, then add an account (OAuth or service account)
and authenticate it. After that, other modules call the module's client service to
make Google API requests on that account's behalf. Full step-by-step instructions —
including the secrets-safe way to store credentials — are in
[Configuration](configuration/index.md).
