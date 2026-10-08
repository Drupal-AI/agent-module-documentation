# JSON to content type builder — manual setup guide

**JSON to content type builder** (`json_to_content`) lets a site builder define a
content model as JSON and have Drupal generate the matching content type(s) and
fields — no clicking through the Field UI, and no hand-writing YAML. Paste or
upload a JSON structure, and the module creates the content type, sets up its
field storage and bundle configuration, and leaves you ready to add content.

It is aimed at prototyping, migrations, and empowering non-developers to sketch
content models quickly. Alongside building content types, it can also create
nodes from JSON data and export existing content back out to a JSON file. It
supports common field types out of the box — string, text, boolean, integer, and
entity reference (for example referencing users or taxonomy terms). It depends
only on Drupal core's **Field** and **Node** modules.

One caveat worth noting: this module is not covered by Drupal's security advisory
policy, so weigh that before using it on a production site. When you use
`entity_reference` field types, make sure the referenced entities (such as user
or taxonomy_term) already exist.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no single settings form for this module — you drive it entirely from
three purpose-built admin pages, described under "How to use it" below.

## Where it lives in the admin menu

The module adds three working pages rather than a settings page:

- **Build a content type from JSON** — `/admin/config/content/json-content-builder`
- **Create content from JSON data** — `/admin/content/json-content-create`
- **Export content to JSON** — `/admin/content/json-export`

Installing the [Admin Toolbar](https://www.drupal.org/project/admin_toolbar)
module makes these easier to reach from the menu.

## How to use it

1. Go to **`/admin/config/content/json-content-builder`** and paste or upload a
   JSON structure describing the content type and its fields. Submit the form and
   the module creates the content type, its fields, and all the underlying field
   storage and bundle configuration for you.
2. To populate content, visit **`/admin/content/json-content-create`** and paste
   the JSON data for the nodes you want to create. (When your JSON uses
   `entity_reference` fields, confirm the referenced users or taxonomy terms
   already exist first.)
3. To take content back out, use **`/admin/content/json-export`** to export
   existing content to a JSON file.

Each form carries its own on-screen instructions. The optional
[Field Group](https://www.drupal.org/project/field_group) module is handy for
organising the generated fields visually afterwards.
