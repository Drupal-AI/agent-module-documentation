# The "REST export nested" display

## Add the display

In a View, **Add display → "REST export nested"** (plugin id `rest_export_nested`). Give it a
path, choose the serializer format (JSON), and set authentication providers under the display's
**Authentication** (`auth`) option — exactly like core's REST Export. There is no module
settings page; everything is per-view config.

Config lives under `views.display.rest_export_nested` (mapping key `auth`: a sequence of
authentication provider ids).

## What it does at render time

`RestExportNested::render()`:
1. Renders the view through its serializer style plugin (as core REST Export does).
2. `json_decode()`s the result, then **flattens** it: for every row, every **string** field
   value is passed to `json_decode()`. If it parses, the string is replaced with the decoded
   object/array (so it becomes nested JSON, not an escaped string). It also retries with
   HTML-entity-decoded input for entity-encoded JSON.
3. The literal string `"null"` is converted to a real `null`.
4. Re-encodes to JSON for the response.

So any field that outputs a **bare JSON string** (no surrounding HTML) becomes real nested
JSON automatically.

## Recipe: embed a child view as nested JSON (Views Field View)

1. Enable **Views Field View** (`views_field_view`).
2. Build a **child** display of the related content (e.g. Articles) as type **"REST export"**
   or **"REST export nested"**; add a relationship/contextual filter on the host entity id and
   the fields you want.
3. Build the **parent** display as **"REST export nested"** of the host entity type; add
   `nid`, `title`, etc.
4. In the parent, add a **Views field** (from Views Field View), point it at the child
   view+display, and pass the parent's `nid` as the contextual filter.
5. The child field now emits a JSON string per row; the nested display decodes it, so the
   parent feed contains each row's children as **nested JSON**.

## Tips

- If a JSON field is being wrapped in markup, set that field's **output to "Raw"** in the row
  style options so the value is a bare JSON string the module can decode.
- Works with any source of JSON-string field output, not only Views Field View.
