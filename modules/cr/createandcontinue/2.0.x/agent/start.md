<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create and Continue (createandcontinue) — agent index

Adds a **"Save and add another"** button to the node **add** form. It saves the node like the normal
Save button, then redirects back to a fresh empty add form of the same content type instead of to
the created node. A one-file utility for bulk content entry.

- **Version:** 2.0.x · **Core:** `^10 || ^11` · **License:** GPL-2.0-or-later
- **Dependencies:** none (core only). No config, no permissions, no routes, no services, no plugins,
  no config schema, no submodules, no Drush commands, no libraries.
- **Structure:** a single procedural file `createandcontinue.module` (~45 lines) — two functions.

## What it provides

- `createandcontinue_form_node_form_alter()` — `hook_form_BASE_FORM_ID_alter()` for `node_form`;
  guards on the path containing `/node/add/` and clones the Save button into a
  "Save and add another" action.
- `createandcontinue_submit()` — appended submit handler; when its button is the trigger, redirects
  to the resolved `/node/add/<type>` path via `Url::fromUserInput()`.

## Solution docs

- [Form alter & submit reference](api/form-alter.md) — install, the hook, the submit callback, the
  add-form-only guard, and the redirect source.
