<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox for Group Content Menu (decoupled_toolbox_group_content_menu) — agent index

Nested sub-module of **Decoupled Toolbox for Group**. Exposes Group Content Menu trees in decoupled output. Package **Decoupled**. Core `>=8`. GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `group_content_menu` (contrib), `decoupled_toolbox`.

## What it provides

- Service `decoupled_toolbox_group_content_menu.menu_link_tree_builder` = `MenuLinkTreeBuilder` (event_subscriber), args `@entity_type.manager`, `@menu.link_tree`.
- Subscribes to `DecoupledRendererInterface::EVENT__RENDERER__OUTPUT__RENDERED__PREFIX . 'group_content_menu'` (`RenderedOutputEvent`). `onOutputRendered()` builds the menu link tree via `buildMenuLinkTreeForOutput()`, sorts elements by weight, and injects the structured menu into the entity's decoupled output.
- No routes, permissions, config, or Drush.

## Operate

Enable alongside Decoupled Toolbox for Group; render `group_content_menu` entities through the decoupled endpoint to get the menu tree. See parent [api/endpoints.md](../../../../1.6.x/agent/api/endpoints.md).
