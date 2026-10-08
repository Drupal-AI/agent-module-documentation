# YouTube Cookies — manual setup guide

**YouTube Cookies** (`youtube_cookies`) stops embedded YouTube videos from
loading — and from setting YouTube's tracking cookies — until a visitor has
given consent. In place of each video it shows a thumbnail "façade" (a still
image plus a play icon) and a small consent pop-up. Only when the visitor
accepts the required cookie category does the real player load and start
playing. This is the piece most sites need to embed YouTube and still meet
GDPR / cookie-consent obligations.

It works by scanning your rendered pages for YouTube iframes and neutralising
them (it moves the iframe's `src` into a `data-src` so the browser never
requests YouTube until consent). Three embedding paths are covered
automatically: core **Media oembed** fields, the contrib **Iframe** field type,
and rich-text **CKEditor** content (through a text-format filter you switch on
per format). The consent pop-up is wired to whichever cookie-compliance system
you already run — **OneTrust** or the **EU Cookie Compliance** module — so the
"has the visitor consented?" decision is delegated to your existing banner.

To use it you set two required values on the settings form: the **cookie
category** machine name that must be accepted, and which **provider** (OneTrust
or EU Cookie Compliance) you use. Until both are set, nothing is injected. You
can also customise the pop-up message and the button labels, and translate them
per language. There is a master **Enable** toggle if you ever need to switch the
whole façade behaviour off.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field,
   plus how to switch on the CKEditor filter.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → YouTube
Cookies** (`/admin/config/system/youtube-cookies`), and needs the **Administer
site configuration** permission. The CKEditor integration is switched on
separately, per text format, under **Configuration → Content authoring → Text
formats and editors**.
