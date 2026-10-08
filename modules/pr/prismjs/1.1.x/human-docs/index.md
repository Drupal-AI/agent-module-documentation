# Prism Js syntax highlighter — manual setup guide

**Prism Js syntax highlighter** (`prismjs`) brings code **syntax highlighting** to
**CKEditor 5**. It gives editors a toolbar button for inserting a code block,
choosing its language from a dropdown, and having the code coloured on the page with
the [PrismJS](https://prismjs.com/) library — the editor side and the display side
come from the same module, so they agree on which language a block is in.

That agreement is the module's key advantage on a documentation site. An editor
choosing "PHP" from a dropdown and a renderer *guessing* the language from the
content are two different mechanisms, and only the first is reliable. Because this
module supplies both the CKEditor 5 plugin and the renderer, the language an editor
picks is the language that gets highlighted. (Its sibling `prism` integrates the
library for *rendering only* — use this one when you want editors inserting code
through CKEditor 5.)

Editors don't need any special permission to insert styled code — the capability
comes with the text format's toolbar. An administrator configures which **languages**
and which **theme** are available, on the module's settings page.

> **Three practical points (true of any highlighter):**
> 1. **Build/enable only the languages the site uses** — hundreds of grammars for
>    five is an unnecessary payload.
> 2. **Highlighting must not alter the code** — a reader copies what they see, so
>    enable the **copy‑to‑clipboard** plugin rather than trusting selection.
> 3. **Where the library comes from is a site decision** — local vs CDN affects
>    third‑party requests and CSP.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (CKEditor 5 is required).
2. [Configuration](configuration/index.md) — choose available languages and the
   default theme, and add the button to your CKEditor 5 toolbar.

## Where it lives in the admin menu

The languages/theme settings live at **Configuration → Content authoring → Prism
Js** (`/admin/config/content/prism-js`). The toolbar button itself is added per text
format under **Text formats and editors**. See
[Configuration](configuration/index.md).
