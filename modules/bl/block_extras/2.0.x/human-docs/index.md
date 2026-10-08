# Block Extras — manual setup guide

**Block Extras** (`block_extras`) adds assorted extra functionality to Drupal
blocks — additional configuration options and display features that give site
builders a little more control over how blocks are set up and rendered than core
provides on its own.

It is a general block/site-building enhancement rather than a single-purpose
tool: enabling it makes its extra options available on the block system. It has
no content model or access-control role of its own, requires no other contrib
modules, and supports Drupal 10.1 and 11.

Because this is a small, broadly-scoped enhancer, the most reliable description
of exactly which extra options it adds is the module's own project page and
in-code configuration. Enable it on a test environment first and review the new
options that appear on the block forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. Its extra options surface within the block
system at **Structure → Block layout** (`/admin/structure/block`) when you place
or configure a block.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and configure a block. Review the extra
   options Block Extras adds to the block's configuration form.
3. Set the options you want and save the block.

There is no central settings page — the additions apply per block, alongside
core's own block configuration.
