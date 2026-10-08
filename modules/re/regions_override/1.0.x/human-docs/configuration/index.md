# Configuration

Regions Override has no single settings page — you configure it in a few places, in
this order. The basic setup is: grant permissions, tell each theme which regions
are header/sidebar/footer, set content-type defaults, then let editors override
individual pages.

## 1. Set permissions

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant the Regions Override permission to the roles that should be allowed to
   override how regions display on a page.
3. Save.

Only users with the permission see the override options.

## 2. Map each theme's regions to header / sidebar / footer

The four editor choices ("No sidebars", "Remove body regions", etc.) work
generically by grouping every theme's regions into three buckets.

1. Go to **Appearance → Settings** and edit the settings of each theme you use
   (your front-end theme, and the admin theme if relevant).
2. Assign each of the theme's regions to one of the generic sections — **header**,
   **sidebar**, or **footer** — so the module knows what to hide for each choice.
3. Save each theme's settings.

Two safeguards are built in and cannot be turned off: the **Content** region is
always displayed, and the **Primary Tabs** block (View / Edit / Delete) is never
removed, so editors never lose the ability to edit a page.

## 3. Set a default per content type

1. Go to **Structure → Content types → *(type)* → Edit**.
2. Choose a default region override for that content type — for example "No
   sidebars" for a landing-page type.
3. Save.

Content-type defaults are stored in configuration (as third-party settings), so
they can be exported and deployed like any other config. Every node of that type
uses the default unless it chooses its own override.

## 4. Override individual pages

- **Per node:** the node edit form gains a field to pick this node's override,
  overriding the content-type default. If you don't want editors changing it per
  node for a given type, you can remove that field on the content type's **Manage
  form display** page.
- **On the fly:** an admin-toolbar shortcut link is available per page so an
  authorized user can override that page's regions directly.
- **Views pages** also offer the same four display choices.

Per-node and per-view overrides are stored as **content**, not config, so they are
not part of configuration management.

## What it does and doesn't do

Hiding a region only stops it **rendering on that page** — this is a display/layout
feature. The blocks inside a hidden region keep their own visibility and access
rules unchanged, so this is **not** a way to enforce access control; it's a way to
clean up a page's layout. The module also offers page theme-suggestion hooks per
override type if you want to template overridden pages differently.
