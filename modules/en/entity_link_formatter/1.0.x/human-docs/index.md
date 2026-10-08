# Entity Link Formatter — manual setup guide

**Entity Link Formatter** (`entity_link_formatter`) is a field formatter that
renders an entity reference field as a plain **hyperlink** instead of the full
rendered content of the referenced entity. Where the default reference formatters
either print a label or embed the whole referenced entity, this one gives you a
compact link that points at one of the referenced entity's link templates — its
canonical (view) page, its edit form, and so on.

That link-template choice is what makes it more than a simple "link to content"
formatter. Because you can target *any* of an entity's templates, you can, for
example, show an **Edit** link next to each referenced node, give it your own
link text, and even append a `?destination=` parameter so the editor is returned
to the page they came from once they finish editing. It's a content-display
feature only — following the link still runs the referenced entity's normal
access checks, so it grants no extra access of its own.

Entity Link Formatter runs on Drupal 10 and 11, has no third-party dependencies,
and works entirely from a field's **Manage display** screen — there is no
separate settings page to visit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
set it up per field on **Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

Entity Link Formatter adds no admin page of its own. You use it entirely from a
bundle's display settings under **Structure → Content types (or any entity
type) → *(bundle)* → Manage display**.

## How to use it

1. Add (or find) an **entity reference** field on a content type or other
   fieldable entity.
2. Go to that bundle's **Manage display**, find the reference field, and set its
   **Format** to the Entity Link formatter.
3. In the formatter's settings, choose which **link template** to link to
   (for example *canonical* to link to the view page, or *edit-form* to link to
   the edit page), set the **link text**, and — if you're linking to a form —
   optionally add a `?destination=` parameter so the user returns to the current
   page afterward.
4. Save the display. Each referenced entity now renders as your configured link.
