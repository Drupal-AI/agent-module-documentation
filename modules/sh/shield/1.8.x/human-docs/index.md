# PHP Authentication shield — manual setup guide

**PHP Authentication shield** (`shield`) puts your whole site behind a single
**HTTP Basic Authentication** prompt — a "walled garden" — so nobody can view it
without a shared username and password. It's the classic way to protect dev,
staging, and pre‑launch sites: quick to set up, and it hides everything from the
public and from search engines with one credential you can share verbally.

It works by registering an HTTP middleware that runs very early — before page
caching — and intercepts every main request. When the shield is on, any visitor
who hasn't supplied the configured Basic Auth credentials gets a 401 with a
`WWW-Authenticate` header, so the browser shows its login prompt. This is
**different from Drupal's own login**: it gates the entire application, including
anonymous pages, before Drupal renders anything. Credentials can come from plain
configuration, or — better for keeping secrets out of exported config — from a
[Key](https://www.drupal.org/project/key) entity holding the password, or one
holding both username and password.

The shield is flexible about where you poke holes in it. You can allow CLI
(Drush) access, allowlist trusted IPs or IP ranges (your office or VPN), allow
specific HTTP methods (like `OPTIONS` for CORS preflight), expose whole domains
(a public front‑office domain while a back‑office domain stays protected), and
protect only certain paths or leave certain paths open. A debug header
(`X-Shield-Status`) can tell you exactly why the prompt did or didn't appear.

Shield **has a settings form** and adds an `administer shield` permission. It
depends only on core's **Path alias** module, and optionally uses the **Key**
module for secure credential storage. A migration is provided to bring Drupal 7
Shield settings across during an upgrade.

This guide is written for a **human** setting the shield up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent — including the
middleware's bypass order — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (plus the optional Key module).
2. [Configuration](configuration/index.md) — the settings form, field by field:
   enabling the shield, credentials, and all the exceptions.

## Where it lives in the admin menu

Its settings form sits at **Configuration → System → Shield**
(`/admin/config/system/shield`). Access is gated by the **Administer shield**
permission.

## How to use it

Install and enable the module, open the Shield settings page, tick **Enable
Shield**, set a **username** and **password**, and save. From that moment the
whole site prompts for those credentials. Then, if you need trusted traffic to
skip the prompt, add exceptions on the same form — allowlist your office IP
range, allow `OPTIONS` for CORS, leave a webhook or health‑check path open, and
so on. For anything more than a throwaway credential, store the password in a Key
entity so it never lands in exported configuration. See
[Configuration](configuration/index.md) for every option.
