# Ajax Command Page Reload — manual setup guide

**Ajax Command Page Reload** (`ajax_command_page_reload`) is a small developer
tool that adds one thing to Drupal's AJAX system: a command that tells the
browser to reload the current page. It is for the cases where a partial AJAX
update simply cannot express what changed.

Drupal's AJAX system works by returning a list of commands from the server —
replace this element, insert that markup, open a dialog, show a message. That
model works well when a change is local to one region. It works badly when a
change is global: a submission that alters the user's roles, switches the active
language, or changes a site-wide setting invalidates the page's cached blocks,
menus and contextual links. Replacing one region then leaves the rest of the
page describing a state that no longer exists. A full reload is the honest
answer, and having it as a **command** — rather than a lump of inline
JavaScript — keeps it inside the AJAX framework where the rest of your response
already lives.

Two things are worth keeping in mind. A reload **discards the visitor's state**
(scroll position, other open dialogs, unsaved input elsewhere on the page), so
reach for it deliberately rather than the first time a partial update turns
fiddly. And on a form, Drupal's normal **post-submit redirect** usually gets you
the same fresh page through the framework's own path — this command is for the
cases where there is no submission to redirect from.

This guide is written for a **human** installing and using the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

This is a developer utility, not a click-to-configure feature — it has no
settings page. Once enabled, the reload command is available to your own code
(custom forms, controllers, dialog submit handlers) as an AJAX command you can
return from the server, so the browser reloads the current page as part of the
normal AJAX response. See the [`agent/`](../agent/start.md) docs and the
project page for the exact class to use in code.
