# Static Content Iframe — manual setup guide

**Static Content Iframe** (`sci`) lets you host a self-contained static site —
plain HTML, CSS and JavaScript — inside your Drupal pages. You package the static
content as a `.zip` (with an `index.html` as its entry point), upload it, and SCI
stores it as a **Static content** entity and renders it inside an iframe. It is
handy for wrapping an inherited single-page app in your site's branding, embedding
an Adobe Captivate HTML5 export, or showing a self-contained report or interactive
build without standing up a separate server.

Behind the scenes SCI defines a `static_content` content entity. When you upload
an archive, it is extracted into `public://static/<hash>/` (a hash-named directory
under your public files), SCI finds the `index.html` inside, records its location,
and serves it in an iframe with configurable width, height and an optional
"autoheight" that tries to resize the frame to fit its content after it loads. You
reference a Static content entity from your content using an entity-reference
field, displayed as a rendered entity.

**Grant permissions carefully.** The uploaded archive is extracted into the
*public* files directory and its `index.html`, with any JavaScript it contains, is
served from your site inside the iframe. Grant the create, edit and view
permissions **only to fully trusted roles** (they are custom permissions and are
not given to anonymous users by default). The module carries **no official
security-advisory coverage** and is marked minimally maintained.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.

## Where it lives in the admin menu

Static content entities are managed at **Structure → Static content**
(`/admin/structure/static_content`), where you can list, add, edit and delete
them.

## How to use it

1. Package your static content as a `.zip`, making sure the entry-point file is
   named `index.html`.
2. Go to **Structure → Static content** (`/admin/structure/static_content`) and
   add a new **Static content** entity, uploading your archive. SCI extracts it
   and detects the `index.html`.
3. On the content type where you want to show it, add an **entity reference**
   field of type *Static content* and set its display to render the referenced
   entity.
4. Reference your static content item from a node and it renders inside an iframe.

Helpful tips from the module's own docs: you can create a custom template per item
named `static-content--NAME.html.twig`, and if you do not know the content's
height in advance (and it is a single page), try the **Autoheight** setting, which
attempts to correct the iframe height after the content loads. The permissions
that control who may create, edit, view and administer these entities live under
**People → Permissions** — keep them restricted to trusted roles for the
reason described above.
