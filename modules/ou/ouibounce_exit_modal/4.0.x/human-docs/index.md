# Ouibounce Exit Modal — manual setup guide

**Ouibounce Exit Modal** (`ouibounce_exit_modal`) integrates the
[Ouibounce](https://github.com/carlsednaoui/ouibounce) JavaScript library to show
a modal **just as a visitor is about to leave your site** — the moment their
cursor moves toward the browser's close button or address bar. It's the classic
"exit‑intent" popup used for a last‑chance offer, a newsletter sign‑up, or a
parting message.

What makes this module flexible is that the modal's content is **a Drupal block**:
you can embed any block — custom HTML, a View, even a Webform — into the exit
modal. The modal respects the access rules of whatever content you put inside it.

> **Upgrading from 3.x?** The block‑selection logic changed in a
> backward‑incompatible way in 4.x, so you must **reconfigure your Ouibounce block
> settings after upgrading** (custom HTML and Views blocks are not affected). No
> database changes were made, so you can move between 3.x and 4.x freely — just
> redo the block configuration. The DOM/CSS structure also changed, so you may need
> to adjust your styles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Ouibounce
   JavaScript library, then enable it.

There is **no global settings page** — you configure everything on the block you
place. How to use it is described below.

## Where it lives in the admin menu

The modal is configured as a block under **Structure → Block layout**; there is no
separate configuration form.

## How to use it

1. Install the module *and* the Ouibounce library (see Installation) — without the
   library the modal won't work.
2. Go to **Structure → Block layout** and place the **Ouibounce Block** into a
   region (typically the content area).
3. In the block's settings, choose what to show in the modal — a custom HTML
   snippet, a View, or another block — and set the trigger behavior.
4. Save. The chosen content now appears in an exit‑intent modal when a visitor
   moves to leave the page.

> **Use exit‑intent popups judiciously.** They interrupt the visitor, so reserve
> them for genuinely useful content and test how they feel on your site.
