# Region in Content — manual setup guide

**Region in Content** (`regionincontent`) lets you render a theme's **block
regions inside a node's content template**, rather than only in the page template.
Normally, blocks placed in a region (a sidebar, a secondary menu, a call-to-action
zone) appear where the *page* template puts that region. This module makes chosen
regions available as variables **inside the node**, so a node template can print
them in among the node's own fields.

The typical example is printing a secondary-menu region mixed in with the fields of
a full node, but any region works. Under the hood the module reads a list of region
machine names you configure, intersects them with the regions your active theme
actually declares, renders those regions (that is, the blocks placed in them), and
exposes them as variables on the node — for the **full** view mode.

Importantly, the blocks rendered this way **keep their own visibility and access
rules**. Region in Content only decides which theme regions become available inside
the node render array; it doesn't override who can see a block. It has a single
admin-gated settings form and no public or mutating endpoints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — list the regions to expose, then
   print them in your node template.

## Where it lives in the admin menu

Region in Content adds a settings form under **Configuration → User interface →
Region in Content** (`/admin/config/user-interface/regionincontent`). It requires
the **Administer site configuration** permission.

## How to use it

Setup is two steps — a bit of configuration and a small theme edit:

1. Place the blocks you want to appear in-content into a region (for example the
   **Secondary menu** region) at **Structure → Block layout**.
2. List that region's machine name in the module's settings form (see
   [Configuration](configuration/index.md)).
3. In your theme's node template for the full view mode
   (`node--full.html.twig`), print the new variable where you want it — for
   example:

   ```twig
   {% if secondary_menu|render %}
     {{ secondary_menu }}
   {% endif %}
   ```

The variable name matches the region's machine name. This is a handy, Layout
Builder-free way to weave block content into the body of your nodes.
