# Progressively Decoupled Blocks (PDB) — manual setup guide

**Progressively Decoupled Blocks** (`pdb`) lets front-end developers ship JavaScript
framework components — React, Vue, Ember, Web Components, or plain JS — as ordinary,
placeable Drupal blocks. That means you can drop an "island" of framework-driven UI into
an otherwise server-rendered Drupal page, and site builders can place it in Block layout
or Layout Builder just like any other block.

PDB works by scanning your codebase for **components**: directories that contain an info
file whose `type` is `pdb` (rather than `module` or `theme`). Each discovered component is
turned into a block automatically, with its declared JS/CSS loaded as asset libraries and
any per-instance settings exposed on the block form. Drupal context (such as the current
node or user) can be fed into the component, with entity fields access-checked one by one
before they reach the browser.

**PDB is a framework, not a finished feature.** On its own it ships no ready-made block.
To actually render components you also need a *presentation* module for your framework —
`pdb_react`, `pdb_vue`, `pdb_ember`, or `pdb_default` (each a separate project) — plus your
own component code. It has no admin settings page; you configure it through your component
info files, per-block forms, and (optionally) `settings.php`.

This guide is written for a **human** (here, mostly a developer) working through the setup.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install PDB with Composer, enable it, and add a
   presentation module.
2. [Configuration](configuration/index.md) — where components are discovered, how per-block
   component settings work, and how to feed Drupal context to a component.

## Where it lives in the admin menu

PDB has no configuration page of its own. Once components are discovered they appear as
blocks in **Structure → Block layout** and in Layout Builder, under the category each
component declares (or its provider name).
