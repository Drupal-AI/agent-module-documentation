<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Example: Component override (anu_lms_override_component) — agent index

Example submodule of **anu_lms** (package `Anu LMS Examples`). Shows how to replace an existing Anu LMS
React component by swapping in your own compiled bundles. Core `^10 || ^11`. Version 2.11.2. Depends
only on `anu_lms`.

## What it provides

- `anu_lms_override_component_library_info_alter(&$libraries, $extension)` — when
  `$extension === 'anu_lms'`, rewrites each library's JS paths from `js/dist` to
  `/<this module path>/js/dist` (absolute path via `extension.list.module`), so the site loads this
  module's rebuilt bundles instead of the base module's.
- No config, routes, services, permissions or PHP classes — a `.module` with one hook.

## How to use it

Build a React bundle that replaces the target component into this module's `js/dist`; the hook makes
Anu LMS serve it. Copy the hook into your own module for production. Identical mechanism to
`anu_lms_custom_paragraph` (which frames it as adding a new paragraph rather than overriding one).
