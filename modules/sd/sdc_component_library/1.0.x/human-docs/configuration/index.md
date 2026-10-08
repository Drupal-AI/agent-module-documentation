# Configuration

SDC Component Library needs almost no configuration — once enabled it discovers your
theme's components automatically. There is a small settings form for controlling the
gallery, and one important permission to set.

## Grant the gallery permission

The component preview page is protected by a single, deliberately **restricted**
permission:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **`access sdc component library`**.
3. Grant it to the roles that should see the gallery — typically developers and
   designers only.
4. Click **Save permissions**.

Keep this restricted. A component gallery enumerates your site's front-end building
blocks and renders arbitrary components with sample props, which is exactly the kind
of reconnaissance (and occasional rendering surface) you would not want to leave open
to anonymous visitors.

## The settings form

1. Go to **Configuration → System → SDC Component Library**
   (`/admin/config/system/sdc-component-library`).
2. Use the form to control **which components appear** in the preview.
3. Save.

## Viewing components

Once the permission is granted, browse the gallery at `/sdc-component-library`.
Components are rendered through Drupal itself using the props defined in each
component's own schema, so the preview matches what the site actually outputs.
Components with a `.story.twig` file render with dummy data; if a WCAG checker is
available, accessibility validation is shown alongside the previews.
