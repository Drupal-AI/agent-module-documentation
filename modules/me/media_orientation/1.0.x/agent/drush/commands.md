<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `MediaOrientationCommands` (registered via `drush.services.yml`, service
`media_orientation.commands`).

| Command | Args | Alias | What it does |
|---|---|---|---|
| `mo:resave` | `<bundle>` (required media bundle machine name) | — | Loads **every** media of that bundle and calls `->save()` on each, re-triggering the presave hook so orientation is (re)computed and stored. |

- Method: `MediaOrientationCommands::migrate($bundle)`.
- The entity query uses `accessCheck(FALSE)` — it processes all media of the bundle regardless of access (normal for an admin CLI backfill).
- Passing an empty bundle prints `Error: required type.` and exits without changes.
- No batching/queue: it loads all matching media at once (`Media::loadMultiple`), so on very large bundles run it where memory allows.

Example — backfill orientation for existing `image` media:
```
drush mo:resave image
```
Prerequisite: the bundle must have orientation configured (an `image` source and a `list_integer`
field selected — see [../configure/orientation.md](../configure/orientation.md)); otherwise the
resave saves entities but writes no orientation value.
