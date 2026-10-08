# Link Augmenter — manual setup guide

**Link Augmenter** (`link_augment`) is a plugin for the
[Date Augmenter](https://www.drupal.org/project/date_augmenter) system that adds a
**link to a rendered date**. A common use is turning an event's date display into
an actionable link — "RSVP on our meetup page", "Register", or a details page — so
the date isn't just text but a call to action.

By default the link is added only to **upcoming** events, which keeps past dates
clean, but you can configure it to add the link to **all** dates. Both the **URL**
and the **link text** support **tokens**, so you can build the destination and
label dynamically from the entity's own data. (The maintainers note planned support
for placeholders such as the field delta or the timestamp/ISO‑8601 date value.)

Because it plugs into Date Augmenter, you configure it wherever Date Augmenter's
options appear — on a date field's display — rather than on a settings page of its
own. It has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Date Augmenter) and enable it.

This module has **no central settings page**. You enable and configure the link
through Date Augmenter on a date field's display, described in "How to use it"
below.

## How to use it

1. On a bundle that has a **date field**, go to **Manage display**.
2. Open the date field's formatter settings, where **Date Augmenter** options
   appear.
3. Enable the **Link** augmenter and configure it:
   - the **URL** and **link text** (both accept tokens),
   - whether the link applies only to **upcoming** dates or to **all** dates.
4. Save the display. The rendered date now includes your link.
