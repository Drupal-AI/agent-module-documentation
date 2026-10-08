<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Token Value — manual setup guide

**Field Token Value** (`field_token_value`) adds a new field type whose value is
built from a token string and filled in automatically every time the entity is
saved. Instead of an editor typing the value, you configure something like
`[node:title] — [node:changed]` once, and on every save the module resolves those
tokens against the entity and stores the result in the field. It is the no-code
way to build a computed or derived text field.

Reach for it when you want a "display title" that combines several fields for
Views, a "last updated" line, an author byline that stays in sync, or an order
label like `Order #[commerce_order:order_number]` — anything you would otherwise
need a custom computed-field plugin for. Because the value is stored on the
entity like any other field, other modules and Views can read it directly.

The field's editing widget is hidden — editors never type the value, so it only
appears *after* the first save. When displaying the field, a text formatter lets
you wrap the value in an HTML tag (paragraph, heading, `blockquote`, `div`,
`span`, or no tag at all) and optionally link it to the entity. Developers can
define their own wrappers in a small YAML file and adjust the output with alter
hooks — see the [`agent/`](../agent/start.md) docs for that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Token dependency.

There is no central settings page — the module has no configuration form.
Everything is configured per field, on the bundle's *Manage fields* and *Manage
display* pages, as described below.

## Where it lives in the admin menu

Field Token Value has no admin menu item of its own. You work with it on the
field-management pages of whatever content type, user, taxonomy term, or media
type you are adding the field to — **Structure → Content types → (bundle) → Manage
fields**, and the matching **Manage display** tab.

## How to use it

1. On a bundle's **Manage fields** page, click **Add field** and choose the
   **Field Token Value** field type. Give it a label and save.
2. On the field's **settings** form you configure two things:
   - **Field value** — the token string that produces the value, for example
     `[node:title] ([node:nid])`. A Token browser is shown so you can pick valid
     tokens for this entity, and there is no visible text input because editors
     never type the value.
   - **Remove empty tokens** — on by default; unresolved tokens are cleared from
     the output. Turn it off if you want unresolved token markers to remain
     visible (useful for debugging).
3. On the bundle's **Manage display** page, the field's **text** formatter offers:
   - **Wrapper** — the HTML tag the value is rendered in (`p`, `div`, `span`,
     `h1`–`h6`, `blockquote`, `strong`, and more, or `no_tag` for none; the
     default is a paragraph).
   - **Link field value to entity** — wrap the output in a link to the entity.
4. Save an entity of that bundle. The value is generated on save, so it appears
   the moment you save and refreshes on every subsequent save.
