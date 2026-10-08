# Field CSS — manual setup guide

**Field CSS** (`field_css`) turns **CSS into a field**. Add it to a bundle and an
editor can enter CSS rules that style that specific entity — a single node, a
block, a paragraph — without anyone opening the theme. It is the tidy answer to
"this one landing page needs a little bespoke styling" when a full theme edit would
be disproportionate.

The clever part is **scoping**. Field CSS wraps the rules in a per‑entity prefix
(`scoped-css--[entity-type]-[entity-id]`, sanitised through
`Html::cleanCssIdentifier`) so the styles apply only to that entity and do not leak
out to the whole page. It even tries to stop attempts to escape the prefix — it
strips `:root` from selectors and re‑applies the prefix to every selector it finds
inside `{ }`. That means one entity's CSS cannot accidentally (or deliberately)
restyle the rest of the site.

It ships **two widgets**: a **structured** one where the selector and the styles go
in separate fields (which allows the validation above), and a **free‑form** one
where you type all the CSS into a single text area. If the **CodeMirror** editor
library is present, you also get syntax highlighting.

> **Security — the permission is the real control.** CSS is more powerful than it
> looks, even when scoped: `background-image: url(...)` can load remote resources,
> attribute‑selector tricks can exfiltrate data, and CSS can reshape the UI for
> clickjacking‑style attacks. Scoping limits the blast radius but does **not** make
> arbitrary CSS harmless. Entering CSS is closer to a **developer** capability than
> an editorial one, so grant the **`access css fields`** permission narrowly — to
> trusted content authors only, never to all authenticated users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its CodeMirror Editor dependency.

There is **no central settings page** — you add the field and grant the permission,
as described in "How to use it" below.

## How to use it

1. **Add a CSS field** to a bundle: **Structure → (content type or bundle) → Manage
   fields → Add field**, choose the CSS field type, and save.
2. On **Manage form display**, pick the **structured** widget (separate selector /
   style inputs, with validation) or the **free‑form** widget (one text area).
3. **Grant `access css fields`** on **People → Permissions**
   (`/admin/people/permissions`) to the trusted roles that should be allowed to
   enter CSS — and only those roles.
4. Edit an entity of that bundle and enter CSS. The rules render **scoped to that
   entity**, so they style it without affecting the rest of the page.

For a site where trusted editors occasionally need per‑entity styling, this is a
neat alternative to theme edits — just keep the permission tight and treat CSS
input with the same care as any powerful, trusted‑user capability.
