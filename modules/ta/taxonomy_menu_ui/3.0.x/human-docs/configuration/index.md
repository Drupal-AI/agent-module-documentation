# Configuration

There's no central settings page. You configure this in two places: once **per
vocabulary** (which menus its terms may use), and then **per term** (create the actual
link). This page covers both.

## Part 1 — Allow menus on a vocabulary

1. Go to **Structure → Taxonomy**, and **Edit** the vocabulary
   (`/admin/structure/taxonomy/manage/<vocabulary>`).
2. Open the **Menu settings** tab in the vertical tabs at the bottom of the form.
3. Under **Available menus**, tick the menu(s) that terms of this vocabulary may be
   placed in — for example *Main navigation*, *Footer*, or a dedicated "Product
   categories" menu. Ticking only one menu is how you restrict a vocabulary to a
   single navigation area.
4. Choose a **Default parent item** — the place new term links nest under by default.
   This can be a menu's root or an existing menu link. Setting a parent is handy when
   you want all of a vocabulary's terms to sit under one navigation section.
5. Save.

A couple of things to know:

- **The default is the Main menu.** If you never touch these settings, a vocabulary's
  terms can be placed in the Main navigation menu. Configure the tab to change or
  restrict that.
- **The parent must belong to a ticked menu.** If you pick a default parent that isn't
  under one of the menus you ticked, the form shows an error asking you to fix it.
- **To turn the feature off for a vocabulary,** untick every menu under Available
  menus. The Menu settings section then simply won't appear on that vocabulary's term
  forms.

### Placement on the term form (optional)

The "Menu settings" section is a form element you can reposition. On the vocabulary's
**Manage form display** (`taxonomy_term` display), you'll find a **Menu settings**
row you can drag to reorder, or move to *Disabled* to hide it.

## Part 2 — Add a menu link to a term

Once a vocabulary allows a menu, editors get the menu option on each of its terms:

1. Add or edit a term of that vocabulary.
2. Open the **Menu settings** section.
3. Tick **Provide a menu link**.
4. Fill in:
   - **Menu link title** — the text shown in the menu. This can differ from the term
     name (for example a shorter label for navigation).
   - **Description** — optional hover text for the link.
   - **Parent item** — where this link sits in the menu tree (limited to the
     vocabulary's allowed menus, starting from the default parent).
   - **Weight** — the ordering relative to its sibling links.
5. Save the term.

The module creates a real menu link pointing at that term. To **remove** a term from
the menu later, edit it, untick **Provide a menu link**, and save — the link is
deleted.

### Who can do this

The Menu settings section on the term form is only shown to users who can manage
menus:

- Users with core's **Administer menus** permission, or
- If the [Menu Admin per Menu](https://www.drupal.org/project/menu_admin_per_menu)
  module is installed, users who administer one of the vocabulary's available menus.

Everyone else simply doesn't see the section — a convenient way to keep menu placement
in the right hands. Grant "Administer menus" under **People → Permissions**.

## Tokens

The module registers a chained token so you can reference a term's menu link in
templates, patterns, or mail:

```
[term:menu-link:title]
[term:menu-link:url]
```

These resolve in the context of a term that has a menu link enabled.
