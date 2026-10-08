<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered in `drush.services.yml` → `ShorthandCommands` (args `@entity_type.manager`,
`@file_system`).

## `shorthand:clean-up` (alias `shcu`)

Deletes downloaded Shorthand story folders that are no longer referenced by any published story.

Behavior (`ShorthandCommands::run`):
1. Prompts for confirmation (`Are you sure you want to delete all not used shorthands?`).
2. Loads all `shorthand_story` nodes and reads each node's `field_shorthand` value
   (`<story-id>/<version>`) to build the set of in-use stories/versions.
3. Scans `public://shorthand/stories/`. For each story folder not in use, deletes the whole folder;
   for in-use stories, deletes any version subfolder other than the referenced one.

Note: the in-use scan is hardcoded to the `shorthand_story` node type and reads a
`field_shorthand` field. The `shorthand_example` submodule actually creates the field
**`field_shorthand_story`** (not `field_shorthand`), and custom setups may use other bundles/fields —
in those cases the command finds no in-use stories and would delete all downloaded folders. Verify
your field/bundle names before running `drush shorthand:clean-up`.
