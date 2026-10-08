# Boostrap Layout Classes — manual setup guide

**Boostrap Layout Classes** (`boostrap_layout_classes`) is a small Fields module
that lets editors attach Bootstrap layout CSS classes — columns, spacing,
ordering, and so on — to a field value through a dedicated widget, and renders
those classes back out through a matching field formatter. In other words,
per‑entity, editor‑controlled layout tweaks are stored as data on a field rather
than hard‑coded in Twig templates.

> **Note the misspelled name.** Both the project and machine name are
> `boostrap_layout_classes` — "Boostrap" is missing the second **t**. That is not
> a typo in this guide; it is the module's actual name, so the Composer package
> and `drush en` command use that spelling too.

It is best on a site built with a Bootstrap‑style front‑end theme, where you want
content teams to have controlled layout options (a fixed vocabulary of classes)
instead of a free‑text class field that invites typos. It depends only on core's
**Field** module, declares no routes or permissions, and has no admin settings
page. It targets Drupal 8/9 (its Composer constraint allows up to ^10).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. You configure it per field at **Structure →
Content types → (a type)**: the widget on the **Manage form display** tab and the
formatter on the **Manage display** tab (`/admin/structure/types`).

## How to use it

1. Add a field to a content type (any fieldable entity type works).
2. On the **Manage form display** tab, choose the **Boostrap Layout Classes**
   widget for that field. The widget lets editors pick the Bootstrap classes
   (grid columns, spacing/margins, ordering/offset utilities) to store on the
   field. The available class lists come from the module's shipped config/CSS
   assets.
3. On the **Manage display** tab, choose the matching **Boostrap Layout Classes**
   formatter. At render time it emits the selected classes as CSS classes.
4. Pair the site with a Bootstrap base theme so those classes produce the
   responsive columns and spacing you expect. You can reuse the same widget
   across multiple content types and combine it with view modes to vary layout
   per display.
