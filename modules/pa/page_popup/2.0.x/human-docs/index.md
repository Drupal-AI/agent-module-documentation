# Page popup — manual setup guide

**Page popup** (`page_popup`) shows a configurable popup message on the pages you
choose — handy for announcements, notices, promotions, quotes, hints, or
consent‑style messages that should greet a visitor when they land on particular
pages. An administrator (or a permitted user) authors the message and picks which
pages it appears on, all without custom code.

Beyond the message text, you can style the popup: text color, background color,
font size, width, height, on‑screen position, and how long to wait before it
appears (the popup delay). A message can also be disabled without deleting it, so
you can turn a notice off and back on as needed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a popup message and set its
   text, styling, targeting, and timing.

## Where it lives in the admin menu

The module adds a configuration page at **Configuration → System → Page popup**
(`/admin/config/system/page_popup`, config route `page_popup.admin`). That is where
you add popup message entities and adjust their appearance.
