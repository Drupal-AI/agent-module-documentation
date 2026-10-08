# Phone Link — manual setup guide

**Phone Link** (`phone_link`) provides a field **formatter** that turns a phone
number into a clickable `tel:` link when it is displayed. A phone number on a page
should be tappable on a mobile device, and this module makes that happen without any
theming work: point the formatter at a text or telephone field and the rendered
value becomes a link that opens the phone dialler when tapped.

It is purely a display formatter — it changes how a field is *shown*, not how it is
stored, and it adds no admin settings page of its own. You can optionally give the
link a prefix such as "Call to" so the output reads "Call to +38 (000) 000‑00‑00".
It works on telephone fields, and on plain text fields holding a number. It depends
only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
set it up on a field's display, described in "How to use it" below.

## How to use it

Phone Link is applied from the Field UI's display settings:

1. Go to **Structure → Content types → *(your type)* → Manage display** (or the
   Manage display screen of any fieldable entity).
2. Find the text or telephone field that holds the phone number and, in the
   **Format** column, choose the **Phone link** formatter.
3. Optionally open the formatter's settings (the gear icon) to set a title/prefix
   text such as "Call to".
4. Click **Save**.

On the rendered page the number is now a clickable `tel:` link that opens the
dialler on a phone. Because it is just a formatter, you can switch it on or off per
display without affecting the stored data.
