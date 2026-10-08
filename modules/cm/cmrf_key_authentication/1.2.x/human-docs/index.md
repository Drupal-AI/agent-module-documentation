# CMRF Key Authentication — manual setup guide

**CMRF Key Authentication** (`cmrf_key_authentication`) lets people log into
Drupal using a **key that CiviCRM generates and validates** — the classic
"magic link" or one-time login code, where the authority for *who a user is*
lives in CiviCRM rather than in Drupal's own user table. When a request arrives
carrying a valid key, the module asks CiviCRM (over a **CiviMRF** connection) to
look it up and, if exactly one contact matches, logs that person in as a
"virtual" Drupal user whose fields, roles, and tokens are mapped straight from
the CiviCRM record.

It suits CiviCRM-driven portals and member sites: someone receives an email from
CiviCRM containing a login code, follows the link, and is authenticated without
ever setting a Drupal password. A key can reach the site three ways — as a **URL
query parameter**, inside a **signed JWT** (HS256, verified with a secret you
configure), or through the built-in login forms at `/user/civicrm_login_request`
(request a code) and `/user/civicrm_login` (enter it).

This module needs configuration before it will authenticate anyone. You point it
at your CiviCRM API entity/action, map which CiviCRM fields become the key,
email, user id, roles, and user profile values, and set the JWT secret and the
inactivity timeout. It depends on **CMRF Core** (`cmrf_core`) for the connection
to CiviCRM, and CiviCRM itself must hold the logic for what counts as a valid
key.

One operational caution worth knowing up front: a key travelling in a **URL
query string** can leak through server access logs, browser history, and
`Referer` headers. Where you can, prefer the JWT or the POSTed login form over
plain URL keys.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its CMRF Core dependency.
2. [Configuration](configuration/index.md) — the settings form field by field:
   the CiviCRM lookup, field mappings, JWT secret, URL parameter names, and
   inactivity timeout.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → CMRF Key
Authentication** (`/admin/config/services/cmrf_key_authentication`), reachable by
users with the **Administer site configuration** permission.
