<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Patternkit — agent index

Adds **design-system patterns (JSON-schema pattern library) as placeable blocks** (bridge a component library
into Drupal's block/layout). `..._example`/`..._media_library`/`..._usage_tracking` submodules; Drush +
permissions. Config at `patternkit.settings`. Version **9.1.2**. Core `^10.3||^11`.

Content-editing/site-building — ensure pattern templates **escape** editor-provided field values (XSS);
restrict who places/configures patterns via its permission. No access role beyond that.
