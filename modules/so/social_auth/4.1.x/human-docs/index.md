# Social Auth — manual setup guide

**Social Auth** (`social_auth`) is the base framework that lets people register and
log in to your Drupal site with an external identity provider — the "Sign in with
Google / Facebook / GitHub" experience. It is built on **Social API** and handles
the shared machinery: the OAuth2 redirect and callback flow, the login policy, a
login block, and a per‑user record of which external accounts are linked.

The important thing to understand is that Social Auth **does not integrate any single
provider on its own**. It is the common engine that individual provider modules plug
into. To actually offer "Sign in with Google," you install Social Auth *plus* the
`social_auth_google` provider module, and you register an OAuth application with
Google to get a client ID and secret. Each provider — Google, Facebook, GitHub, and
so on — ships as its own `social_auth_*` module that registers itself with Social
Auth through a Social API "Network" plugin.

Once a provider is installed and configured, Social Auth takes care of the rest: it
sends the user off to the provider, receives them back on the callback, and then
either logs in an existing linked account, links a provider to the user who is
already logged in, or creates a brand‑new Drupal account — all according to the
policy you set (login‑only vs. registration allowed, admin login blocked, certain
roles disabled, where to send people after login). Linked identities are stored as
"Social Auth profile" entities that users and admins can manage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in Social
   API), enable it, and add at least one provider module.
2. [Configuration](configuration/index.md) — the integrations page, per‑provider
   credentials, the site‑wide login policy, the login block, and permissions.

## Where it lives in the admin menu

Social Auth's main screen is the Social API integrations page at **Configuration →
Social API settings → Social Auth**
(`/admin/config/social-api/social-auth`). It lists every installed auth provider and
links to each provider's own settings form. The "Social Auth Login" block is placed
from **Structure → Block layout**.

## How to use it

1. Install Social Auth and at least one provider module (for example
   `drupal/social_auth_google`).
2. Register an OAuth application with that provider to obtain a **client ID** and
   **client secret**.
3. On the integrations page, open the provider's settings form and paste in the
   credentials.
4. Set your site‑wide login policy and place the **Social Auth Login** block so the
   "Sign in with…" buttons appear.

See [Configuration](configuration/index.md) for each of these steps in detail.
