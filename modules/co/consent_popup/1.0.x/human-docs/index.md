# Consent Popup — manual setup guide

**Consent Popup** (`consent_popup`) provides a configurable **block** that shows a
consent notice — the simplest possible cookie banner, implemented as an ordinary
Drupal block rather than as a full consent‑management framework. All of its text is
configurable: you set the message, and if the visitor **declines**, it shows your
configured decline text and a link to a page you choose. If the visitor **accepts**,
a global cookie is stored on the site to remember the choice. It also offers a few
presentation options — which page elements are blurred while the popup is open, and
the popup's background colour and opacity. It has no dependencies beyond core, no
routes, and no permissions; its configuration lives on the block instance.

**Please read this before relying on it for compliance.** "Cookie banner" covers
two very different things, and this module is the simpler one:

- A **notice** tells visitors that cookies are used. That is what this module is.
- A **consent manager** actually *withholds* third‑party scripts until the visitor
  opts in, and runs them only on acceptance. This module does **not** do that.

Under GDPR and the ePrivacy rules, a notice that appears *while your tracking
scripts have already loaded* does not obtain valid consent — and that is the whole
compliance question. So if your site runs **any** third‑party tracking (Google
Analytics, ad pixels, embedded media that sets cookies), you need a real consent
manager, not this module. Where Consent Popup genuinely fits is a site with **no
third‑party tracking** that simply wants to say so — a strictly‑necessary‑cookies
notice — or a non‑consent message such as an age gate, a terms reminder, a
policy‑change announcement, or a migration notice.

(One small technical note: the module's `core_version_requirement` contains an
upstream typo — `^10 | ^11` with a single pipe. It still parses, but it is not the
intended `||`.) It supports Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — place the block and set its text,
   decline link, cookie, and appearance.

## Where it lives in the admin menu

Consent Popup adds no settings page of its own. You configure it entirely through
**Structure → Block layout** (`/admin/structure/block`), by placing the Consent
Popup block and editing its instance settings.
