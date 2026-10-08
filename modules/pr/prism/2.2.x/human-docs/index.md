# Prism — manual setup guide

**Prism** (`prism`) adds code **syntax highlighting** to your Drupal content using
the lightweight [Prism.js](https://prismjs.com/) library — colouring code blocks by
language so tutorials, documentation, and code‑heavy articles are easier to read.

Prism is built around **explicit language declaration** (a `language-php` class on
the `<code>` element) and a set of plugins that documentation actually needs: line
numbers to reference in prose, line highlighting to draw attention, a
**copy‑to‑clipboard** button, and diff rendering. That makes it a good fit for a site
whose code blocks come from an editor that can record the language. (Highlight.js, by
contrast, leans on automatic detection and a large default build — a different
trade‑off.)

The module gives you two ways to apply highlighting:

- a **"Highlight code using prism.js" text filter** you add to a text format. It
  highlights both custom `[prism][/prism]` code blocks and standard `<pre><code>`
  blocks, and plays nicely with other filters that create code blocks (for example
  Markdown's ``` fences);
- a **"Prism.js" field** you add to any fieldable entity — each instance is a
  textarea plus a language selector for syntax highlighting.

> **Three practical points (true of any highlighter):**
> 1. **Build only the languages the site uses.** Prism's download tool exists for
>    this — shipping hundreds of grammars for the five you use is a classic
>    unnecessary payload.
> 2. **Highlighting must not alter the code.** A reader's copy‑paste has to produce
>    exactly what the author wrote, which is why the copy plugin is worth enabling.
> 3. **Where the library comes from is a site decision** — a local copy means you own
>    updates and avoid third‑party requests and CSP allowances.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module *and* the Prism.js
   library files, then enable it.

There is **no central module settings page** — you apply Prism per text format (the
filter) or per field (the Prism.js field). See "How to use it" below.

## How to use it

### Option A — the text filter

1. Go to **Configuration → Content authoring → Text formats and editors**, edit the
   format your code content uses (for example *Full HTML* or a Markdown format).
2. Enable the **"Highlight code using prism.js"** filter and save. Code inside
   `[prism]…[/prism]` blocks and standard `<pre><code>` blocks in that format is now
   highlighted on render.

### Option B — the Prism.js field

1. On a content type (or any fieldable entity), add a field of type **Prism.js**.
2. Editors fill in the code in its textarea and choose the language; the rendered
   output is highlighted accordingly.

Whichever you choose, remember the library‑build and library‑source points above —
the highlighting only covers the languages your installed `prism.js` build includes.
