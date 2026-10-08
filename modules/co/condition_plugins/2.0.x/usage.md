<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Condition Plugins provides a **collection of additional Condition plugins** for Drupal's condition system,
usable anywhere conditions are consumed (block visibility, context reactions, and other condition-aware UIs).

Use it when core's built-in conditions (request path, user role, content type, language) are not enough and you
want extra ready-made conditions without writing your own plugin classes.
---
- No dependencies beyond core; enable with `ddev drush en condition_plugins`.
- Adds its Condition plugins to the shared condition plugin manager automatically.
- The new conditions appear wherever conditions are configured (e.g. block **Visibility** tabs, Context).
- No dedicated admin page — configuration happens on the host UI that consumes conditions.
- No permissions of its own; access follows the host feature (e.g. block administration).
- Works on Drupal 8/9/10 (broad `core_version_requirement`).
---
- Add extra visibility conditions to blocks.
- Provide conditions for context-based modules.
- Extend condition-aware access decisions.
- Avoid writing custom Condition plugin classes for common cases.
- Reuse the same conditions across blocks and contexts.
- Configure conditions through existing host UIs.
- Combine with core conditions (path, role, content type).
- Apply negation/AND-OR via the standard condition group UI.
- Keep condition logic in configuration.
- Target block display by the added condition criteria.
- Support multi-version sites (D8–D10).
- Layer onto Context or Panels-style condition consumers.
- Deploy condition settings as config.
- Reduce custom code for visibility rules.
- Use as a building block for business-rule visibility.
- Inspect available plugins via the condition plugin manager.
