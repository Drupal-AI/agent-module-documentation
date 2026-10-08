# Social Auth Yandex — manual setup guide

**Social Auth Yandex** (`social_auth_yandex`) adds "Login with Yandex" to a Drupal
site, letting people register and sign in with their **Yandex** account over
OAuth 2.0. It adds a `user/login/yandex` path that redirects the visitor to Yandex
to authenticate; the redirect and callback flow is handled by the **Social Auth**
base module. It provides the Yandex network plugin, depends on `social_auth`, and
has no submodules.

Visitors log in by clicking the **Yandex** button in the Social Auth login block,
or from any link you place to `user/login/yandex`. To make it work you register a
Yandex OAuth application and enter its **client ID** and **client secret** through
Social Auth's network settings; because the module allows requesting any scopes, it
can be used for tasks that need authenticated access to Yandex services. Store the
client secret as a site secret and use HTTPS.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.

## How to use it

Register a Yandex OAuth application, then enter its client ID and secret through
Social Auth's network settings (under **Configuration → Social API → User
authentication**). Place the Social Auth login block so the **Yandex** button
appears, or link to `user/login/yandex` yourself. Review Social Auth's own
account-linking and auto-registration settings before exposing this to real users.
