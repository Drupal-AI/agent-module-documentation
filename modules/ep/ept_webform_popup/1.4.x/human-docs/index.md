# EPT Webform Popup — manual setup guide

**EPT Webform Popup** (`ept_webform_popup`) is part of the *Extra Paragraph Types*
(EPT) family — small modules that each add a ready-made, styled paragraph type.
This one renders a **button that opens a chosen webform in a popup/modal** when
clicked, so a form (contact, signup, feedback) can be offered inline on a page
without taking over the layout. It's a natural fit for a "Contact us" call-to-action
on a landing page.

The button and the popup are customisable per instance, and like every EPT
paragraph it carries the family's shared *Design* options — spacing, borders, a
background and container width. The webform it opens keeps its own access rules,
handlers and validation; this module only handles the button-and-popup
presentation and has no access-control role of its own.

It depends on the EPT **basic button** module (`ept_basic_button`), Paragraphs and
Webform, and it targets Drupal 9.3, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside EPT Basic Button, Paragraphs and Webform.

There is **no separate configuration page** for this module. The button label,
target webform and popup appearance are all set **per instance** on the paragraph
while you build a page, and the shared paragraph behaviour lives in the **EPT Core**
module ([`ept_core`](https://www.drupal.org/project/ept_core)) — see its
documentation for the family-wide design options.

## How to use it

Once the module is enabled, its paragraph type becomes available anywhere you have
added a Paragraphs field. While editing content:

1. Build (or reuse) the webform in **Structure → Webforms**.
2. In your content, add a new paragraph and choose the **EPT Webform Popup** type.
3. Set the button text, select the webform to open, and adjust the button/popup
   styling and the shared **Design** options as needed.
4. Save the content — visitors see the button, and clicking it opens the webform in
   a modal.
