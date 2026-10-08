# Configuration

There is no settings form — configuring Layout library means three things: **build
reusable layouts**, **enable the library on a bundle**, and then let **authors pick
a layout** on the content form.

## 1. Create reusable layouts

1. Go to **Structure → Layout library** (`/admin/structure/layouts`). Managing the
   library requires the **Configure any layout** permission (see below).
2. Click **Add layout** and fill in:
   - a **Label** (the name authors will see in the dropdown),
   - a machine **id**,
   - an **Entity Type** — a dropdown of every content entity type and bundle in the
     form `entity_type:bundle`. This scopes the layout to that type/bundle.
3. Save. You are taken straight into the normal **Layout Builder** interface for
   this library layout, where you arrange sections and place blocks/fields.
4. When you are happy, save the layout. Repeat to build up a set of templates.

Library layouts are configuration entities, so they export and deploy between
environments with `drush config:export` / `config:import`.

## 2. Enable the library on a bundle

For authors to see your layouts, you have to switch the library on for the specific
bundle and view mode:

1. Go to the bundle's **Manage display** for a view mode where **Layout Builder is
   already enabled** — for example **Structure → Content types → *Page* → Manage
   display**.
2. Tick **"Allow content editors to use stored layouts"** and save.

When you save that, the module automatically:

- creates a locked **"Layout"** reference field (`layout_selection`) if it doesn't
  exist yet,
- adds it to the bundle, filtered to only show library layouts matching this
  type/bundle,
- and adds it to the bundle's **default form display** (using a select widget, or an
  autocomplete widget if the core Options module isn't available).

Unticking the checkbox later removes that field from the bundle again (once no other
view mode of the same bundle still has the library enabled).

## 3. Authors pick a saved layout

On the content add/edit form, the author now sees a **"Layout"** dropdown listing
only the library layouts that match the item's type and bundle. When they choose one
— and the page's own layout hasn't been customised yet — the selected layout's
sections are **copied onto the page as a starting point**, which the author can then
further tweak with Layout Builder overrides.

## Permissions

Layout library ships no permissions file of its own; access uses two existing
permissions:

| Permission | Who needs it | Covers |
|---|---|---|
| **Configure any layout** | Trusted layout authors / site builders | Managing the library — the list, add, and delete screens at Structure → Layout library. |
| **Administer *{entity type}* display** | Site builders | Editing a library layout in Layout Builder, and the Manage‑display checkbox that turns the library on for a bundle. |

Content **authors** who merely pick a layout from the dropdown need only their
normal create/edit access to the content, plus the ability to use Layout Builder
overrides on that bundle — they do **not** need *Configure any layout*. Grant
*Configure any layout* only to the people you trust to design templates.
