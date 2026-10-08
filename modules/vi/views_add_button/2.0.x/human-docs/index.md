# Views Add Button — manual setup guide

**Views Add Button** (`views_add_button`) lets you drop a configurable
"add an entity" button into any View — as a header/footer **area** or as a
per‑row **field** — that links straight to an entity's create form. It is the
tidy way to put an **Add article** (or Add user, Add term, Add anything) button
at the top of a content listing without nesting views or writing a custom
handler.

The button is more than a plain link. It checks **create access** for the target
entity type and bundle, so it simply does not render for a user who cannot create
that content (you can show custom "access denied" HTML instead if you prefer). It
supports **tokens**, so a button can carry values from the View's contextual
filters into a query string or route parameter — useful for pre‑filling fields on
the add form or scoping the new entity to a Group. You can style it as a themed
button with CSS classes, append a `destination` so the user comes back to the
View after saving, and add prefix/suffix HTML around it.

Out of the box it knows how to build the correct add URL for **nodes**, **taxonomy
terms**, **users**, and **ECK** entities, with a sensible `/{entity_type}/add/{bundle}`
fallback for everything else. Developers can override the URL or access logic per
button, or register a custom plugin for an entity with a non‑standard add route.
The module has no settings page of its own — every button is configured inside the
View where you place it. It depends on core **Views** and the
[Token](https://www.drupal.org/project/token) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (and Token) and enable it.

## How to use it

There is no global configuration — you add and configure the button inside a
View at **Structure → Views** (`/admin/structure/views`):

1. Edit a View and either add **"Global: Entity Add Button"** to the **Header**
   or **Footer** (the area version), or add the **"Entity Add Button"** **field**
   (the per‑row version).
2. In the handler settings, choose the **Entity Type** (and bundle) the button
   should create — for example *Content: Article*.
3. Set the **Button Text** (e.g. "Add article") and, to make it look like a
   button, add **Button Classes** such as `button` or `btn btn-primary`.
4. Optionally set a **Query String** to pre‑fill fields on the add form, turn on
   **destination** so users return to the View after saving, add an **Entity
   Context** value (such as a Group id), or enable **tokenize** to pull values
   from the first result row / contextual filters.
5. Save the View.

The button appears only for users who have permission to create the chosen
entity/bundle. You can add several buttons to one View, each targeting a
different entity type. Developers who need to support an entity with an unusual
add route can write a `@ViewsAddButton` plugin — see the
[`agent/`](../agent/start.md) docs.
