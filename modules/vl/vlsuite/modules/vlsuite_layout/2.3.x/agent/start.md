<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Layout (vlsuite_layout) — agent index

Submodule of **vlsuite**. **Section layouts** via Layout Discovery, with per-section configuration.
Version **2.3.3**. Core `^10.3 || ^11`.
Depends on `layout_discovery`, `media_library_form_element`, `vlsuite_utility_classes`,
`vlsuite_slider`, `vlsuite_animations`.

**Per-section configuration is what separates a layout library from a theme** — background media,
utility classes, animation, slider behaviour. A layout that takes those covers a dozen designs; one
that cannot needs a new plugin per variation, and the list grows past usefulness.

Nested: `vlsuite_layout_tabs`.

Distinct from **`vlsuite_layout_builder`**: this is the *layouts*, that is the *editing experience*
around them.