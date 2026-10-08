# Node Export — manual setup guide

**Node Export** (`node_export`) exports Drupal content nodes to JSON files and
imports that JSON back — either on the same site or into another Drupal
installation. It's a straightforward way to move or copy content between
environments: export a handful of curated articles from a staging site, hand the
file to production, and import it there; or seed a fresh development site with
real content pulled from somewhere else.

You can export in several ways: a single node from its own **Export** tab, every
node of a chosen content type, a specific set of nodes by their IDs, or a batch of
nodes selected on the content admin listing using the bundled **Node Export**
action. Importing is equally flexible — paste JSON into a form, or upload a JSON
file. There are also Drush commands so you can script exports and imports as part
of a repeatable content‑deployment routine.

One setting shapes how imports behave when a node already exists on the
destination: you can create a **new revision** of the existing node (the
default), always create a **brand‑new** node, or **skip** existing nodes
entirely. Because Node Export rebuilds each node from its field data, the
destination must already have the same content types (and ideally the same
fields); IDs like UUID and the node ID are dropped, so "already exists" decisions
key on the node ID. JSON is currently the only supported format. Three
permissions let you control who may export, who may import, and who may change
the settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the import‑conflict setting, the
   export/import pages, and the three permissions.

## Where it lives in the admin menu

- **Settings:** **Configuration → Content authoring → Node Export**
  (`/admin/config/content/node_export`).
- **Export by content type:** `/admin/content/export/contenttype`.
- **Export by node IDs:** `/admin/content/export/nids`.
- **Import pasted JSON:** `/admin/content/import`.
- **Import a JSON file:** `/admin/content/import/file`.
- **Per‑node export:** the **Export** tab on any node (`/node/{id}/export`).

## How to use it

1. Enable the module and grant the relevant permissions (see
   [Installation](installation/index.md) and
   [Configuration](configuration/index.md)).
2. On the source site, export your content — for example, go to
   `/admin/content/export/contenttype`, pick a content type, and download the
   JSON; or use the **Node Export** action on the `/admin/content` listing to
   bulk‑export selected rows.
3. Make sure the destination site has matching content types and fields.
4. On the destination, import the JSON via `/admin/content/import` (paste) or
   `/admin/content/import/file` (upload), and the nodes are recreated according
   to your import‑conflict setting.

For scripted workflows, use the Drush commands instead:

```bash
drush node-export-export all             # print JSON for all nodes
drush ne-export 12,15 --save=y           # write nodes 12 and 15 to a file
drush node-export-import /tmp/nodes.json # import nodes from a file
```
