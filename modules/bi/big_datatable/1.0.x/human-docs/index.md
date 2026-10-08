# Big Data Table — manual setup guide

**Big Data Table** (`big_datatable`) provides a "Big Data Table" configuration
entity for rendering large data sets as performant, feature-rich data tables. Where
a plain HTML table struggles with thousands of rows, this module gives you a
configurable, reusable table definition designed for big tabular data.

It is a content-display and site-building feature: you configure how a large data
table is presented, and the module defines its own permissions to control who may
manage those configurations. It has no access-control role of its own beyond that
permission.

One thing to keep in mind: the module controls *display*, not who is allowed to see
the underlying data. Make sure whatever you surface in a table is appropriate for
the audience that can view it — do not put restricted data into a table shown to a
wider audience than it should reach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Big Data Table works through a configuration entity, so its tables are created and
managed in the admin UI, and it defines its own permissions — set them under
**People → Permissions** (`/admin/people/permissions`) and grant them to the roles
that should manage data tables.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant the module's permission to the roles that should manage tables, under
   **People → Permissions**.
3. Create a Big Data Table configuration to define how a large data set should be
   rendered, then place or reference it where you want the table to appear. Always
   confirm the data shown respects the viewing audience's access.
