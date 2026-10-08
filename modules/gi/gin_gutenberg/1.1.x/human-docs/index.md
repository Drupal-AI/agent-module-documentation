# Gin Gutenberg — manual setup guide

**Gin Gutenberg** (`gin_gutenberg`) is a small "glue" module that makes the
**Gutenberg** block editor look and behave correctly inside the **Gin** (or
Claro) admin theme on node add/edit forms. On its own, Gutenberg's React‑based
editor doesn't quite line up with Gin's design — spacing is off, the sidebar can
misbehave, and the Publish/moderation controls sit in an awkward place. This
module reconciles the two.

It has **no settings of its own**. It stores no data and changes no content — it
simply activates through hooks whenever two conditions are true: Gutenberg
full‑editing is turned on for a content type, and the active admin theme is Gin or
Claro. When those hold, it adds a `gutenberg--enabled` class that Gin's CSS keys
off, attaches its own CSS/JS only on the relevant node forms, swaps in dedicated
page templates for the node add/edit screens, opens the metabox field group, and
moves the **Published** status (and the moderation state control on moderated
types) into Gutenberg's right‑hand "meta" sidebar. It also fixes a known blank
Gutenberg sidebar bug on the content‑translation add form.

Because there is nothing to configure on this module directly, "setting it up"
really means making sure the surrounding pieces are in place — the Gutenberg
module, a Gin/Claro admin theme, Gutenberg enabled on your content type, and the
editing role holding the `use gutenberg` permission. The checklist below walks
through it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Gutenberg)
   with Composer and enable it.

## Where it lives in the admin menu

Gin Gutenberg has **no admin page**. Its effect appears on the node **Add**/**Edit**
forms of Gutenberg‑enabled content types when Gin or Claro is your admin theme.
The pieces you *do* touch live elsewhere: content‑type editing at **Structure →
Content types**, the admin theme at **Appearance** (`/admin/appearance`), and the
`use gutenberg` permission at **People → Permissions**.

## How to use it

There is no form to fill in — you satisfy the conditions that make the
integration switch on. The practical checklist:

1. **Enable the modules** — Gutenberg (`gutenberg`) and Gin Gutenberg
   (`gin_gutenberg`). See [Installation](installation/index.md).
2. **Use Gin (or Claro) as the admin theme** — at **Appearance**
   (`/admin/appearance`), set the administration theme to **Gin** (or Claro).
3. **Turn on the Gutenberg experience for your content type** — at **Structure →
   Content types → *(your type)* → Edit**, enable **"Enable Gutenberg experience
   for this content type."** (This is Gutenberg's own setting, not Gin
   Gutenberg's.)
4. **Grant the `use gutenberg` permission** — at **People → Permissions**, give
   your editor role the *Use Gutenberg* permission (provided by the Gutenberg
   module).

With all four in place, open a node of that type to add or edit it: the editor
now renders in Gin's style, with the Publish and moderation controls tucked into
the Gutenberg sidebar. If it doesn't kick in, re‑check that the content type has
the Gutenberg experience enabled and that your admin theme is Gin/Claro — those
are the two switches the module waits on.
