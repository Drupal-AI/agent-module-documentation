# HTML Script Formatter — manual setup guide

**HTML Script Formatter** (`html_script_formatter`) is a field formatter that outputs
a field's stored value **exactly as it is, unescaped** — rendering it directly as
HTML, including `<script>` tags and any other markup. It adds itself as a display
option on text and string fields (it works on `text`, `text_long`,
`text_with_summary`, `string`, and `string_long` fields), so on a field's *Manage
display* you can choose it and have the raw value emitted into the page verbatim. Its
intended use is embedding scripts or arbitrary markup that a field holds.

> **Read this before you use it.** Whatever is stored is printed with no escaping
> (the module's own note is that "the user input should equal the output"), and it
> also applies to plain **`string` / `string_long`** fields, which have no text
> format.
>
> Only ever apply this formatter to fields that are editable **exclusively by
> fully‑trusted administrators**. Never expose such a field to content authors or any
> lower‑privileged role. Wherever the value isn't guaranteed to be trusted, use a
> real **text format** instead of this formatter. This
> module has no access‑control features of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** for this module. You apply it per field on the field's
*Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

HTML Script Formatter adds no admin settings page. You use it entirely from
**Structure → *(content type / entity bundle)* → Manage display**, where it appears
as a format option for eligible text and string fields.

## How to use it

1. Confirm the field you're formatting is **only editable by trusted
   administrators** — this is the single most important step.
2. Go to the bundle's **Manage display** (for example **Structure → Content types →
   *(type)* → Manage display**).
3. For the text or string field you want, set its **Format** to **HTML Script
   Formatter**.
4. Save the display. The field's raw value will now be rendered as unescaped HTML
   wherever that view mode is shown.

Use this sparingly and only where the trust boundary is airtight; for anything an
ordinary editor can touch, prefer a proper text format.
