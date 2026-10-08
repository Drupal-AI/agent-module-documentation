# Block ID — manual setup guide

**Block ID** (`block_id`) lets you set a custom HTML `id` and extra CSS classes
on any placed block — right from the block's own configuration form. Instead of
writing a preprocess hook or a Twig template override just to add a class or a
predictable anchor, you type the values into the block form and the module applies
them when the block renders.

It adds four optional fields to the standard block configuration form: a custom
**Block ID**, and three CSS-class fields targeting different parts of the block —
its **title**, its **content**, and the overall **block wrapper**. Typical uses
are giving a block a stable `id` for CSS or JavaScript to hook onto, creating an
in-page `#anchor`, or attaching design-system/utility classes without touching
templates.

The fields — and therefore the whole feature — are only shown to users who hold
the **"administer block id"** permission. On save, any blank fields are discarded
so the block config stays clean, and a custom Block ID is checked to be **unique**
across all blocks (duplicates are rejected). The module has no settings page, no
config schema, and no Drush; you use it entirely from each block's **Configure**
form. It requires core's **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.
2. [Configuration](configuration/index.md) — the four block-form fields, how they
   render, and the uniqueness rule.

## Where it lives in the admin menu

There is no central settings page. The fields appear on each block's own settings
form, reached from **Structure → Block layout**
(`/admin/structure/block`) → **Configure** on any block.

## How to use it

Enable the module, grant yourself the **"administer block id"** permission, then
open any block's **Configure** form. Scroll to the ID/CSS-class fields, fill in
what you need, and save — the values are applied to that block's markup the next
time it renders. See [Configuration](configuration/index.md) for exactly what each
field does.
