# Social API — manual setup guide

**Social API** (`social_api`) is the shared foundation for the Drupal **Social
Initiative** — the family of modules that let a site log in with, post to, or embed
content from social networks (Social Auth, Social Post, Social Widgets, and their
per‑network add‑ons). On its own it is a **framework module**: it does not connect to
any particular network. Instead it defines the common building blocks that all those
integrations share — a `Network` plugin type that wraps a third‑party social SDK,
base classes for OAuth2 flows, per‑integration settings, session handling, user
authentication, and encrypted token storage.

Because it is a foundation, installing Social API by itself does very little that is
visible: it renders a single admin landing page at *Configuration → Social API* and
declares a handful of permissions. You install it because something else needs it —
either a contributed integration such as Social Auth ("Log in with Google/Facebook/
GitHub"), Social Post (autoposting new content to a social account), or your own
custom integration built on its `Network` plugin type and base classes.

Under the hood it takes care of the fiddly, security‑sensitive parts so each
integration doesn't have to reinvent them: lazily instantiating an expensive SDK
client only when a request needs it, keeping the OAuth `state` and redirect data in
the session behind a per‑integration prefix, mapping a provider account id onto a
Drupal user id, storing OAuth access tokens **encrypted at rest** (AES‑256‑CBC keyed
on the site hash salt) rather than as plain text, and failing installation early when
an integration's required SDK Composer package is missing.

The module has **no settings of its own** beyond that landing page, no config
objects and no Drush commands. It requires the PHP OpenSSL extension and the
`league/oauth2-client` library, and it supports Drupal 9.5, 10 and 11.

This guide is written for a **human** installing the module. If you are an AI coding
agent — or a developer writing an integration — read the sibling
[`agent/`](../agent/start.md) docs instead, which document the `Network` plugin type,
`NetworkBase`, the OAuth2/data‑handler/authenticator base classes and the encrypted
`SocialApi` entity.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (usually alongside an integration that depends on it).

## Where it lives in the admin menu

Social API contributes one landing page at **Configuration → Social API**
(`/admin/config/social-api`). It is a menu block that gathers the settings pages of
the integrations you install (Social Auth, Social Post, Social Widgets); Social API
itself has nothing to configure there. Its five permissions all start with *Administer
social api …* and gate that page and the integrations grouped under it.

## How to use it

You do not use Social API directly — you use it *through* an integration:

1. Install Social API (see [Installation](installation/index.md)). It is normally
   pulled in automatically as a dependency of the integration you actually want.
2. Install and configure one or more of the companion projects — for example
   [Social Auth](https://www.drupal.org/project/social_auth) for social login,
   [Social Post](https://www.drupal.org/project/social_post) for autoposting, or
   [Social Widgets](https://www.drupal.org/project/social_widgets) — plus the
   per‑network add‑on for each provider (Google, Facebook, …).
3. Grant the relevant *Administer social api …* permissions to the roles that
   manage social integrations, then configure each integration on its own settings
   page, reachable from *Configuration → Social API*.

If you are building your own integration, the `Network` plugin type and the base
classes you extend are documented in the [`agent/`](../agent/start.md) reference.
