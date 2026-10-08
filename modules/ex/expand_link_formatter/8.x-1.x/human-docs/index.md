# Expand link formatter — manual setup guide

**Expand link formatter** (`expand_link_formatter`) is a field formatter that
shows a long text field as a short excerpt with a **"read more"** link that
expands the rest in place. It's a tidy way to keep listings and content‑heavy
pages compact without sending the reader to a separate page, and it does the
expand/collapse without jQuery.

You decide where the fold happens in one of two ways. Either an editor places an
explicit **separator** in the body — by default an `<hr>` — and everything after
it becomes the expandable part; or, if there's no separator and you've set a
**maximum character length**, the formatter auto‑trims the text at a word boundary
and turns the remainder into the expandable section. If neither applies (no
separator, and the text is shorter than the limit), it simply renders the whole
field with no link.

It works on `text_long` and `text_with_summary` (body) fields on any entity
display. Both the collapsed and expanded parts are rendered through Drupal's
processed‑text pipeline using the field's own text format, so your normal
filtering and sanitisation still apply, and the custom link labels are additionally
run through `Xss::filter`. One thing to know: the auto‑trim path uses the **Views**
module's text‑trimming helper, so Views must be enabled if you rely on trimming by
character length. The module has no other dependencies and supports Drupal 8
through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings form** — you choose and configure the formatter on
a field's *Manage display*, described below.

## Where it lives in the admin menu

The formatter has no admin page of its own. You apply it per field under
**Structure → Content types → *(your type)* → Manage display**.

## How to use it

1. Go to the entity's **Manage display** tab — for example **Structure → Content
   types → Article → Manage display**.
2. For a `text_long` or `text_with_summary` field (such as **Body**), set the
   **Format** to **Expand link formatter**.
3. Click the gear icon to configure:
   - **Separator** — the marker in the body where the fold happens (default
     `<hr>`). Text after it becomes the expandable part.
   - **Expand link label** — the link text that reveals the hidden part (default
     "Read more").
   - **Collapse link label** — the link text that hides it again (default "Read
     Less").
   - **Maximum characters before trimming** — if greater than 0 **and** no
     separator is found, the text is auto‑trimmed at a word boundary and the rest
     becomes expandable. Set it to **0** to disable auto‑trim.
4. Save the display.

**Behaviour in short:** if the body contains the separator, it splits there;
otherwise, if the character limit is set and reached, it trims via Views; otherwise
it renders the whole field with no expand link. Because auto‑trim relies on Views,
keep the **Views** module enabled if you use the character‑limit path. You can also
override the `expand_link_formatter` Twig template in your theme to restyle the
markup.
