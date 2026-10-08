# printfriendly — manual setup guide

**printfriendly** (`printfriendly`) adds a **Print Friendly & PDF** button to the
content types you choose. When a visitor clicks it, the third‑party
[PrintFriendly.com](https://www.printfriendly.com) widget opens and lets them
print the page, email it, or download it as a clean PDF — without you having to
build a print stylesheet or host a PDF library on your server.

It's a thin integration with the hosted PrintFriendly service. On every page the
module injects a small inline script that loads PrintFriendly's widget from
`cdn.printfriendly.com` and sets its options from your configuration. On nodes of
the enabled types (and optionally on teasers), it renders the button — a link to
`printfriendly.com/print?url=…` pointing at the current page — but only for users
who hold the **Access printfriendly** permission.

A single settings page controls everything: which content types show the button,
which button image to use, and PrintFriendly's own feature toggles — header logo
and tagline, whether images are included and how they're aligned, whether the
email/PDF/print actions are offered, click‑to‑delete, and a custom CSS URL for the
printout.

> **Third‑party service note.** The printable version is produced by
> PrintFriendly.com: the visited page's URL is sent to their service, and their
> JavaScript, button images, and CSS load from `cdn.printfriendly.com` on every
> page. This is a privacy/deployment consideration, not a bug. Note also that
> printing password‑protected or JavaScript‑rendered pages requires a
> PrintFriendly **Pro** subscription (since their servers fetch the page to build
> the printable version). No API key is required for the basic button.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus permissions.

## Where it lives in the admin menu

The settings form is at `/admin/config/printfriendly/config`, reachable by users
with the **Administer printfriendly** permission.

## How to use it

1. On the settings form, tick the content types (and optionally teasers) that
   should show the button, and choose a button image.
2. Adjust PrintFriendly's feature toggles to taste (header/logo, images, which
   actions to offer, and so on).
3. Grant the **Access printfriendly** permission to the roles that should see the
   button.

The button then appears on the enabled content, and clicking it opens the
PrintFriendly widget. The [Configuration](configuration/index.md) guide covers
every option.
