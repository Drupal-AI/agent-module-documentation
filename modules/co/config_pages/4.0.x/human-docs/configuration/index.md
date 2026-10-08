# Configuration

Config Pages needs a little setup before it does anything: you create a **config
page type**, give it fields, decide where it lives in the menu, and (optionally)
turn on context so values can vary by language or domain. This page walks through
that flow.

## Open the Config pages library

1. Log in as a user with permission to administer config page types.
2. Go to **Structure → Config pages** (`/admin/structure/config_pages`).

This library lists your config page types and lets you jump in to edit each
page's stored values.

## Step 1 — Create a config page type

Click **Add config page** (route `config_pages.type_add`, path
`/admin/structure/config_pages/types/add`) and fill in the type definition:

- **Label** — a human-readable name (for example "Homepage settings" or "Footer
  content"). A machine name is derived from it.
- **Menu path / weight / description** — optional. Set a **path** to mount the
  editing page somewhere friendly, such as
  `/admin/config/site-information/homepage-settings`, instead of the default
  location under the Config pages library. Weight and description control its
  placement and help text in the menu.
- **Context** — choose which context plugins are active for this type (see
  Step 4). Leave it off if the same values should apply everywhere.
- **Token** — a checkbox that, when enabled, exposes this type's field values as
  `[config_page:*]` tokens for use elsewhere on the site.
- **Show warning** — optionally warn editors that the values they are editing are
  context-specific.

Save the type. Config page *types* are configuration, so they export and deploy
between environments with `drush config:export` / `import`.

## Step 2 — Add fields

A config page type is a bundle, so you add fields to it exactly as you would to a
content type, using **Field UI** on the type's edit form (**Structure → Config
pages → Types → Manage**, route `entity.config_pages_type.edit_form`). Add any
field types and widgets you need — plain text and formatted text, images and file
uploads, links, entity references (including multi-value, drag-and-drop ordered
lists), and so on.

If you plan to render the page or place it as a block, use **Manage display** to
configure its view modes and field display just like any other entity.

## Step 3 — Edit the page's values

Back in the library (or at the type's custom menu path if you set one), open the
page itself and fill in the fields. This is the single stored **singleton** for
that type — there is only one to edit, which is exactly the point. These stored
values are content, not configuration, so they are **not** exported with
`drush config:export`.

The editing page also offers a **Clear values** (purge) action to reset the page,
gated by its own permission.

## Step 4 — Context (per-language / per-domain / custom)

If different contexts should have different values, enable a context plugin on the
type. When a context is active, Config Pages stores a **separate page per context
value**:

- **Language context** ships in the box. Turn it on to keep distinct settings per
  content language, with an optional **fallback language** used when a given
  language has nothing saved.
- **Domain or custom contexts** require an additional context plugin (a
  Domain-based context, or one you write against the `config_pages_context`
  plugin type).

You can set per-context **fallback values** on the type, and Config Pages lets you
**import/copy** values from one context to another for the same type. When no
exact context match exists, the module falls back to the fallback context and then
to an empty-context page.

## Permissions

Config Pages provides both global and per-type permissions, so you can let a
particular editor change only certain config pages. Set these at **People →
Permissions**. Typical ones include administering config page types, accessing the
overview, and editing / clearing values for a given type.
