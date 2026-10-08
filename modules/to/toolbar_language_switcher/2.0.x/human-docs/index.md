# Admin Toolbar Language Switcher — manual setup guide

**Admin Toolbar Language Switcher** (`toolbar_language_switcher`) adds a small
language control to Drupal's administration toolbar. It shows the language your
current page is in and, when you open it, lists your site's other enabled
languages as one‑click switch links — so an editor can flip the page they're
looking at into another language without hunting for the Language Switcher block.

The control appears as a toolbar item with a language icon. Its tray reuses the
exact same switch links that core's Language Switcher block would produce for the
current URL, so it respects whatever language negotiation you've configured (path
prefixes like `/es`, domain‑based languages, and so on) and only lists languages
that actually apply to the page you're on. It's scoped to the *interface*
language and to the current page, which makes it handy for translators moving
between the same node in different languages during review.

The module is deliberately tiny: there is **no settings form and nothing to
configure**. It becomes useful once two things are true — you have more than one
language enabled, and you've granted the `use toolbar_language_switcher`
permission to the roles that should see the control. It depends only on core's
**Language** and **Toolbar** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## How to use it

There is no configuration page. To make the switcher appear:

1. Make sure **more than one language** is enabled at **Configuration → Regional
   and language → Languages** (`/admin/config/regional/language`) — otherwise
   there is nothing to switch to.
2. Grant the **`use toolbar_language_switcher`** permission at **People →
   Permissions** (`/admin/people/permissions`) to the roles that should see the
   control (for example an *Editor* or *Translator* role).

Once a permitted user loads any page, a language icon appears in the admin
toolbar. Opening it reveals the switch links for the current page; clicking one
reloads the page in that language. Because it draws on core's language
negotiation, the links honour your configured URL scheme automatically.
