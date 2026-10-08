# Google Tag — manual setup guide

**Google Tag** (`google_tag`) adds Google's tracking snippets — **Google Tag
Manager** (GTM) and **Google Analytics 4** (GA4), plus Google Ads and other
Google tag types — to your site's pages without you having to edit any theme
templates. It works by placing the right `gtag.js` or `gtm.js` snippet into each
page response and, optionally, pushing structured analytics events (logins,
searches, Commerce and Webform activity, and custom events) into the browser's
`dataLayer`.

In the 2.x branch you no longer configure a single global ID. Instead you create
one or more **tag containers**. Each container holds one or more measurement/GTM
IDs (for example a GA4 `G-…` ID or a `GTM-…` container ID) together with the
**conditions** that decide where it fires — which paths to include or exclude,
which response codes to skip, and so on. Most sites need just one container; you
add more only when different parts of the site need different tracking. This
guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Google Tag Global settings page](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Services → Google Tag**
(`/admin/config/services/google-tag`). The **Google Tag Global settings** page
there is organised into tabs (**Tag Settings**, **Advanced**, **Additional
Tags**) and is where you add containers and set site-wide behaviour. Access is
gated by the **`administer google_tag_container`** permission.

## Contents

1. [Installation](installation/index.md) — install Google Tag with Composer and
   enable the module.
2. [Configuration](configuration/index.md) — walk through the global settings
   page and add your first tag container with its measurement/GTM ID and
   visibility conditions.
