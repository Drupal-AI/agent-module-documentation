<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permission, menu link

The module ships **one route, one permission, one menu link** — all for the settings page. It adds
no route for block creation, promotion or editing; those ride on core Layout Builder / block_content.

## Route (`layout_builder_reusable_blocks.routing.yml`)

```
layout_builder_reusable_blocks.settings:
  path: '/admin/config/user-interface/layout-builder-reusable-blocks'
  defaults:
    _form: '\Drupal\layout_builder_reusable_blocks\Form\LayoutBuilderReusableBlocksConfigForm'
    _title: 'Layout Builder Reusable Blocks Settings'
  requirements:
    _permission: 'administer layout builder reusable blocks'
```

- Standard config-form route; state change is a POST through Drupal's Form API, so it carries the
  form CSRF token automatically. No GET side effects.

## Permission (`layout_builder_reusable_blocks.permissions.yml`)

```
administer layout builder reusable blocks:
  title: 'Administer Layout Builder Reusable Blocks'
  description: 'Configure settings for Layout Builder Reusable Blocks module'
  restrict access: true
```

- Gates **only** the settings form. It does **not** gate creating a reusable block, promoting an
  inline block, or editing a shared block — those follow core Layout Builder access (to configure the
  layout) and `block_content` entity access.

## Menu link (`layout_builder_reusable_blocks.links.menu.yml`)

`layout_builder_reusable_blocks.settings` → the route above, parent `system.admin_config_ui`
(*Configuration → User interface*), weight 10.

## What gates each capability (summary)

| Capability | Gated by |
|---|---|
| Change module settings | `administer layout builder reusable blocks` (restrict access) |
| Choose inline/reusable & create reusable block | Layout Builder access to configure the layout (core) |
| Promote inline → reusable on save | same Layout Builder configure access (core) |
| Edit a reusable block in place | `allow_editing_reusable_blocks` = TRUE **and** Layout Builder configure access (core) |
