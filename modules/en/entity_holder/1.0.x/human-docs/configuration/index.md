# Configuration

Everything happens at **Structure → Entity holders**
(`/admin/structure/entity-holder`), which lists all holders and lets you add,
edit and delete them. You need the **Administer entity holders** permission to use
these screens.

## Create a holder

Click to add a new holder. A holder stores these values:

- **Administrative title** — an internal name to identify the holder in the list.
- **Path** — the persistent path/route the holder exposes (for example a home‑page
  or landing‑page path). This is what stays constant across environments.
- **Public title** — the title shown for the page, used as a fallback title when no
  content is held.
- **Held entity type** and **bundle** — the type of content this holder is allowed
  to hold (for example, node / a specific content type). Binding later is
  restricted to a matching type and bundle.
- **Fallback content** — a formatted‑text body shown on the holder's path when no
  content is bound yet. Because it is rendered through a text format, that format
  governs the markup it allows.

A holder can be created "empty" (with no content linked) or bound to an existing
entity from the start.

## Bind content to a holder

Once a holder exists you can attach content to it in two ways:

- **Create new content from the holder.** From the holder, use its
  *create‑entity* action (`/admin/structure/entity-holder/{holder}/create-entity/{uuid}`).
  This opens the held entity's normal create form, pre‑filled with the holder's
  title; when you save, the new entity is stored carrying that UUID. If the holder
  already holds content, this redirects to the existing entity's edit form.
- **Hold an existing entity.** Use the *hold‑entity* action
  (`/admin/structure/entity-holder/{holder}/hold-entity/{uuid}`) to load an entity
  by its UUID and bind it. Binding enforces that the entity's type and bundle match
  the holder's configured type and bundle.

## How rendering and access behave

- When a held entity exists, visiting the holder's path renders that entity in
  place — Entity Holder issues an internal sub‑request to the entity's canonical
  URL and returns its output, merging the entity's cache metadata into the
  response.
- When nothing is held, the holder shows the **fallback content**; if the current
  user is allowed to create the target content, it also offers a "create this
  content" link. If there is neither held content nor fallback, it returns a clean
  404.
- **View access** is denied for disabled holders. Otherwise it defers to the held
  entity's own access rules, or falls back to the core **Access content**
  permission when nothing is held. Disable a holder to forbid its view route
  entirely.

## The deployment pattern

This is the point of the module. Export your holders with **config sync** so the
path and route travel to every environment. Then author the matching content
*per environment* and bind it by the same UUID. Because the UUID is the shared
key, the holder's route resolves everywhere, even though each environment holds
its own copy of the content. Menu links and custom code can safely target the
holder's stable `entity_holder.view` route.
