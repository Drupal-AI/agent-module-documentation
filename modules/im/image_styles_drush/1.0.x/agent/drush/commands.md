<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Styles Drush commands

Registered via `drush.services.yml` → `ImageCommands` (uses `ImageService` + core Image effect manager / image_style storage).

| Command | Alias | Purpose |
|---|---|---|
| `image-styles:list` | `isl` | Display all image styles |
| `image-styles:create` | `isc` | Create an image style |
| `image-styles:delete` | `isd` | Delete an image style |
| `image-styles:add-effect` | `isae` | Add an effect to a style |
| `image-styles:delete-effect` | `isde` | Delete an effect from a style |
| `image-styles:effects` | `ise` | List available image effects |
| `image-styles:params` | `isp` | Show an effect's parameters as JSON |

## Usage notes
- Run `drush <command> --help` for arguments.
- `isp` prints an effect's parameter schema (optionally pretty JSON) so you know what to pass to `isae`.
- Effect parameter values are passed as JSON and are **not validated** — always use web-style hex colors (`#RRGGBB`) and correct numeric types, or you can break image rendering.
- Works interactively or scripted; ideal for reproducing complex styles across environments in deploy/CI scripts.
- CLI-only: no web routes or permissions are added by this module.
