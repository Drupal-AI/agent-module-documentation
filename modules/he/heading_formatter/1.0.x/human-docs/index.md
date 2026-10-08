# Heading formatter — manual setup guide

**Heading formatter** (`heading_formatter`) is a small, focused field formatter.
It takes a plain-text field — a `string` or `textfield` — and renders its value
as an HTML heading (`<h1>`, `<h2>` or `<h3>`) with a CSS class you choose. That's
the whole job: it lets site builders turn an ordinary text field into a properly
tagged, consistently styled heading without writing template code or hand-editing
markup.

It's handy when you have a field that is really a heading in disguise — a
subtitle, a section title, a short summary you want emphasised — and you want it
to come out as a real heading element with a class your theme's CSS can hook
onto. Because it's a field formatter, you set it up entirely on the entity's
**Manage display**, and you can use a different heading level per view mode (say
an `<h2>` in the full view and an `<h3>` in the teaser).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** for this module. All of its settings
live on the field formatter itself, in **Manage display** — described below.

## Where it lives in the admin menu

Heading formatter adds no admin page of its own. You use it from **Structure →
Content types (or any entity bundle) → *(your bundle)* → Manage display**.

## How to use it

1. Go to the **Manage display** page for the content type or entity bundle that
   holds your text field — for example **Structure → Content types → *(your
   type)* → Manage display**.
2. Find the plain-text (`string` / `textfield`) field you want to render as a
   heading.
3. In that field's **Format** dropdown, choose **Heading**.
4. Click the settings gear for the field to configure the formatter:
   - **Heading level** — pick `H1`, `H2` or `H3`.
   - **CSS class** — enter the class (or classes) you want applied to the
     heading tag, so your theme's styles can target it.
5. **Update**, then **Save** the display.

Repeat per view mode if you want different heading levels in, say, the teaser
versus the full display. To stop using it, just switch the field's format back to
the default text formatter.
