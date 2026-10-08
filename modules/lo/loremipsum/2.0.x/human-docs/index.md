# Lorem Ipsum — manual setup guide

**Lorem Ipsum** (`loremipsum`) is a simple filler‑text generator for Drupal. It
produces classic *lorem ipsum* placeholder text so you can fill out prototypes,
demos, and design mock‑ups with realistic‑looking body copy before the real
content exists. It's a developer / site‑builder convenience tool — you use it to
generate dummy text, and it has no effect on how your site behaves for real
visitors.

The module lets you generate placeholder text and (per the project) work with your
own custom sentences to create original‑looking lorem ipsum rather than the same
stock paragraph everyone recognises. It defines its own permission so you can
control which roles are allowed to generate placeholder text.

It's lightweight: no dependencies beyond core, and no external services. Being a
development aid, it's the sort of module you enable on a build or staging site and
typically leave off production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated configuration form** for this module. It works as a
generator; grant its permission to the roles that should be able to produce
placeholder text (see below).

## Where it lives in the admin menu

Lorem Ipsum adds no site‑wide settings page. Its access is controlled by the
permission it defines — review it at **People → Permissions**
(`/admin/people/permissions`) and grant it to the roles (typically developers or
site builders) who should be able to generate placeholder text.

## How to use it

1. Enable the module.
2. Grant the Lorem Ipsum permission to the roles that need it.
3. Use the generator to produce placeholder text while building out content types,
   layouts, and demos.
