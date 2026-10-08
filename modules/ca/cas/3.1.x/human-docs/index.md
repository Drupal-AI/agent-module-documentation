# CAS — manual setup guide

**CAS** (`cas`) connects Drupal to a Central Authentication Service single sign‑on
server — the Apereo (formerly Jasig) CAS protocol used by many universities and
enterprises. With it enabled, users log in through your organization's identity
provider instead of a local Drupal password, and matching Drupal accounts are
created for them automatically the first time they sign in.

Under the hood, CAS turns Drupal into a CAS *client*. When a user logs in, Drupal
redirects them to the CAS server, waits for the server to authenticate them,
validates the returned service ticket (CAS protocol 1.0, 2.0, or 3.0 over HTTP or
HTTPS, with configurable SSL verification), and then logs the matching Drupal user
in through the **External Authentication** (`externalauth`) module. New users can
be auto‑registered on first login — optionally following your site's normal
registration policy — with their email derived from a CAS attribute or a fixed
hostname, and roles assigned automatically.

You configure all of this at **Configuration → People → CAS**: the server
connection, a **gateway** mode that silently checks whether a visitor already has
an SSO session on selected paths, a **forced login** mode that requires CAS on
selected paths, single‑logout handling, and proxy authentication. You can restrict
password and email management for CAS‑managed accounts and prevent normal Drupal
login entirely. For developers, CAS fires a rich set of events (pre/post login,
pre‑register, pre‑validate, pre‑redirect, pre‑user‑load) so custom code can deny
logins, map attributes onto profile fields, adjust roles, or change the redirect.
A Drush command links an existing Drupal account to a CAS username, and a bulk
"add CAS users" admin form can provision accounts in advance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.
2. [Configuration](configuration/index.md) — the CAS settings form, section by
   section.

## Where it lives in the admin menu

CAS's settings form sits at **Configuration → People → CAS**
(`/admin/config/people/cas`, route `cas.settings`). The bulk account‑provisioning
form lives at the "add CAS users" route (`cas.bulk_add_cas_users`).

## How to use it

1. Install the module and its dependencies, then enable it (see
   [Installation](installation/index.md)).
2. Go to **Configuration → People → CAS** and fill in your CAS **server**
   connection — hostname, protocol, and version — see
   [Configuration](configuration/index.md).
3. Decide how accounts are provisioned (auto‑register, email source, roles) and
   whether to force login or use gateway mode on particular paths.
4. Test a login: visit the CAS login link and confirm you are redirected to your
   identity provider and returned as a logged‑in Drupal user.
