# Better Status Messages — manual setup guide

**Better Status Messages** (`better_status_messages`) restyles Drupal's status,
warning, and error messages and adds a **close button** so visitors can dismiss a
message once they have read it. The result is a more polished, tidier message area
than core's default block of coloured boxes.

Those messages — "Your changes have been saved", form validation errors, and so
on — are useful but they linger and can clutter the top of the page. With this
module a reader can clear them away with a click, and the messages themselves look
more refined.

This is purely a front‑end/UI enhancement. It changes only how messages are
*displayed* — it does not change which messages Drupal generates, and it has no
effect on permissions or access behaviour. It has no dependencies and works across
Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. Once the module is enabled, status, warning, and
error messages are shown in the styled, dismissible form automatically. To see it,
perform any action that produces a message (for example saving a form) and you
should see the restyled message with a close button you can click to dismiss it.
