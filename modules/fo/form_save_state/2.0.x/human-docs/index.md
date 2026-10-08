# Form Save State — manual setup guide

**Form Save State** (`form_save_state`) protects people from losing work in a
form. For the forms you choose, it periodically writes the current field values
to the browser's **localStorage**, so if the tab is closed by accident, the
browser crashes, or the power goes out, the half‑finished input is still there
when the page is reopened. It's the safety net you want on long article bodies,
comments, webforms, and big multi‑field admin forms.

The saving is entirely **client‑side**. The module attaches a small JavaScript
library (built on the jQuery Sisyphus approach) to each enabled form; that script
autosaves the fields to localStorage as the user types and restores them on
return. Nothing is ever sent to or stored on the server — the recovery data lives
only in the visitor's own browser.

That client‑side design carries one privacy consideration worth planning for:
because values sit in localStorage, another person using the **same browser
profile** on a shared or public computer could read what was cached. For that
reason, only enable Form Save State for forms that don't carry sensitive data —
avoid it on anything with passwords or personal information.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick which form IDs get autosave.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Form Save State**
(`/admin/config/user-interface/form-save-state`), and requires the **Administer
site configuration** permission. See [Configuration](configuration/index.md) for
how to choose which forms are protected.
