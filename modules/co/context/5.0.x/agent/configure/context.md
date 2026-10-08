# The `context` config entity — conditions + reactions

A context is a `ConfigEntityType` (`id = "context"`, class
`Drupal\context\Entity\Context`), admin permission `administer contexts`. Config prefix:
`context.context.*`. Exported keys (`config_export`): `name`, `label`, `group`,
`description`, `requireAllConditions`, `disabled`, `conditions`, `reactions`, `weight`.

Structure:

```
context.context.my_context:
  name: my_context
  label: 'My context'
  group: ''                     # optional grouping label
  requireAllConditions: false   # false = OR (any), true = AND (all)
  disabled: false
  weight: 0
  conditions:                   # keyed by plugin id; reuse CORE Condition plugins
    request_path:
      id: request_path
      pages: '/products/*'
      negate: false
      uuid: ...
  reactions:                    # keyed by plugin id; Context ContextReaction plugins
    blocks:
      id: blocks
      blocks: { ... }
```

## Conditions (reuse core Condition plugins)

Conditions are **not** a Context plugin type — the entity loads them through core's
`plugin.manager.condition` into a `ConditionPluginCollection`. So any core/contrib Condition
works (`request_path`, `user_role`, `node_type`, `language`, …). Context adds a few of its own
Condition plugins (`src/Plugin/Condition/`): `request_domain`, `http_status_code`,
`request_path_exclusion`, `user_status` (user profile page), `view_inclusion`, `context` (any),
`context_all`. Evaluation logic: `requireAllConditions` true → AND, false → OR; **no conditions
= sitewide** (always active). See `ContextManager::evaluateContextConditions()`.

## Reactions (Context's ContextReaction plugins)

Reaction plugin ids (`src/Plugin/ContextReaction/`), matching config schema
`reaction.plugin.*`:

| id | Effect |
|---|---|
| `blocks` | Place blocks into theme regions (per-context block layout). Config: `theme`, `include_default_blocks`, block collection. The block-placement reaction. |
| `theme` | Switch the active theme (via `theme.negotiator.context_themeswitcher`). |
| `body_class` | Add class(es) to `<body>` (applied in `context_preprocess_html`). |
| `page_title` | Override the page title. |
| `page_template_suggestions` | Add Twig template suggestions (`hook_theme_suggestions_page_alter`). |
| `menu` | Set the active menu trail (overrides `menu.active_trail` via `ContextMenuActiveTrail`). |
| `regions` | Disable/unset theme regions. |

## Configuring

There is **no config form in the base module** (`configure` is null). Build contexts through
the **context_ui** submodule at `/admin/structure/context`, or write the `context.context.*`
config directly and `drush cim`. Config schema: `config/schema/context.schema.yml`
(+ `context.data_types.schema.yml`).
