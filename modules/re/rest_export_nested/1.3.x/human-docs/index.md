# REST Export Nested — manual setup guide

**REST Export Nested** (`rest_export_nested`) adds a Views display called **"REST
export nested"** that behaves just like core's REST Export, but with one important
extra: it automatically turns any field whose value is a *JSON string* into real
nested JSON in the output. Normally, if a Views field emits JSON, that JSON ends up
in your feed as an escaped, quoted string that the client has to parse a second
time. This display decodes those strings for you, so the response contains genuine
nested objects and arrays.

The classic use is embedding a sub‑view's rows inside a parent feed. Paired with
the **Views Field View** module, you build a child "REST export" display that
outputs related content as JSON, add it to a parent "REST export nested" display as
a field (passing the parent's ID as a contextual argument), and the parent feed
then embeds each row's children as proper nested JSON — perfect for handing a
decoupled front end a hierarchical payload in a single request. It also normalises
the literal string `"null"` to a real `null`, and handles HTML‑entity‑encoded JSON.

Because it works on any field that renders a bare JSON string, it isn't limited to
Views Field View — it decodes JSON that comes from a computed field, a plugin, or
any other source. The display is configured entirely in the Views UI (it adds the
same authentication‑provider option as core REST Export); there is no separate
settings page. It depends on core's **REST** and **Views** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There's no dedicated settings page. You use it inside the Views UI (**Structure →
Views**, `/admin/structure/views`) by adding the "REST export nested" display to a
view.

## How to use it

**1. Add the display.** In a view, click **Add display** and choose **REST export
nested**. Give it a path and choose the JSON serializer format, and set the
authentication providers under the display's **Authentication** option — exactly as
you would for a core REST Export display.

**2. Make sure JSON fields output raw.** If a field that contains JSON is being
wrapped in HTML markup, set that field's output to **Raw** in the row style options,
so the value is a bare JSON string the module can decode.

**3. (Optional) Embed a child view.** To nest a sub‑view's rows:

1. Enable **Views Field View** (`views_field_view`).
2. Build a *child* display of the related content as **REST export** (or **REST
   export nested**), with a contextual filter on the host entity's ID and the
   fields you want.
3. Build the *parent* display as **REST export nested** of the host entity type,
   adding its own fields (id, title, and so on).
4. In the parent, add a **Views field** (from Views Field View), point it at the
   child view/display, and pass the parent's ID as the contextual filter.

The child field emits a JSON string per row, and the nested display decodes it — so
the parent feed contains each row's children as nested JSON rather than an escaped
blob.
