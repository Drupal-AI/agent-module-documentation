# Meeting API: BigBlueButton — manual setup guide

**Meeting API: BigBlueButton** (`meeting_api_bbb`) is a **BigBlueButton (BBB)
provider** for the [Meeting API](https://www.drupal.org/project/meeting_api)
framework. With it installed, Drupal can create and join **BigBlueButton video
meetings and webinars** through the Meeting API abstraction — so your meeting
entities are backed by a real BBB server while the rest of your site stays
provider‑agnostic. BigBlueButton itself runs the meetings and any recordings; this
module is the bridge that talks to your BBB server's API.

It depends on the **Meeting API** module (the framework it plugs into) and the
**Key** module, and works on Drupal 10 and 11. A notable strength is that it handles
its secret **correctly**: the BBB server's **shared secret / API credentials are
stored via the Key module**, not in plain configuration. You point the module at
your BBB server URL and select the Key that holds the shared secret.

> **Important — SHA‑1 removed in 1.0.0‑alpha5.** As of release 1.0.0‑alpha5, support
> for SHA‑1 has been dropped, and this change is **not** applied automatically
> because it also requires updating the shared secret on your BigBlueButton server.
> Before updating to alpha5 or later you must: (1) generate a **new shared secret**
> using a supported hashing algorithm on your BBB server, (2) update the module's
> configuration to use the new secret, and (3) verify the Drupal↔BBB connection
> works. If you skip these steps, authentication with your BBB server will fail.

> **Join URLs are capabilities.** Anyone who holds a BBB join link can usually enter
> the meeting, so treat join URLs as secrets in listings, feeds and emails.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Meeting API and Key.
2. [Configuration](configuration/index.md) — store the BBB shared secret as a Key,
   set the server URL, and connect a meeting type to the BBB backend.

## Where it lives in the admin menu

This module is a provider plugin for Meeting API, so you configure it through
Meeting API's administration: you store the shared secret with the **Key** module at
**Configuration → System → Keys** (`/admin/config/system/keys`), and you set the BBB
server URL and select that Key on the module's / provider's settings, then bind a
**meeting type** (under **Structure**) to the BigBlueButton backend.

## How to use it

1. Provision a **BigBlueButton server** and note its **server URL** and **shared
   secret** (using a supported, non‑SHA‑1 hashing algorithm).
2. Store the shared secret as a **Key** entity (see
   [Configuration](configuration/index.md)).
3. Configure the BBB provider with the server URL and the Key.
4. In **Meeting API**, create or edit a **meeting type** to use the **BigBlueButton**
   backend, then create meetings of that type — they are created on, and joined
   through, your BBB server.
