# Expand Collapse Formatter — manual setup guide

**Expand Collapse Formatter** (`expand_collapse_formatter`) is a field formatter that
shows a long text field trimmed to a preview length with a **"Show more / Show less"**
toggle, so visitors can expand or collapse the full value in place. It is the simple,
no‑code way to add a "read more" behavior to a body, description, or biography field
without splitting it into a separate summary.

You apply it on an entity's **Manage display** screen to any multi‑line text field —
Text (formatted, long), Text (plain, long), and text‑with‑summary variants. The
formatter renders the field, and a small piece of JavaScript measures its length and,
*only if it is longer than your trim length*, inserts a toggle link that swaps between
the trimmed preview and the full content.

Importantly, the trimming happens in the browser: the complete field markup is still
delivered to the page, so collapsed content stays crawlable and SEO‑friendly. The
module has no admin settings page — every option lives in the per‑field formatter
settings — and it needs no PHP dependencies or external libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the plugin id, theme hook, and
JavaScript behavior — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no global configuration; you turn the formatter on per field:

1. Go to **Structure → Content types → *your type* → Manage display** (or the Manage
   display screen of any entity type — media, taxonomy term, user, and so on).
2. Find your long‑text field and set its **Format** to **Expand collapse formatter**.
3. Click the **gear** on that field row to open the settings, adjust them (below),
   click **Update**, then **Save**.

### The settings

| Setting | Default | What it does |
|---------|---------|--------------|
| **Trim length** | `300` | The character count the field is trimmed to when collapsed. The toggle link only appears when the field's text is longer than this. |
| **Default state** | `collapsed` | Whether the field starts **collapsed** (showing the preview) or **expanded** (showing everything, with a *Show less* link). |
| **Open link text** | `Show more` | The toggle label shown while collapsed. Change it to, say, "Read more". |
| **Close link text** | `Show less` | The toggle label shown while expanded, e.g. "Read less". |
| **Open link class** | `ecf-open` | A CSS class added to the toggle link while collapsed, so you can style it. |
| **Close link class** | `ecf-close` | A CSS class added to the toggle link while expanded. |

The trimming is done at a word boundary with a trailing " ..." so it never cuts a
word in half. You can reuse the same settings across many fields and bundles to keep a
consistent preview length site‑wide.
