# Configuration

Setting up Google integration has three parts: **scan the library** so the module
knows which Google services and scopes exist, **add an account** (OAuth or service
account), and — most importantly — **keep the credentials out of committed config**.
Everything here is behind the *administer google api settings* permission.

## A word on secrets first

This module handles real Google credentials: an OAuth **client secret** and
**developer key**, and for service accounts a **JSON key file**. These are secrets —
if they leak, someone can act as your site against Google.

- **Never hard-code them and never commit them** to your repository or exported
  configuration.
- For OAuth accounts, the access token that the module obtains is stored in Drupal's
  **State** system (not in exported config), so it does not leak into config sync.
  You still need to keep the client secret itself safe.
- For service accounts, prefer keeping the JSON key **out of committed config**: load
  it from an **environment variable** or a **private-filesystem** file at deploy time
  rather than pasting it into config that gets exported and committed. If you do
  create the service-account entity through the UI, make sure that config is excluded
  from your committed config (for example via a config-ignore/split arrangement), or
  create it programmatically at deploy time from a secret source.

The rest of this page shows where each value goes; apply the guidance above to how
you *supply* those values.

## Step 1 — Scan the library

Go to **Structure → Google API Client settings**
(`/admin/structure/google_api_client_settings`) and click **Scan Library**. This
reads the installed `google/apiclient` library and Google's discovery data to build
the list of available services and scopes, and caches it. Those lists are what
populate the *services* and *scopes* choices on the account forms, so run this
**after installing or updating** the Google libraries (a `drush cr` also refreshes
things). Without it, the account forms won't have services/scopes to pick from.

## Step 2a — Add an OAuth (user-consent) account

Use this for the interactive flow where a Google account owner grants consent.

1. Go to **Configuration → Web services → Google API Client**
   (`/admin/config/services/google_api_client`) and click **Add**.
2. Fill in:
   - **Name** — a label for the account (required).
   - **Client ID** — the OAuth client id from your Google Cloud project (required).
   - **Client secret** — the OAuth client secret (required). *Treat as a secret.*
   - **Developer key** — optional API key.
   - **Services** — the Google services this account should use (these come from the
     Scan Library step).
   - **Scopes** — the OAuth scopes to request.
3. Save. In the account list, each account shows an **Authenticate** link. Click it
   to run the Google OAuth2 consent flow; when you return, the account is marked
   authenticated and its access token is stored in State and refreshed
   automatically. A **Revoke** link appears once authenticated so you can revoke
   access later.

Behind the scenes the consent flow returns to the module's OAuth callback route
(`google_api_client/callback`). Make sure that callback URL is registered as an
authorized redirect URI in your Google Cloud project's OAuth client.

## Step 2b — Add a service account (server-to-server)

Use this for background/automated access with no interactive consent.

1. Go to **Configuration → Web services → Google API Service Client**
   (`/admin/config/services/google_api_service_client`) and click **Add**.
2. Fill in:
   - **Label** and machine **id**.
   - **Auth config** — the service-account **JSON key** contents. *Treat as a
     secret* — see the guidance above about loading this from an environment
     variable or private file rather than committing it.
   - **Services** and **Scopes** — as with OAuth accounts.
3. Save. A service account needs no *Authenticate* click; code builds a Google client
   from the JSON key and requested scopes directly.

A service account is a **config entity**, so by default its values (including the
JSON key) are part of exportable configuration — which is exactly why you should
either exclude it from committed config or create it at deploy time from a secret
source.

## Managing multiple accounts

You can add several accounts — for example one per Google Cloud project, or one OAuth
account and one service account for different jobs. Each is managed independently
from its collection page. Enable only the specific services a site actually needs, to
keep the consent/scope surface small.

## How other modules use these accounts

This module is a substrate: other modules (or your custom code) call its client
service, load one of your accounts, and get back ready `Google\Service\*` objects to
make API calls. Making **real** Google API requests requires valid Google
credentials and — for OAuth accounts — a completed authentication. The developer-side
details (the `google_api_client.client` service, `getServiceObjects()`, and the four
customization hooks) are in the [`agent/`](../agent/api/services.md) docs.
