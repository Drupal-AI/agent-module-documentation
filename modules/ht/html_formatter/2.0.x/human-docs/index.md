# HTML Formatter — manual setup guide

**HTML Formatter** (`html_formatter`) is a family of field *formatters* that wrap a
field's value in a configurable HTML tag — an `h2`, `div`, `article`, `span`,
whatever you need — with an optional CSS class and an optional link to the host
entity. It's the lightweight, dependency-light way to add a semantic wrapper and a
styling hook to a field without writing a Twig template or reaching for the heavier
*Fences* module.

You choose it per field on the **Manage display** tab, then set three things in the
formatter's settings: the **tag** to wrap the value in (leave it blank and no
wrapper element is added at all), a **class** for that wrapper, and a **link**
checkbox that turns the value into a link to the entity's canonical page. The output
renders through a tiny template that emits `<tag class="…">value</tag>`.

Four formatters cover the common field types: a plain one for text and string
fields, plus variants that extend core's DateTime, Timestamp, and Entity Reference
Label formatters — so the date and reference variants keep their parent's own
settings (date format, link-to-entity, and so on) and simply add the tag/class/link
wrapper on top.

**A trust note worth reading before using it on rich text.** This is a wrapper
formatter, not a text-format renderer. The **tag** and **class** come straight from
admin-entered display config, so only grant the "administer display" permission to
trusted roles. And the plain text formatter emits the field's raw stored value
without running the field's text-format filter — so use it on fields authored by
trusted roles, or on plain `string` fields where no HTML is expected, rather than as
a way to sanitize untrusted markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no global settings page — you pick an HTML Formatter per field on the
entity's **Manage display** tab.

1. Go to the bundle's **Manage display** — for a content type that is **Structure →
   Content types → (type) → Manage display**
   (`/admin/structure/types/manage/<bundle>/display`).
2. For a compatible field, set its **Format** to the matching HTML Formatter:
   - **plain text / string** fields (`text`, `text_long`, `text_with_summary`,
     `string`, `string_long`) → the base *HTML Formatter*.
   - **datetime** fields → the DateTime variant.
   - **timestamp / created / changed** fields → the Timestamp variant.
   - **entity reference** fields → the Entity Reference Label variant.
3. Click the field's **cog** to open the formatter settings and fill in:
   - **Tag** — the HTML element to wrap the value in (e.g. `h2`, `div`, `article`).
     **Leave blank to output the value with no wrapper element at all.**
   - **Class** — a CSS class added to the wrapper. Blank means no class.
   - **Link to Content** — tick to wrap the value in a link to the host entity's
     canonical URL (applies only when the entity is saved and has a canonical page).
4. Click **Update**, then **Save**.

For the date and entity-reference variants, the parent formatter's own settings
(such as the date format, or "link label to the referenced entity") still appear and
work — the HTML wrapper is applied on top of the parent's output.
