# Configuration

Custom Permissions is all about one screen: the page where you define your own
named permissions. This page explains how that page works and, just as
importantly, how the permissions you create fit into Drupal's access model.

## Who can manage custom permissions

Managing custom permissions is gated by the module's own
**`administer custom_permissions`** permission. This is a powerful capability —
anyone who holds it can create the permission strings your site relies on — so
grant it only to full administrators. As with any permission, you assign it on
Drupal's core **People → Permissions** page.

## Define a custom permission

1. Log in as a user who has **`administer custom_permissions`**.
2. Go to **People → Custom Permissions** (`/admin/people/custom-permissions`).
3. Add a permission entry — give it a name — and save. The module stores these
   definitions as configuration, so they can be exported and deployed with the
   rest of your site's config.

Each permission you define here is registered into Drupal's permission system
exactly like a permission declared in code.

## Assign the permission to a role (the important second step)

Defining a permission does **not** give it to anyone. Custom Permissions only
*declares* the permission — it never grants it. To actually put a custom
permission to work:

1. Go to Drupal's core **People → Permissions** page
   (`/admin/people/permissions`).
2. Find your newly defined permission in the list.
3. Tick the roles that should have it, and save.

From there the permission behaves like any other: you can reference it in **Views**
access settings, block visibility, or other modules that let you pick a permission.

## In short

- **Custom Permissions** creates the named permission (the "switch").
- **Core's Permissions page** decides which roles get it (who can flip it).
- Everything else in Drupal that reads permissions can then use your custom one.
