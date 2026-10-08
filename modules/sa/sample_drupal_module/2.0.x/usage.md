<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sample Drupal Module is a bare module skeleton: an `.info.yml` plus an otherwise empty `.module` file, provided as starter/reference boilerplate.
---
It defines no routes, permissions, services, schema, plugins, hooks or configuration. Enabling it has no functional effect on a site; it exists as a minimal starting point that developers can copy and rename, or as an example of the smallest installable Drupal module. Because it ships no code paths, there is nothing to configure and nothing an agent can operate at runtime.

There are no security-relevant surfaces: no anonymous endpoints, no data handling, no external calls, no secrets. The only operational task is enable/uninstall. Treat this module as a template rather than a feature.
---
- Use as a starting skeleton for a new custom module
- Copy and rename to scaffold your own module quickly
- Study the minimal files a Drupal 10 module needs
- Verify a module installs and uninstalls cleanly
- Demonstrate `core_version_requirement` in an info.yml
- Provide a placeholder module in a build
- Teach the smallest possible module structure
- Confirm your module directory layout is correct
- Test packaging or CI against a trivial module
- Enable to check module discovery works
- Serve as a reference for `type: module` info files
- Keep as an empty container to add hooks to later
- Show that a `.module` file may be empty
- Use in tutorials about module basics
- Baseline for measuring module install overhead
- Practice writing an update hook against a real module
- Illustrate the info.yml packaging metadata block
- Rename the machine name across files as an exercise
- Drop in as a no-op dependency placeholder
- Uninstall to confirm no residual config remains
