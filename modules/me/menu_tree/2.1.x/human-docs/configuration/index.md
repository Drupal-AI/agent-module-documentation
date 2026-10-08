# Configuration

Menu tree has no central settings form. Instead, you enable the tree widget
**per content type**, on the content type's own settings page. This lets you use
the tree only where it helps — typically content types whose pages live in a large
or deep menu.

## Switch the tree widget on for a content type

1. Log in as an administrator (a user who can administer content types).
2. Go to **Structure → Content types** (`/admin/structure/types`) and click
   **Manage** / **Edit** for the content type you want — for example the Basic page
   type at `/admin/structure/types/manage/page`.
3. On the content type settings form, open the **Menu settings** vertical tab.
4. At the bottom of that tab, tick **Use tree widget for parent link**.
5. Click **Save content type**.

## What changes

From then on, when someone adds or edits a node of that type, the **Menu settings**
section of the node form shows the browsable tree instead of the core flat
dropdown. Editors can expand and collapse branches to find the right place, and —
in this 2.x version — **drag and drop** the menu link to reposition it within any
menu available to that node.

Repeat the steps above for each content type that should use the tree. Content
types you leave unchecked keep Drupal's standard parent‑link dropdown.

## Turning it off

Because this is only a widget substitution, you can uncheck the box at any time to
return that content type to the core dropdown, with no effect on stored menu links.
