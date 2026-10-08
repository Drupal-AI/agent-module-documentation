# TacJS — manual setup guide

**TacJS** (`tacjs`) brings the popular
[tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js) consent library into
Drupal. It shows a cookie‑consent banner that **blocks third‑party services** —
analytics, video embeds, social widgets, ads — until the visitor opts in, so your
site can comply with the EU cookie law / GDPR without you writing any JavaScript.

Once set up, TacJS adds the consent banner to every non‑admin page. Visitors get
"Accept all" and "Deny all" buttons, a persistent icon to reopen their choices
later, and a link to your privacy policy. Behind the scenes, services like Google
Analytics or YouTube stay blocked until consent is given (high‑privacy mode), and the
module can honor the browser's "Do Not Track" header.

Configuration is split across three admin forms: **Manage dialog** (banner position,
icon, privacy link, privacy behavior), **Add services** (pick which tarteaucitron
services your site actually uses), and **Edit texts** (reword or translate every
banner string). Two submodules extend it — **TacJS Log** records proof of consent for
audit, and **TacJS Media** provides a consent‑aware video field formatter.

> **Prerequisite: the tarteaucitron.js library is not bundled.** You must install the
> `tarteaucitronjs` JavaScript library into `web/libraries/tarteaucitronjs` yourself.
> Drupal's status report will flag an error until it's present. See
> [Installation](installation/index.md).

> **Security note:** the settings accept raw text and JavaScript for service
> definitions, so the `administer tacjs` permission is restricted — grant it only to
> fully trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   tarteaucitron.js library, and the optional submodules.
2. [Configuration](configuration/index.md) — the three settings forms and the
   `administer tacjs` permission.

## Where it lives in the admin menu

All three settings forms are under **Configuration → System → TacJS**
(`/admin/config/system/tacjs`).

## How to use it

Install the library, enable the module, then open **Add services** to turn on the
services your site uses, **Manage dialog** to position and style the banner, and
**Edit texts** to adjust the wording. See [Configuration](configuration/index.md).
