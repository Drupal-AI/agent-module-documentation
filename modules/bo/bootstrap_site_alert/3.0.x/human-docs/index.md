# Bootstrap Site Alert — manual setup guide

**Bootstrap Site Alert** (`bootstrap_site_alert`) shows site-wide alert banners
styled with Bootstrap's alert component — the kind of message you occasionally
need to put in front of everyone: "scheduled maintenance tonight", "our office is
closed", "new feature launched". Rather than dropping in a custom block and some
markup each time, this module makes alerts a managed feature: an editor creates
them, they render in Bootstrap alert styling, and a visitor can dismiss them.

Dismissal is remembered with a cookie (via the module's **js_cookie** dependency),
so once someone closes an alert it stays closed for them. The module defines two
permissions — `administer bootstrap site alerts` and `view bootstrap site alerts`
— so you can decide explicitly who may create alerts and who sees them. That
second permission matters if some alerts should only be shown to logged-in users.

The Bootstrap dependency here is purely stylistic: the alerts emit Bootstrap CSS
classes. On a Bootstrap theme they look right out of the box; on a non-Bootstrap
theme you would need to give those classes meaning yourself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and its js_cookie dependency).
2. [Configuration](configuration/index.md) — create and manage alerts, and set
   the two permissions that control who creates and who sees them.

## Where it lives in the admin menu

Alerts are managed through the admin UI by a user with the **administer bootstrap
site alerts** permission. Permissions themselves are set under **People →
Permissions**. See [Configuration](configuration/index.md) for the details.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant the create/administer permission to the right role, and decide whether
   the view permission should be universal or restricted.
3. Create an alert with your message; choose its Bootstrap alert style (for
   example info, warning, or danger).
4. Confirm your theme renders Bootstrap alert classes so the banner is styled as
   intended.
