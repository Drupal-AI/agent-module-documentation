# LDAP SSO — manual setup guide

**LDAP SSO** (`ldap_sso`) lets people arrive at your Drupal site already logged
in, without ever seeing a login form. It is built for corporate intranets, where
the browser has usually authenticated the user at the network level long before
Drupal sees the request. Instead of asking staff to type a second username and
password, the web server performs the authentication — typically **Kerberos** or
**NTLM** — and hands the resulting identity to Drupal, which resolves that name
against your LDAP directory and establishes a session.

Concretely, the module adds a login route at `/user/login/sso` that is gated by a
request‑aware access callback rather than a flat permission, and it works
together with the rest of the [LDAP](https://www.drupal.org/project/ldap) suite:
`ldap_servers` holds your directory connection, and `ldap_authentication`
performs the SSO login validation. Account provisioning and role mapping are the
LDAP suite's job, not this module's — LDAP SSO's role is specifically the
seamless, no‑password login.

One thing to be clear about before you deploy: this is **not** a public‑internet
SSO provider. It is not SAML and it is not usable across organisations without
additional middleware. If that is what you need, look at SimpleSAML‑based
modules instead. LDAP SSO is the right tool when your site sits inside a managed
domain and the web server can authenticate users for you.

The most important point is where trust sits. **The web server is the
authenticator**, and Drupal trusts the server variable it is handed. That makes
the web server configuration part of your security boundary: if a misconfigured
proxy lets a client supply the header the module reads, authentication becomes
spoofable. Configure the edge carefully, and keep a non‑SSO login path available
for accounts that are not in the directory.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the LDAP suite dependencies.
2. [Configuration](configuration/index.md) — the settings form, the LDAP suite
   prerequisites, and the trust model you must get right.

## Where it lives in the admin menu

The module's own settings form is registered as `ldap_sso.admin_form`, reached
from the LDAP suite's administration area under **Configuration → People →
LDAP**. The seamless login itself happens at `/user/login/sso`, which is not a
page you configure so much as a route the module protects and uses to establish
the session.
