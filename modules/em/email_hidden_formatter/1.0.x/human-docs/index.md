# Email Hidden Formatter — manual setup guide

**Email Hidden Formatter** (`email_hidden_formatter`) is a field formatter for
email fields that keeps the address **hidden by default** and reveals it
dynamically — via AJAX — only when a visitor clicks to show it. The point is to
reduce how easily automated crawlers can scrape addresses from your page markup,
while still giving real visitors a smooth way to get the address. It is a natural
fit for contact directories, staff listings, and user profiles.

You control the display through the field's settings on **Manage display**,
including how the label appears (hidden, above, or inline) and the text of the
reveal link. The module respects the display settings you configure there.

A welcome practical detail: it requires **no additional modules or external
libraries** beyond Drupal core's **Field** module — it works out of the box once
enabled. Bear in mind that hiding‑then‑revealing is a scraper *deterrent*: the
address still reaches the browser eventually, so treat this as friction against
casual harvesting rather than a guarantee of privacy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no settings page**. It is configured per field on the display,
described in "How to use it" below.

## Where it lives in the admin menu

Email Hidden Formatter adds no admin settings page. You configure it from
**Structure → Content types → *(your type)* → Manage display**, on an email field.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage display**
   for the type that contains the email field.
2. In the **Format** column for the email field, choose the **Email Hidden**
   formatter.
3. Click the settings cog to configure options — for example the reveal link
   text and label placement (hidden, above, or inline) — then save.
4. View a piece of content with that field: the address will be hidden until the
   visitor clicks to reveal it.
