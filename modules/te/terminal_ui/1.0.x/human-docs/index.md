# Terminal UI — manual setup guide

**Terminal UI** (`terminal_ui`) renders your site's homepage as a beautifully
formatted, terminal‑style plain‑text page when it is requested with `curl`. Run
`curl https://yoursite.com/` and, instead of raw HTML, you get a neatly laid‑out
page complete with an ASCII logo, an about box, social links, and a feed of your
latest posts. Ordinary visitors in a web browser see your site exactly as before —
nothing changes for them.

It is built for sites organised around a single content type — blogs, personal
sites, portfolios — so that command‑line users get a polished, first‑class reading
experience rather than a wall of HTML markup. The output uses ANSI styling: colors,
bold and dim text, box‑drawing borders, and OSC 8 hyperlinks that are clickable in
modern terminals. It is equal parts useful utility and fun way to show your content
off to the developer crowd.

The magic is entirely in how the request is detected: the module intercepts a
request **only** when the User‑Agent contains `curl`, and only for the homepage.
Browsers, search engines, and every other tool are completely unaffected, so there
is nothing to set up for regular visitors and no risk to your normal site output.

Terminal UI does **not** show anything until you configure it — it installs with no
default content, so you build your terminal view on its settings page. It depends
on the **Token** module (`token`), which it uses to substitute values like
`[site:name]` and `[site:base-url]` into your configured text, and it supports
**Drupal 10 and 11**. Administration is gated by the *Administer Terminal UI*
permission (granted to the administrator role by default). It ships no submodules
and has no content role of its own. (Note: this project is not yet covered by
Drupal's security advisory policy.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build your terminal view: header,
   body, and content feed.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Terminal UI**
(`/admin/config/user-interface/terminal_ui`). You need the *Administer Terminal
UI* permission to reach it.
