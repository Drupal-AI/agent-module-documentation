# Cookies Addons — manual setup guide

**Cookies Addons** (`cookies_addons`) extends the **COOKiES** consent‑management
module with extra ways to withhold third‑party content until a visitor has given
consent. Where COOKiES itself handles the banner and consent storage, Cookies Addons
lets you gate the actual content that loads external services or sets cookies —
blocks, paragraphs, views, fields, and embedded iframes/videos. Until the visitor
consents to the matching service, they see a placeholder with a consent overlay in
place of the blocked content; once consent is given, the real content loads.

The value here is privacy and GDPR/ePrivacy compliance: third‑party content (and its
cookies and trackers) is loaded **only after** the visitor consents. The module ships
a set of submodules, and you enable only the ones you need — each covers a different
kind of content and is configured in its own place (a settings page for
blocks/paragraphs/views, or per‑field/per‑text‑format for the others). It depends on
the **COOKiES** module and has no access‑control role of its own — as with COOKiES,
no legal‑compliance guarantee is implied.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the base
   module plus the submodules you need.
2. [Configuration](configuration/index.md) — where each submodule is configured.

## Where it lives in the admin menu

Cookies Addons has no single settings page; each submodule is configured separately.
The block/paragraph/view submodules add pages under **Configuration → System**
(for example `/admin/config/system/cookies-addons-blocks`), while the embed and
field submodules are configured in your text‑format settings or in an entity's
display settings. See [Configuration](configuration/index.md) for the full list.
