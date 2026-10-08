# Facebook Like Button — manual setup guide

**Facebook Like Button** (`fblikebutton`) automatically adds a Facebook *Like*
button to the content types you choose, so you do not have to paste Facebook's embed
code into every node by hand. It can add a **dynamic** button that likes the page
the visitor is currently on, a **static** button that likes a fixed URL (such as
your homepage), and an optional **block** with a Facebook Like box you can place
site‑wide.

The button's appearance is customisable by administrators: layout style, size, the
verb shown ("Like" or "Recommend"), colour scheme, language, and width. You control
which content type(s) show the button and which user role(s) may see it, and by default
the button appears only on a node's full page view — though you can extend it to
teasers too. Users do not need any extra text‑format permission for the button to be
added to their content.

> **Two practical notes.** First, a Like button targets an existing piece of content
> with a valid, *public* URL, so it may not work on a local or offline environment —
> Facebook has to be able to fetch the URL. Second, the button embeds Facebook's
> third‑party script, which can track visitors (even those who never click) and set
> cookies. Obtain appropriate consent, wire it into your cookie‑consent solution, and
> disclose the third‑party tracking as your jurisdiction requires (for example GDPR).

The module is configured at `fblikebutton.settings` and provides its own
permission; it has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the optional Like
   box block, and the viewing permission.

## Where it lives in the admin menu

The settings form is at the `fblikebutton.settings` route (under **Configuration**).
The *Access FB Like button* permission (at **People → Permissions**) controls which
roles can see the button. See [Configuration](configuration/index.md).
