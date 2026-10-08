<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Stretched Link (entity_stretched_link) — agent index

A tiny display helper that adds a **"Stretched Link"** extra display pseudo-field to **every**
entity type/bundle (hidden by default). Enable it on a view-display's *Manage Display* screen and
the entity renders an **empty core link to itself** with class `stretched-link`, so the whole
card/teaser becomes clickable (the Bootstrap "stretched link" pattern). Version **1.0.0-alpha1**
(pre-release). Core `^10 || ^11`. License GPL-2.0-or-later. Package `Custom`.

- **How it works, the two hooks, the rendered markup, settings, and the required theme CSS** →
  [fields/stretched-link.md](fields/stretched-link.md)

## What it actually is (from source)

- **No `src/`, no plugins, no config, no schema, no routes, no permissions, no services, no
  Drush.** The entire module is `entity_stretched_link.info.yml` + `entity_stretched_link.module`.
- Dependency: core **`field`** only.
- Two procedural hooks in `entity_stretched_link.module`:
  - `entity_stretched_link_entity_extra_field_info()` — registers a `display` extra field
    `stretched_link` (label *"Stretched Link"*, `weight 99`, `visible FALSE`) on every
    `entity_type_id`/`bundle_id` pair (iterates `entityTypeManager()->getDefinitions()` and
    `entity_type.bundle.info`).
  - `entity_stretched_link_entity_view()` — if `$display->getComponent('stretched_link')` is set,
    adds `$build['stretched_link']` as `#type => 'link'`, `#title => ''`, `#url =>
    $entity->toUrl()`, `#language => $entity->language()`, attributes `rel=tag`,
    `class=[stretched-link]`, and `title` = *"Read more about <label>"* (label run through
    `strip_tags()` + `t()`).
- **Ships NO CSS.** The effect only appears if the theme provides `.stretched-link::after`
  (absolute overlay). See the solution doc for the rule.

## Operate it

1. `drush en entity_stretched_link -y`.
2. On the target bundle's view-display (e.g. `admin/structure/types/manage/<type>/display/teaser`),
   move **Stretched Link** out of *Disabled*.
3. Ensure the theme defines a `.stretched-link::after` overlay rule.
