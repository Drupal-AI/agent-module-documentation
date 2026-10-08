# Link As Popup — manual setup guide

**Link As Popup** (`link_as_popup`) extends Drupal's core **Link** field with extra
**target** options — including opening the linked destination in a **popup/modal**
on the current page, or in a chromeless ("clean") new window. Editors choose the
behavior per link value, and for the modal option they can set a width and height
per value, all without any custom code.

The modal is JavaScript‑driven (it is not a true native HTML `<dialog>`), which is
worth knowing if you have strict requirements about the underlying mechanism. The
module provides both a **widget** (so editors pick the target behavior when
entering a link) and a **formatter** (so the chosen behavior is applied on output).
It builds on core **Link** and adds no content or access role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no central settings page**. You configure it per field on the
entity's form and display screens, described in "How to use it" below.

## How to use it

1. On a bundle (content type, taxonomy vocabulary, user, etc.) that has a **Link**
   field, go to **Manage form display**.
2. Set that field's widget to the **Link As Popup** widget, so editors can choose a
   target — normal, new tab, popup/modal, or chromeless window — and, for the
   modal, a width and height per link value.
3. On **Manage display**, set the field's formatter to the **Link As Popup**
   formatter so the chosen behavior is applied when the link is rendered.
4. Save. When editing content, each link value now offers the extra target options.
