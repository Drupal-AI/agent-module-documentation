<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Process Markdown to HTML — agent index

Migrate **process plugin converting Markdown source values to HTML** during migrations. Depends on
`migrate`. Version **1.2.0**. Core `^10||^11`.

Developer/migration tool (Migrate pipeline). Store converted HTML against a text format + render through
Drupal's filters (so it's XSS-filtered on output), not raw. Source is admin-defined migration input.
