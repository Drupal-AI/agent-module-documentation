# Configuration

Menu Perms per Menu has **no settings form**. You configure it entirely from the
standard permissions page by granting roles the per‑menu operations they should
have.

## Assign the permissions

1. Log in as a user who can administer permissions (an administrator by default).
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the permissions provided by this module — there are **six per menu**, and
   each one names the menu it applies to (for example the Main menu's add
   permission reads *"add new links to main menu from menu interface"*).
4. Tick the boxes for each role and menu operation you want to allow, then click
   **Save permissions**.

Because the permissions are generated from your live menus, the list grows and
shrinks automatically as you create or delete menus — a brand‑new menu gets its
own six permissions with no extra setup.

## The six operations (per menu)

For every menu, you can independently grant:

- **Add new links** — lets the role add a link and use "Add child" on that menu.
  Without it, the "Add link" button is hidden for that menu.
- **Delete links** — lets the role delete links in that menu (the Delete
  operation and the delete form). This is enforced by a real route access check.
- **Enable/disable links** — controls the *Enabled* checkbox on the link edit
  form and in the per‑menu overview.
- **Expand links** — controls the *Show as expanded* checkbox on the link edit
  form.
- **Edit link (URL)** — controls the *Link* (URL/target) field on the link edit
  form, so a role can, say, rename a link but not change where it points.
- **Translate links** — lets the role translate links in that menu (the Translate
  operation and translation routes). Also enforced by a real access check.

Mix and match these to build exactly the workflow you need. A few common recipes:

- **Reorder‑only editor:** grant nothing from the list above but rely on Menu
  Admin per Menu's access to the menu — the editor can drag links to reorder them
  but cannot add, delete, or retarget.
- **Draft/publish split:** give one role *Add new links* and another role
  *Enable/disable links*, so drafters create links and approvers turn them on.
- **Protected critical menu:** withhold *Delete links* from every role except
  super admins to prevent accidental removal of important navigation.

## Granting from Drush or code

The permission strings are the exact machine names (they embed the menu id). For
example, to grant "add and enable, but not delete" on the Main menu to the editor
role:

```php
// drush php:eval
use Drupal\user\Entity\Role;
$r = Role::load('editor');
$r->grantPermission('add new links to main menu from menu interface');
$r->grantPermission('enable/disable links in main menu');
$r->save();
```

## How the limits are applied

The *Edit link (URL)*, *Enable/disable*, and *Expand* limits are applied by
disabling the form fields. The *Add*, *Delete*, and *Translate* paths are
access‑checked on their routes.
