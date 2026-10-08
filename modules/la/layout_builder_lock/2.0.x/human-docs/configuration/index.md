# Configuration

Layout Builder Lock is configured in two places: you grant its **permissions** at
People → Permissions, and you set the **lock options** on individual sections
inside the Layout Builder UI. There is no separate settings form.

## Step 1 — Grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and assign these
permissions to the appropriate roles:

| Permission | What it grants |
|---|---|
| **Manage lock settings on default display** | Set locks on default layouts. |
| **Manage lock settings on overrides** | Set locks on override layouts. |
| **Bypass lock settings on layout overrides** | Edit locked sections on overrides anyway — grant only to trusted roles. |
| **Remove sections with lock settings** | Remove a section that carries lock settings. |

The core permission most administrators need is the ability to *manage* lock
settings; the **bypass** permission deliberately defeats the locks, so treat it as
a trusted‑roles‑only grant.

## Step 2 — Set locks on a section

1. Open **Layout Builder** on the entity's *default* layout (for example
   **Structure → Content types → *(type)* → Manage display → Layout**).
2. Click **Configure section** on the section you want to protect. The section's
   settings form exposes the lock options.
3. Toggle the operations you want to lock, then save.

## The lock options

Each section can independently lock the following operations for editors working on
overrides:

- **Update default blocks** — editors cannot reconfigure the default blocks.
- **Move default blocks** — editors cannot reorder the default blocks.
- **Delete default blocks** — editors cannot remove the default blocks.
- **Configure the section** — editors cannot change the section's own settings.
- **Add a section before / after** — editors cannot insert new sections adjacent to
  this one.
- **Move blocks from other sections into this section** — editors cannot drag blocks
  in from elsewhere. (Note: this restriction stops applying once editors add their
  own new blocks to the section.)

Editors can still **add new blocks**, which are placed below the default blocks and
remain fully editable, movable, and deletable by the editor. And as soon as *any*
lock option is enabled on a section, editors can no longer delete that section
either.

## Enforcement caveat

These locks constrain the Layout Builder UI for editors who **already have**
override/layout access — they are editorial guardrails, not a hard security
boundary. A user with **Bypass lock settings on layout overrides** (or with broader
layout access) is unaffected, so grant that permission sparingly and only to roles
you trust.
