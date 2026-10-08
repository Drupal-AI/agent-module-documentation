# Route Basic Auth — manual setup guide

**Route Basic Auth** (`route_basic_auth`) puts an **HTTP Basic authentication**
prompt — the browser's built‑in username/password box — in front of the routes you
choose. It's a simple, coarse gate you can drop over a staging area, a preview
page, a login form, or an API path so that only people who know a shared
username/password get through, on top of Drupal's own access checks.

You configure it by naming the **route** to protect (by its machine name, for
example `user.login`) and ticking which **HTTP methods** (GET, POST, and so on)
the prompt should cover. A site‑wide username and password apply by default, and —
new in the 2.1 line — each route can instead use its own custom credentials.

The module's credential handling is done carefully: it compares the supplied
username and password against the expected values using a constant‑time
comparison (`hash_equals`), which resists timing attacks, and it **fails closed**
if no expected credentials are set. It also reuses core's flood protection, so
repeated failed attempts from an IP are blocked for a while.

Two things you must respect, though, are inherent to HTTP Basic auth and not
things the module can fix for you:

- **Always serve protected routes over HTTPS.** Basic auth sends the credentials
  base64‑encoded on *every* request — that is encoding, not encryption — so over
  plain HTTP they are effectively in the clear.
- **Store the credentials as secrets.** With the [Key](https://www.drupal.org/project/key)
  module installed you can pull the password from an environment variable or a
  file outside the web root instead of typing it into a config field. Without Key,
  the password is stored in plain text in site configuration — which means it ends
  up in the database, in every config export, and in every backup.

Treat Basic auth as a blunt gate in front of a few routes, not as a replacement
for real per‑user authentication.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (recommended) add the Key module.
2. [Configuration](configuration/index.md) — the settings form field by field:
   credentials, protected routes, Key integration, and flood protection.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Route Basic Authentication
settings**. Access to it is governed by the **Change the Route Basic
Authentication settings** permission.
