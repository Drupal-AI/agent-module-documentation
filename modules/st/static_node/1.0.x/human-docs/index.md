# Static Node Generator — manual setup guide

**Static Node Generator** (`static_node`) speeds up a Drupal site by generating
and serving static HTML versions of individual nodes. Instead of statically
exporting your whole site, it lets you pick specific pages — a campaign landing
page, a hot article — and pre-render each one to a static HTML file that is served
directly, bypassing Drupal's usual bootstrap for anonymous visitors. That cuts
server load and makes those pages load very fast, while the rest of the site keeps
working dynamically.

It is built for a hybrid model: choose which node types support static
generation, generate a page (one at a time, in bulk, or from a button on the node
edit form), and anonymous users are automatically redirected to the static copy
when one exists. Generated assets (CSS, JavaScript, images) are included
automatically, and relevant caches are cleared for you whenever a static page is
created or deleted. The module depends only on core's Node and File modules.

Unlike a full-site tool such as Tome, Static Node Generator focuses on individual
nodes and integrates directly with the Drupal admin UI — ideal when you want a few
selected pages served as fast static files without giving up the dynamic
capabilities of everything else. This version is **1.0.0-beta11**, and the module
is described as minimally maintained.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer command,
   and enabling the module.
2. [Configuration](configuration/index.md) — choosing node types, setting the
   static folder, permissions, and managing generated files.

## Where it lives in the admin menu

- **Settings:** `/admin/config/system/static-node` — pick which node types support
  static generation and set the destination folder.
- **Manage generated files:** `/admin/content/static-files` — an admin listing to
  view and delete the static files you have generated.
- **Permissions:** `/admin/people/permissions` — grant *generate static node* and
  *delete static node*.

## How to use it

Once a node type is enabled for static generation, you can generate a page in
three ways: click the **Generate Static Page** button on the node's edit form,
select nodes on the content listing (`/admin/content`) and use the bulk **generate
/ delete static content** actions, or drive generation from the command line with
Drush. When a static file exists for a node, anonymous visitors are redirected to
it automatically.
