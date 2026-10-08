# Sticky primary tabs block

Plugin `Drupal\sticky_local_tasks\Plugin\Block\StickyLocalTasksBlock`.

- Block id: `sticky_local_tasks`
- Admin label: `Sticky primary tabs`
- Requires core `block` module (the block only exists when Block is enabled).

Use this when config `usage` is `block`: place the block and it renders the sticky tabs only on the
pages/roles you allow via standard core block visibility. Its render output comes from
`StickyLocalTasksBuilder::build()` (same widget as `usage: all`).

## Block settings

| Setting | Config key | Values / default |
|---|---|---|
| Preferred position | `position` | `bottom-right` (default) or `bottom-left`; `#required` |

`defaultConfiguration()` returns `['position' => 'bottom-right']`. `blockForm()` exposes the position
radios, `blockSubmit()` stores the chosen value, and `build()` calls
`$builder->build(Position::from($this->configuration['position']))`.

The `position` block setting only sets where the widget floats; the block's placed **region** affects
only its spot in the markup, not the on-screen position (per the project README). Global
`usage_options` (hide default tasks, Gin/dark colors, remember toggle) still apply because they are
read inside `build()` from `sticky_local_tasks.settings`.

Config schema for the block setting is `block.settings.sticky_local_tasks` (a `block_settings` mapping
with a `position` string), in `config/schema/sticky_local_tasks.schema.yml`.
