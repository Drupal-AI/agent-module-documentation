# Configuration

Context Breadcrumb has two parts: a small **settings form** (a single JSON‑LD
toggle), and the real work of **defining breadcrumbs on a Context**.

## The settings form

1. Log in as a user with the **Administer context breadcrumb** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Context Breadcrumb**
   (`/admin/config/user-interface/context-breadcrumb`).

The form has one option:

- **Enable JSON‑LD** — off by default. When you turn it on, Context Breadcrumb
  outputs your breadcrumbs as a Schema.org `BreadcrumbList` in
  `application/ld+json` structured data on non‑admin pages, which helps search
  engines show breadcrumb rich results. Admin routes are excluded automatically.

Save the form.

## Defining breadcrumbs (on a Context)

The breadcrumb rows themselves are **not** stored in this form — they live on a
Context entity's Breadcrumb reaction:

1. Go to **Structure → Context** (`/admin/structure/context`) and add or edit a
   context.
2. Add **conditions** to control where the context (and its breadcrumb) applies —
   for example a path, a role, or the **taxonomy vocabulary** condition this
   module provides.
3. Add the **Breadcrumb** reaction. It shows a draggable table of up to nine
   rows, each with:
   - **Title** — the visible label for that breadcrumb segment.
   - **URL** — where the segment links. Use `<front>` for the front page,
     `<nolink>` for a non‑linked segment, an absolute `http(s)://…` URL, or an
     internal path starting with `/`.
   - **Token** — set this to **Yes** when the title or URL contains a token
     (validation enforces this). When Yes, you can use tokens such as
     `[node:title]`, `[term:name]`, or the special `[term_hierarchy]` token that
     builds a trail from a taxonomy term's ancestors (it even accepts a field
     pointer, e.g. `[term_hierarchy:node:field_category]`).
   - **Weight** — drag rows to set their order in the trail.
   - **Cache query args** — optionally, newline‑separated query arguments to vary
     the breadcrumb's cache on (use `!all` to cache on every query argument).
4. Save the context.

Note that if a row has a title it must also have a URL (and vice versa), and a
token flag set appropriately. Once saved, the context's breadcrumb is applied by
Context Breadcrumb's high‑priority breadcrumb builder, overriding the site's
default breadcrumb wherever that context is active.

## Tips

- Show **different breadcrumbs on different pages** by creating several contexts
  with different conditions.
- Provide **taxonomy‑hierarchy** breadcrumbs on term pages using the
  `[term_hierarchy]` token.
- The Token module adds a browsable token picker to the reaction form — install
  it if you use tokens heavily.
