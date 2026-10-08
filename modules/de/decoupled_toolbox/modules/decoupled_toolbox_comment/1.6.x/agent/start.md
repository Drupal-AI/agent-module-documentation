<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox for Comment Field (decoupled_toolbox_comment) — agent index

Sub-module of **Decoupled Toolbox**. Makes Comment compatible with Decoupled Toolbox. Package **Decoupled**. Core `>=10`. License GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `comment`, `decoupled_toolbox`.

## What it provides

- One field formatter plugin **`decoupled_comment_field`** (`CommentFieldDecoupledFormatter`, extends `GenericDecoupledFormatter`), `field_types` = `comment`, in `src/Plugin/Field/FieldFormatter/CommentFieldDecoupledFormatter.php`.
- Adds a `view_mode` setting (default `default`) so each referenced comment is rendered through the chosen comment view mode; view-mode options come from `EntityDisplayRepository::getViewModeOptionsByBundle('comment', <comment_type>)`.
- Uses the PHP-attribute plugin form `#[FieldFormatter(id: 'decoupled_comment_field', ...)]` and extends `GenericDecoupledFormatter`.
- No routes, permissions, services, config, or Drush of its own.

## Operate

Enable (`drush en decoupled_toolbox_comment -y`), then on the target bundle's **Decoupled** view display select the *Comment Field* decoupled formatter for the comment field and set a **Decoupled field key**. The value is serialized by the parent module's collection endpoint. See the parent [fields/formatters.md](../../../1.6.x/agent/fields/formatters.md) for the shared formatter model.
