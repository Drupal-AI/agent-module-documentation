# Private Message Windows — manual setup guide

**Private Message Windows** (`private_message_windows`) adds a **LinkedIn- or
Facebook-style chat-window interface** to the
[Private Message](https://www.drupal.org/project/private_message) module. Instead
of sending people to a full-page thread view, it shows pop-up message windows
docked in the corner of any page, so members can carry on conversations while they
keep browsing the site.

You can place these chat windows on any page of your site, style the colour of the
window title bars to match your theme, and drop links of the form
`/private-message/create?recipient=XXX` (where `XXX` is a recipient's user ID)
onto pages so a visitor can open a new conversation right where they are.

This is purely a **presentation layer**. Who can message whom, message access, and
the threads themselves are all governed by the underlying **Private Message**
module — Private Message Windows only changes how the messaging UI looks and
where it appears. It has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Private Message, then enable it.

There is **no dedicated configuration page** for this module — you set up your
messaging rules, permissions, and threads in Private Message itself, and use the
placement techniques below to surface the chat windows.

## How to use it

- **Add the chat windows to your pages.** Once enabled, the windowed UI can be
  shown across the site so ongoing conversations dock in the page corner rather
  than taking over the screen.
- **Style the title bars.** Choose the colours for the window title parts so the
  chat windows fit your site's design.
- **Start conversations inline.** Place links to
  `/private-message/create?recipient=XXX` on profile pages, member cards, or
  anywhere it makes sense — clicking one opens a new dialog with that user right
  on the current page (replace `XXX` with the recipient's user ID).
- **Everything else stays in Private Message.** Configure permissions, who may
  message whom, and message settings in the Private Message module; this add-on
  simply presents them as chat windows.
