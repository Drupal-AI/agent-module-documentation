# Annoying Popup — manual setup guide

**Annoying Popup** (`annoying_popup`) shows visitors a configurable popup overlay —
the kind of pop‑up you might use for an announcement, a consent prompt, a
promotion, or a newsletter call‑to‑action. It is "cookie‑aware": once a visitor
dismisses the popup, a browser cookie remembers that, so they are not shown it
again until the cookie expires.

Each popup is stored as a **configuration entity**, so you can create and manage
your popups from a single admin listing. The popup content is written by an
administrator and rendered as‑is, so only enter markup you trust. The module
provides its own **Administer annoying popups** permission and has no
access‑control role beyond that.

Because it sets a dismissal cookie, keep it in mind for any cookie‑consent
obligations your site has.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and manage your popups.

## Where it lives in the admin menu

Popups are managed at **Configuration → System → Annoying Popup**
(`/admin/config/system/annoying_popup`), gated by the **Administer annoying
popups** permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the popup listing and create a popup with your message.
3. The popup is shown to visitors and remembered as dismissed via a cookie once
   they close it.
