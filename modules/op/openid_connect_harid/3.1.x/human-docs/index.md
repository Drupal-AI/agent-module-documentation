# OpenID Connect HarID — manual setup guide

**OpenID Connect HarID** (`openid_connect_harid`) lets people log into your
Drupal site with their **HarID** account — the Estonian identity federation at
harid.ee, widely used by Estonian education and research organisations. It is a
thin client plugin for the **OpenID Connect** module: it adds HarID as one more
single sign-on option alongside any other OpenID Connect providers you configure.

The module itself does very little on purpose. It defines the HarID endpoints,
the scopes to request, and three extra options, then hands everything else — the
redirect URL, the CSRF `state` and `nonce`, the authorization-code exchange, the
token handling, and matching or creating the Drupal account — to the parent
OpenID Connect module. That keeps the security-critical machinery in the
well-tested core client.

On top of standard OpenID Connect login it adds two HarID-specific behaviours you
can switch on: **require a strong session** (the login must come through an
ID-card, Mobile-ID, or Smart-ID session) and **require a personal code** (the
HarID account must carry a personal identity code). It can also point at HarID's
**test** identity provider while you develop, and it sets a user's Drupal language
from HarID's `ui_locales` on each login when that language is enabled on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it enables OpenID Connect too).
2. [Configuration](configuration/index.md) — add and configure a HarID client
   through the OpenID Connect UI, field by field.

## Where it lives in the admin menu

This module adds no admin page of its own. You configure HarID as a client inside
the OpenID Connect module at **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`), where **HarID** appears as a client type
you can add.

## How to use it

After enabling the module, add a HarID client in the OpenID Connect UI, enter the
client id and secret HarID issued you, and copy the redirect URL it shows into
your HarID service registration. A HarID login button then appears wherever you
place the OpenID Connect login block. See
[Configuration](configuration/index.md) for the full walkthrough.
