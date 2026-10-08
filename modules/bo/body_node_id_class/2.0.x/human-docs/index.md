# Body node ID Class — manual setup guide

**Body node ID Class** (`body_node_id_class`) does one small, useful thing: it adds a
`page-node-<nid>` and a `page-node-type-<bundle>` CSS class to the `<body>` tag on
node pages. That means you can style one specific node, or every node of a given
content type, from your theme's stylesheet without writing any PHP or template
overrides.

If you built sites on Drupal 7, this will feel familiar — core used to add a unique
per‑node body class automatically, and that behavior went away in Drupal 8. This
module forward‑ports it so the same simple CSS targeting works again on Drupal 8
through 11.

There is nothing to configure. The module is a single preprocess hook: on a canonical
node page it looks at the node in the route and appends the classes to the body tag.
On a full node object it adds both `page-node-<nid>` (the node ID) and
`page-node-type-<bundle>` (the content type machine name); if only a bare node ID is
available it adds just `page-node-<nid>`. It does nothing on non‑node routes (views
pages, admin pages, taxonomy pages), and it has no settings form, permissions,
services, or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   clear caches.

## Where it lives in the admin menu

Nowhere — there is no settings page. Once enabled, the body classes are added
automatically on node pages.

## How to use it

1. Enable the module and clear caches.
2. Load any node page and view its source: the `<body>` tag now carries classes like
   `page-node-42` and `page-node-type-article`.
3. Target them from your theme's CSS:

   ```css
   .page-node-42 { /* style one specific node */ }
   .page-node-type-landing_page { /* style every node of a content type */ }
   ```

   You can also read `document.body.classList` in JavaScript to detect the current
   node type client‑side — handy for scoping a behavior or analytics tag. Common uses
   include a full‑bleed hero only on landing pages, hiding a global element on one
   campaign node, or per‑type typography tweaks — all from pure CSS.
