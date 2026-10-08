<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wingsuit UI Patterns (wingsuit_ui_patterns) — agent index

Submodule of **wingsuit_companion**. Turns components declared in a Wingsuit project's
`wingsuit.yml` into **UI Patterns pattern plugins**, plus the Twig extensions.
Version **8.x-2.2**. Core `^8 || ^9 || ^10 || ^11`.

The submodule that makes the toolkit useful — without it a Wingsuit install is a stream wrapper
pointing at compiled assets.

**Heaviest dependency list in the suite, and it could not be enabled on the review install.**
Needs `ui_patterns (>=1.1)`, `ui_patterns_layouts`, `ui_patterns_settings (>=2.0)`,
`ui_patterns_extends`, `components` — the last three were absent. Honestly declared, but adopting
this is a **six-module install**; put the UI Patterns stack in first.

**Ecosystem note:** core **SDC** now covers much of what UI Patterns was built for. On a new
project, weigh the Wingsuit→SDC path against Wingsuit→UI Patterns before committing to this
chain.