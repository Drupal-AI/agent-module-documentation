<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Lock — configuration

## Where locks are set
Open **Layout Builder** on the entity's *default* layout (e.g. *Manage display → Layout*). Configuring a section (the section's settings) exposes the lock options for that section. Setting locks requires the **`manage lock settings on default display`** permission (or `manage lock settings on overrides` for override layouts).

## Lockable operations (per section)
Each section can independently lock:
- **Add block** — editors cannot add new blocks to the section.
- **Update/move block** — editors cannot reconfigure or reorder blocks.
- **Delete block** — editors cannot remove blocks.
- **Add section before / after** — editors cannot insert new sections adjacent to this one.

## Permissions
| Permission | Grants |
|---|---|
| `manage lock settings on default display` | Set locks on default layouts |
| `manage lock settings on overrides` | Set locks on override layouts |
| `bypass lock settings on layout overrides` | Edit locked sections on overrides anyway |
| `remove sections with lock settings` | Remove a section that carries lock settings |

## Enforcement caveat
Locks constrain the Layout Builder UI for editors who **already have** override/layout access. They are editorial guard-rails, not a hard security boundary: anyone with the bypass permission (or broader layout access) is unaffected. Grant `bypass lock settings on layout overrides` only to trusted roles.