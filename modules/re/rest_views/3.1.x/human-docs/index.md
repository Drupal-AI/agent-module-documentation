# REST Views — manual setup guide

**REST Views** (`rest_views`) fixes a long-standing annoyance with Views' REST
Export displays: by default, core runs every field through the render pipeline and
flattens it into a string, so your JSON feed ends up full of joined-together HTML
instead of proper data. REST Views lets those fields serialize as real JSON
structures — arrays for multi-value fields, nested objects for entity references,
and genuine booleans and numbers instead of quoted strings.

It works by adding, for every field in Views, a second **"Field (serializable)"**
handler. When you build a REST Export view, you pick the serializable variant of a
field instead of the normal one, and its value is preserved as real data all the
way through serialization. On top of that, REST Views ships a family of **export
formatters** that emit typed JSON — real `true`/`false` for booleans, JSON numbers
for numeric fields, nested entity structures for references, structured image/file
data, link objects, and more. These formatters only work with the serializable
handler.

This makes REST Views a clean foundation for a decoupled or headless front end,
letting you define your JSON API contract entirely through Views configuration
rather than writing custom REST resources. Submodules extend the set to
geolocation coordinates (`rest_views_geo`), entity reference revisions /
Paragraphs (`rest_views_revisions`), and Search API fields
(`rest_views_search_api`). Note that the export formatters emit **raw** values with
no output filtering, so consuming clients are responsible for escaping data safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (it needs core Views and REST), and pick any submodules.

## Where it lives in the admin menu

There is no dedicated settings page — everything is configured **per field inside a
REST Export view**, at **Structure → Views**
(`/admin/structure/views`). REST Views simply adds new field handlers and
formatters that appear there.

## How to use it

1. Create or edit a View and add a **REST Export** display.
2. When you **Add field**, look for the field's **"(serializable)"** variant — for
   example "Tags (serializable)" — and choose that instead of the plain field. The
   serializable handler preserves real data and automatically outputs multi-value
   fields as arrays (returning an empty array, not an empty string, when there's no
   value).
3. In that field's settings, pick one of the **export formatters** that matches the
   field type, for example:
   - **Boolean (export)** → real JSON `true`/`false`
   - **Number (export)** → a JSON number
   - **Entity reference (export)** → a nested object of the referenced entity's
     fields (with an optional `extra` metadata option)
   - **Entity reference / entity ID (export)** → just the target entity's id
   - **Entity path** → the referenced entity's URL/path
   - **Image (export)** → structured image data with optional alt/title
   - **File (export)**, **Link (export)**, **List (export)** → structured file, link
     (uri + title), and raw list values
4. Save the view and request its REST Export path — the output is now typed JSON.

You can freely mix rendered (HTML string) fields and exported (raw data) fields in
the same feed. For deeply nested reference or Paragraph data, combine a dedicated
display mode whose fields also use export formatters with the
`rest_views_revisions` submodule.
