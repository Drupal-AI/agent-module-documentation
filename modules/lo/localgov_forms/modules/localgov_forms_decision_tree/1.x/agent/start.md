<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Forms Demo Decision Tree (localgov_forms_decision_tree) — agent index

Example submodule of **localgov_forms**. Installing it creates one demo webform that shows how to
build a decision-tree / smart-answer form with Webform's conditional (`#states`) logic. Package
`LocalGov Drupal Examples`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir `1.x`
(installed 1.2.0).

Dependency (info.yml): `webform:webform` only. **No PHP** (empty `.module`), no routes, services,
permissions, hooks, schema or libraries — it is config-only.

## Solution docs

- **The demo webform, the decision-tree `#states` pattern, and how to reuse it** → [config/demo-form.md](config/demo-form.md)

## What it provides (from source)

- One config-install entity:
  `config/install/webform.webform.localgov_forms_demo_descion_tree.yml` — webform
  `localgov_forms_demo_descion_tree`, title *"Demo Decision Tree: Find the Perfect Playlist"*,
  status `open`, path `/form/localgov-forms-demo-descion-tree`.
- Five `radios` questions where each later question's visibility is gated by a `#states` `visible`
  rule on an earlier answer (era → genre → metal/grunge | lyrics/music | artists/popstars).
- `localgov_forms_decision_tree.module` contains only a file docblock.

## Security-relevant facts (public, neutral)

- Config-only demo: no executable code, no routes, no external calls. The demo webform is a normal
  Webform config entity, subject to Webform's own access control.
