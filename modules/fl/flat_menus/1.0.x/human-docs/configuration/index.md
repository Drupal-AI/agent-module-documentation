# Configuration

Flat Menus is configured **per menu** rather than from a central settings page.
Once the permission is granted, you turn flatness on for each menu that needs it.

## 1. Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant the **Enable flat
menu option** permission to the role that manages menus. Only users with this
permission see the flat‑menu checkbox on menu edit forms.

## 2. Mark a menu as flat

1. Go to **Structure → Menus** (`/admin/structure/menu`).
2. Edit the menu you want to keep flat (its **Edit menu** form).
3. Tick the **Flat menu** checkbox.
4. Save the menu.

## What happens when a menu is flat

Once a menu is marked flat, Flat Menus enforces the single‑level structure in
several ways:

- **Parent fields are hidden.** In the add/edit forms for links in that menu, the
  parent‑selection field is removed, so editors can't nest a link under another.
- **Nested items are flattened on save.** If a link somehow has a parent, saving
  it moves it back up to the top level automatically.
- **Drag indentation is disabled.** On the menu administration screen, the
  drag‑and‑drop indentation that would create nesting is turned off.
- **Editors get clear feedback** about the flat‑menu restriction, so the behaviour
  isn't a surprise.

## Turning it off

To let a menu be hierarchical again, edit the menu, untick **Flat menu**, and
save. Note that flattening happens as links are saved, so un‑flattening simply
allows nesting going forward — it doesn't restore any hierarchy that was
previously removed.
