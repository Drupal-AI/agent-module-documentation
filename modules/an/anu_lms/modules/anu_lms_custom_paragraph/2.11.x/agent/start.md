<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Example: Custom paragraph (anu_lms_custom_paragraph) — agent index

Example submodule of **anu_lms** (package `Anu LMS Examples`). Shows how to ship a custom paragraph by
swapping in your own compiled React bundles. Core `^10 || ^11`. Version 2.11.2. Depends only on `anu_lms`.

## What it provides

- `anu_lms_custom_paragraph_library_info_alter(&$libraries, $extension)` — when `$extension === 'anu_lms'`,
  rewrites each library's JS paths from `js/dist` to `/<this module path>/js/dist` (absolute path via
  `extension.list.module`), so the site loads this module's rebuilt bundles instead of the base module's.
- No config, routes, services, permissions or PHP classes — a `.module` with one hook.

## How to use it

Add your paragraph type config + fields in a real module, build a React bundle that includes the new
component into this module's `js/dist`, then this hook makes Anu LMS serve it. Copy the hook into your
own module for production. Sibling example `anu_lms_override_component` uses the identical mechanism to
replace an existing component.
