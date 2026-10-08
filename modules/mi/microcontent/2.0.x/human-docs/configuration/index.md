# Configuration

Micro-content has no global settings page. "Configuring" it means two things:
creating **types** (bundles) and attaching **fields** to them — exactly the same
mental model as content types and nodes. This page walks through both, plus the
permission model and the optional integrations.

## 1. Create a micro-content type

1. Go to **Structure → Micro-content types** (`/admin/structure/microcontent-types`).
2. Click **Add micro-content type**.
3. Fill in:
   - **Name** — the human label (e.g. "Promo", "Callout", "Disclaimer").
   - **Description** — optional admin-facing note about what the type is for.
   - **Background class** (`type_class`) — an optional free-text CSS class that gets
     rendered onto the item's template (`microcontent.html.twig`). Use it to hook a
     utility/background class onto every item of this type.
   - **Create new revision** — whether saving an item of this type creates a new
     revision by default. Leave on if you want a revision history.
4. Save. You now have a type whose config object is `microcontent.type.<id>`.

## 2. Add fields to the type

With **Field UI** enabled, each type gets **Manage fields**, **Manage form display**
and **Manage display** tabs on its edit form (Field UI is attached because the type's
edit form is the field-UI base route). Add whatever fields the snippet needs — text,
media, links, entity references, and so on — just like on a content type.

## 3. Create items

Go to **Content → Micro-content** (`/admin/content/microcontent`) and click **Add
micro-content**. Choose the type, fill in the label and your fields, set the
published status, and save. Items are owned by whoever creates them (you can
reassign authorship), keep revisions, and can be translated.

## 4. Reference or render items

- Reference micro-content from a node or other entity using an **entity-reference**
  field pointing at the `microcontent` entity type.
- Render an item in a chosen view mode (a **Preview** view mode ships as optional
  config).
- If Entity Browser is installed, the shipped `microcontent` browser (and its
  browser View) lets editors pick items through a browser dialog.

## Permissions

Micro-content ships a rich permission set (**People → Permissions**). The two
trusted-admin permissions are:

- **Administer micro-content types** — add/edit/delete the *types*.
- **Administer micro-content** — full access to all *items* (this short-circuits all
  other item access checks, so grant it carefully).

Then there are content-scoped permissions:

- **View unpublished micro-content** — see unpublished items (also used for JSON:API
  filter access and the backfill integration).
- **Access micro-content overview** — see the admin listing at `/admin/content/microcontent`.
- Revision permissions — **view any / view history / revert any / delete any
  micro-content revisions**.

Finally, for **every type you create**, the module generates per-type permissions:
**create**, **update own**, **update any**, **delete own**, and **delete any**
`<type>` micro-content. This lets you, for example, allow a role to edit only its own
"Promo" items while giving another role edit-any rights on "Disclaimer" items.

In practice, view is allowed when the item is published (or the user has *view
unpublished*), and update/delete follow the per-type "own" vs "any" grants.

## Optional integrations

- **JSON:API** — micro-content is exposed with published/unpublished filter access
  respected, so decoupled front ends can read it.
- **Backfill Formatter** — install `drupal/backfill_formatter` to show a fallback
  value on an empty micro-content reference.

## Creating a type from the command line

```bash
ddev drush php:eval "\Drupal::entityTypeManager()->getStorage('microcontent_type')->create([
  'id' => 'promo', 'name' => 'Promo', 'new_revision' => TRUE, 'type_class' => 'is-promo',
])->save();"
```
