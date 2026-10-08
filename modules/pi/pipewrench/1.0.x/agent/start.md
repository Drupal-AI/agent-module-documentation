<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pipewrench (pipewrench) — agent index

A small "shared utility" module (Lullabot) that makes two editorial-quality tweaks. Depends on
core `node` and `field`. Core requirement `^10 || ^11`. **Release is 1.0.0-alpha1 — alpha, not
security-advisory-covered.** No routes, permissions, config schema or settings pages.

What it does (only two behaviours, both driven by `src/Hook/PipewrenchHooks.php`):
- **Title help text on base fields** → [configure/title-help-text.md](configure/title-help-text.md).
  Adds a "Title field help text" field to the node type add/edit form; on save it writes the text
  into a `base_field_override` for `node.{bundle}.title` so the Title field on the node form shows a
  description. Fills a real gap — base fields have no help-text slot in Field UI.
- **Better Linkit widget help text.** *Only when the contrib `linkit` module is installed* (it is an
  optional runtime enhancement, **not** a declared dependency), `field_widget_info_alter` swaps the
  `linkit` widget class to `PipewrenchLinkitWidget`, which rewrites the URI element's `#description`.

Surface: `src/Hook/PipewrenchHooks.php`, `src/Plugin/Field/FieldWidget/PipewrenchLinkitWidget.php`,
`pipewrench.module` (empty stub) — three code files. No Drush, no API for others to call, no plugin
type defined (it overrides Linkit's existing widget rather than declaring a new plugin type).

Related: **complements `fieldhelptext`** (bulk-edits descriptions on *configurable* fields) rather
than overlapping — this one enables descriptions on *base* fields. A site may reasonably run both.
