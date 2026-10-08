# Extra Block Types (EBT): Webform Popup — manual setup guide

**Extra Block Types (EBT): Webform Popup** (`ebt_webform_popup`) places a button that
opens a **webform in a popup**. It is ideal for a "request a callback", "book a demo",
or "ask a question" flow: the page keeps its narrative, and the form is one click away
rather than competing for space inline. Both the button and the popup are customizable
in the block's own settings form.

It is part of the **Extra Block Types (EBT)** family, built from **EBT Basic Button**
(`ebt_basic_button`) for the trigger, **Paragraphs** for the structure, and the
**Webform** module for the form itself — so the form in the popup is an ordinary
webform with all its handlers, validation, and access intact.

Two things are worth verifying once it is in place. First, **modal accessibility**:
focus should move into the popup when it opens, must not escape to the page behind
while it is open, Escape should close it, and focus should return to the button
afterwards — a modal that traps focus is a form a keyboard user cannot submit or
leave. Second, a form reachable only behind a button is invisible when JavaScript
fails, and a popup form on a public page is found by bots as readily as an inline one,
so provide a non‑JavaScript path if the form matters and make sure your site's CAPTCHA
or honeypot applies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Webform Popup adds no site‑wide configuration page; its options live on each
block instance. You use it by placing a **Webform Popup** block: in **Layout
Builder**, at **Structure → Block layout**, or as a reusable block under **Content →
Blocks → Add content block**.

## How to use it

1. Make sure the webform you want to show already exists (build it under **Structure →
   Webforms**).
2. Add a Webform Popup block through Layout Builder or Block layout.
3. In the block's settings form, choose the webform, set the button label and style,
   and adjust the popup behaviour.
4. Save and place the block. On the rendered page, the button opens the webform in a
   popup.
