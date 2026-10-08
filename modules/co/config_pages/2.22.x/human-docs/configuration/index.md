# Configuration

Config Pages has two layers: the **type** (a configuration entity that defines the
fields — the "bundle") and the **page** itself (a content entity holding the actual
values — one per type, per context). Everything is managed under **Structure →
Config pages** (`/admin/structure/config_pages`).

## Create a config page type

1. Go to **Structure → Config pages** and click **Add config page** (types are
   listed under the **Types** tab). Creating a type requires the **Administer
   config_pages types** permission.
2. Give the type a **Label** and machine name.
3. Optionally set a **menu path**, **weight**, and **description** to mount the page
   at a friendly admin location (for example `admin/config/mysettings`) so clients
   can find it.
4. Choose which **context** plugins are active (see below).
5. Toggle **Token** exposure if you want the type's field values available as
   `[config_page:…]` tokens.

## Add fields

Because a type is a bundle of the `config_pages` entity, you add fields to it with
**Field UI** on the type's edit form — text, images, links, entity references,
multi‑value drag‑and‑drop lists, and so on, exactly as you would on a content type.
If the page will be rendered or placed as a block, arrange its output on the
**Manage display** tab.

## Edit the page

Once the type has fields, open the actual page (from the Config pages library or
its custom menu path) and fill in the values. There is just one stored page per
type per context — that "singleton" nature is the whole point.

Two extra actions are available on a page, each gated by its own permission:

- **Clear values** — purge the page's values to reset it.
- **Import values** — copy values from another context into this page.

## Context — per‑language, per‑domain, or custom

Context lets one settings page hold different values in different situations. When
you enable a context on a type, the module stores a **separate page per context
value**:

- **Language context** *(ships in the box)* — enable it to keep distinct settings
  per content language, with an optional fallback language used when a language has
  nothing saved.
- **Custom contexts** — per‑domain, per‑role, per‑section, and so on, are possible
  by adding a `config_pages_context` plugin (a developer task).

A type's context settings include which context plugins are active, per‑context
**fallback** values, and a **show warning** toggle that reminds editors the values
are context‑specific.

## Permissions

Config Pages provides both global and per‑type permissions, so you can let editors
change settings without giving them the power to alter the field structure:

| Permission | What it allows |
|-----------|----------------|
| **Administer config_pages types** | Create, edit, and delete config page types and their fields. Reserve this for developers. |
| **Access config_pages overview** | View the config pages library/overview page. |
| **View config_pages entity** | View all config pages. |
| **Edit config_pages entity** | Edit all config pages. |
| **Delete config_pages entity** | Delete config pages. |
| **Access config_pages clear values option** | Use the clear/purge action. |
| **Context import config_pages entity** | Import values from another context. |
| **View *(type)* config page entity** | View one specific type's page (generated per type). |
| **Edit *(type)* config page entity** | Edit one specific type's page (generated per type). |

Use the per‑type **Edit *(type)* config page entity** permissions to let an editor
manage only certain pages while **Administer config_pages types** stays reserved
for developers.

## Configuration vs. content

Config page **types** (and their fields) are configuration — export and deploy them
with `drush config:export` like anything else. The stored **values** are content,
not configuration, so they are not exported.
