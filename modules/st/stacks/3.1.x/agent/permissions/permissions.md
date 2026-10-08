<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (`stacks.permissions.yml`)

`add stacks entity entities` gates the whole Stacks admin hub and every inline-editor AJAX
route (`stacks.admin*`) — it is the practical "use Stacks" permission for editors.

| permission | notes |
|-----------|-------|
| `developer` | Developer Access; broad advanced functionality. **restricted** |
| `add stacks entity entities` | create widget entities; also gates admin hub + AJAX editor routes |
| `administer stacks entity entities` | admin form for Widget Entity. **restricted** |
| `delete stacks entity entities` | delete widget entities |
| `edit stacks entity entities` | edit widget entities |
| `view published stacks entity entities` | view published widgets |
| `view unpublished stacks entity entities` | view unpublished widgets |
| `add widget instance entity entities` | create widget instance entities |
| `administer widget instance entity entities` | admin form for Widget Instance. **restricted** |
| `delete widget instance entity entities` | delete instances |
| `edit widget instance entity entities` | edit instances |
| `view published widget instance entity entities` | view published instances |
| `view unpublished widget instance entity entities` | view unpublished instances |
| `add widget types entity entities` | create Widget Types entities |
| `add Widget Extend entities` | create extend items |
| `administer Widget Extend entities` | admin form for Widget Extend. **restricted** |
| `delete Widget Extend entities` | delete extend items |
| `edit Widget Extend entities` | edit extend items |
| `view published Widget Extend entities` | view published extend items |
| `view unpublished Widget Extend entities` | view unpublished extend items |

Config-entity bundles (`widget_entity_type`, `widget_extend_type`) use the core
`administer site configuration` permission (their `admin_permission`).
