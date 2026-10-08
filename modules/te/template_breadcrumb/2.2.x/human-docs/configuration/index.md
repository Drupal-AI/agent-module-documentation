# Configuration

Template breadcrumb has no central settings form. You configure it per view mode by
enabling the breadcrumb on an entity's display, then outputting it in the matching
Twig template. This is a two‑part job: one part in the admin UI, one part in your
theme.

## 1. Enable the breadcrumb on the display

1. Log in as an administrator and open the display settings for the content type
   (or other entity) — for example **Structure → Content types → *your type* →
   Manage display** (and pick the view mode you want, such as *Default* or *Full
   content*).
2. Enable the **Template breadcrumb** item so it is included in the rendered content,
   and position it where you like in the field order.
3. Save.

This makes the breadcrumb available in the template as `content.template_breadcrumb`.

## 2. Output it in your template

In your theme, in the template that renders that entity and view mode (for example a
node template), print the breadcrumb where you want it to appear:

```twig
{{ content.template_breadcrumb }}
```

Because it is part of the content render array, you control its exact placement in
the markup — inside the article body, above the title, within a layout region, and
so on.

## 3. Make sure a breadcrumb source is in place

The trail that gets rendered comes from your site's breadcrumb system. If it is
empty or wrong, confirm you have a working source: either the **Easy Breadcrumb**
module enabled, or the core breadcrumb patch referenced in the module's
documentation (drupal.org issue 2884217) if you use core breadcrumbs.

## 4. Clear the cache

After editing templates, clear Drupal's cache (for example `drush cr`) so your
theme changes take effect, then reload a content page to check the breadcrumb
appears in the right place.
