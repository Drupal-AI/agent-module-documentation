# AT Internet SmartTag — manual setup guide

**AT Internet SmartTag** (`atsmarttag`) adds the **AT Internet** — now **Piano
Analytics** — SmartTag JavaScript tracker to your site's public pages and lets you
control how page views are labelled and how clicks are tracked. It is the analytics
counterpart to something like the Google Analytics module, but for the AT Internet /
Piano platform.

On every non‑admin page the module attaches the tracker along with a settings
payload built from its configuration: your AT Internet **site id**, the collection
domains, cookie handling, and options for tracking file downloads, `mailto:` links,
and outbound links. The page name reported to analytics comes from either the
current path alias or the resolved page title, and — if you enable it — up to three
page "chapters" are derived from the breadcrumb trail. Admin routes are excluded
from tracking automatically. Other modules can adjust the emitted payload through a
`hook_atsmarttag_settings_alter()` hook.

The SmartTag library can be loaded two ways (chosen in configuration): from a
remote **URL**, or from a **file** you upload and serve locally with aggregation.
Everything is driven by a single settings form gated by the `administer atsmarttag`
permission — there are no anonymous or mutating endpoints. Because tracking involves
cookies and CNIL‑style exemption settings, review the cookie and consent options
against the privacy rules of your jurisdiction. The module runs on Drupal 10.3+ and
11.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field:
   loading the library, the site id and collection domains, cookies/privacy, page
   naming, and click tracking.

## Where it lives in the admin menu

The single settings form sits at **Configuration → System → AT Internet SmartTag
settings** (`/admin/config/system/atsmarttag/settings`), gated by the **Administer
AT Internet SmartTag** (`administer atsmarttag`) permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings form, enter your AT Internet site id and collection details,
   and choose how the SmartTag library is loaded (see
   [Configuration](configuration/index.md)).
3. Review the cookie / CNIL settings for your region, then save. The tracker is
   attached to all non‑admin pages from then on.
