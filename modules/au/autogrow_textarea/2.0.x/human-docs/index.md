# Autogrow Textarea — manual setup guide

**Autogrow Textarea** (`autogrow_textarea`) is a small front‑end usability
enhancement: it automatically resizes textarea fields to fit their content as the
user types, so an editor never has to scroll inside a cramped little box. As text
grows the field grows with it, and as text is removed it shrinks back down.

It applies to textareas in forms across the site and is a pure convenience feature —
it plays no part in content modeling or access control. There is nothing to
configure; enable it and it works. It supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — what happens once it's on.

## Where it lives in the admin menu

Nothing. The module adds no admin menu item and no settings form — the behavior is
automatic once enabled.

## How to use it

Just enable it. Textareas across the site's forms will then grow and shrink to fit
their content as you type. There is no per‑field setup and no configuration to
maintain.
