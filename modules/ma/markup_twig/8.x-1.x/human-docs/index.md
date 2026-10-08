# Markup Twig — manual setup guide

**Markup Twig** (`markup_twig`) extends the **Markup** field with **Twig** support.
A plain markup field holds static HTML; sometimes you need a little logic in
there — a token, a loop, a conditional. Markup Twig lets you write Twig in a markup
field and have it rendered, so the field can produce dynamic output instead of only
fixed HTML.

It is designed to be the *correct* pattern for admin‑authored templating, and both
of its security‑relevant behaviours are verified:

- **Rendering is sandboxed.** The field's content is rendered through Drupal's
  `inline_template` mechanism, which uses Drupal's **sandboxed Twig environment** —
  so the usual template‑injection route from Twig to arbitrary code execution is
  blocked.
- **Editing is permission‑gated.** Writing the Twig requires the **administer markup
  fields** permission; for users without it, the field is disabled.

That permission is the trust boundary. Someone who can edit the Twig writes
templates that render on your site — they can loop, call permitted functions, and
embed content — so **administer markup fields** belongs to developers and trusted
site builders, **never to ordinary content editors**. Granted narrowly, this is a
safe way to add logic to markup fields (the same shape as the Snippet Manager
module).

Markup Twig depends on the **Markup** module and on core's **Field** module, and it
supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (including the Markup dependency) and enable it.

There is **no central settings form** for this module. You set it up per field, as
described under "How to use it" below.

## Where it lives in the admin menu

Markup Twig adds no admin settings page. You grant its permission at **People →
Permissions** (`/admin/people/permissions`), then use it on a markup field's **Manage
form display** and **Manage display** for the relevant bundle.

## How to use it

1. At **People → Permissions**, grant **Administer markup fields** to your trusted
   roles (developers / site builders only).
2. Add a **Markup** field to your entity, under **Structure → Content types → *(your
   type)* → Manage fields**.
3. On the bundle's **Manage form display**
   (`admin/structure/types/manage/*/form-display`), set that field's **widget** to
   **Markup Twig**.
4. On the bundle's **Manage display** (`admin/structure/types/manage/*/display`), set
   that field's **formatter** to **Markup Twig**. If you skip this, the Twig is
   output as plain text rather than rendered.
5. Write Twig in the field. For example, to render the entity title:
   `{{ node.title }}` (use `user`, `term`, etc. for other entity types).

> **Tip:** Pair it with the [Twig Tweak](https://www.drupal.org/project/twig_tweak)
> module for handy extra filters — for example `{{ node.field_tags|view }}` to render
> another field. To inspect the available variables, `{{ kint() }}` works when Twig
> debugging is enabled.
