# Configuration

Theme Permission has no settings form. You "configure" it entirely by assigning
the per-theme permissions it generates, on Drupal's normal permissions page.

## The generated permissions

For **every installed theme**, the module creates:

- **Administer themes _theme_** — lets a role manage that theme. Holders see the
  theme on the Appearance page and can install it, set it as the default,
  configure its settings, and place blocks per theme.
- **Uninstall themes _theme_** — lets a role uninstall that theme. This is in
  addition to the administer permission above.

Plus one global permission:

- **Edit Administration theme** — controls whether a role sees the admin-theme
  selection form at the bottom of the Appearance page (the setting that chooses
  which theme is used on administration screens).

The theme part of the name is the theme's machine name, so on a site with Olivero
and Claro installed you will see "Administer themes olivero", "Uninstall themes
olivero", "Administer themes claro", "Uninstall themes claro", and "Edit
Administration theme". Installing a new theme automatically makes its pair of
permissions appear on the permissions page.

## Assign the permissions

1. Log in as a full administrator.
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the Theme Permission entries (search the page for a theme's name). Tick the
   boxes for the roles that should manage each theme.
4. Save permissions.

For example, to let a "Designer" role manage only Olivero: tick **Administer
themes olivero** (and optionally **Uninstall themes olivero**) for that role, and
leave every other theme's boxes unticked.

## What changes on the Appearance page

Once permissions are assigned, the module rewrites the **Appearance** page
(`/admin/appearance`) so that each user:

- only sees the themes they have **Administer themes _theme_** for;
- only gets the install, set-default, settings, and per-theme block operations for
  those themes;
- only sees the **Uninstall** operation for themes they also have **Uninstall
  themes _theme_** for;
- only sees the administration-theme selection form if they have **Edit
  Administration theme**.

## Relationship to core's permission

Core's own **Administer themes** permission still works and still grants full
control over every theme. Theme Permission simply adds a finer-grained alternative
on top, so you can keep a super-admin role on the core permission while giving
other roles scoped, per-theme access.
