# Expandable Formatter — manual setup guide

**Expandable Formatter** (`expandable_formatter`) is a field formatter that keeps
long text compact by collapsing it to a set **height** and giving the visitor a
"read more / read less" toggle to expand it in place. It's a close cousin of the
[Expanding Formatter](https://www.drupal.org/project/expanding_formatter) module,
but with a key difference: instead of trimming by a number of characters, it trims
by a specific pixel height. That means every collapsed block is the same height,
giving you a predictable, tidy layout every time regardless of how the text wraps.

Use it to keep long descriptions, bios, or summaries neat in listings and let
readers expand them without a page reload. You control the collapsed height, an
optional ellipsis, the trigger labels, the CSS classes, and the animation effect
and its duration — so it can be styled and tuned to fit your theme.

Output is safe: formatted text is rendered through Drupal's processed‑text
pipeline (respecting the field's text format), and plain values are escaped via
Twig autoescaping. It depends only on core's **Field** module and has no
access‑control role — it's purely about presentation. It supports a wide range of
core versions (Drupal 8.7.7 through 12).

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
2. For a text‑based field (such as **Body**), set the **Format** to
   **Expandable**.
3. Click the gear icon to configure the options that appear, which include:
   - the **collapsed height** the text is trimmed to,
   - an optional **ellipsis** on the truncated preview,
   - the **trigger labels** (the "read more" / "read less" text) and their CSS
     classes,
   - the **animation effect** and its **duration**.
4. Save the display.

Now that field shows a fixed‑height preview with a toggle; clicking it expands the
full text in place and clicking again collapses it back — with the same predictable
height every time.
