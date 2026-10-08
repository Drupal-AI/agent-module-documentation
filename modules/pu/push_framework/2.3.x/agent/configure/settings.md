# Settings — templates, display modes & channel order

## The settings form

- Route: `push_framework.settings` → `/admin/config/system/push_framework`
  (`_permission: administer site configuration`), menu link under `system.admin_config_system`, local
  task "General".
- Form: `Drupal\push_framework\Form\SettingsGeneral` (extends the abstract
  `Drupal\push_framework\Form\Settings`, a `ConfigFormBase`; `getFormId()` = `push_framework_settings`).
  `SettingsGeneral` adds the **Channel Order** section (one `order_<channel_id>` number per discovered
  channel) on top of the shared content-template fields.
- The shared `Settings` form is reused for **per-channel** config too: pointed at a
  `<channel>.settings` config name it adds `active` and `use_default_settings` checkboxes. The base
  module only registers the global form; a channel module adds its own tab if it wants one.

There are **no module-defined permissions** and **no config schema** shipped; the module installs
`config/install` defaults only.

## Config object `push_framework.settings`

Installed defaults (`config/install/push_framework.settings.yml`):

```yaml
display_modes:
  node: push_framework
pattern:
  subject: '[site:name] notification: [push-object:label]'
  body:
    value: "[user:display-name],\r\n\r\n[push-object:content]"
    format: plain_text
```

Keys (read by `ChannelBase::getConfigValue()` when building content):

| Key | Meaning |
|---|---|
| `display_modes.<entity_type_id>` | View/display mode used to render the object for that entity type. Fallback `push_framework`. The install profile also ships a `push_framework` view mode + `node.page.push_framework` view display. |
| `pattern.subject` | Subject token pattern. Fallback `[push-object:label]`. |
| `pattern.body.value` | Body token pattern. Fallback `[push-object:content]`. |
| `pattern.body.format` | Text format id for the body; anything other than `plain_text` marks the body as HTML (wrapped in `Markup`). Fallback `plain_text`. |
| `order_<channel_id>` | Ascending try-order per channel (default 1); set in the Channel Order section. Lower = tried first. |

## Per-channel override config `<channel_id>.settings`

Each channel plugin returns its own config name from `getConfigName()` (convention
`<plugin_id>.settings`). Extra keys the base form/plugin use there:

| Key | Meaning |
|---|---|
| `active` | Boolean; drives `ChannelBase::isActive()`. Inactive channels are skipped during delivery. |
| `use_default_settings` | If TRUE (or a given content key is empty), the channel inherits `push_framework.settings` for that key instead of its own value. |
| `pattern.*`, `display_modes.*`, `order_<id>` | Same keys as above, resolved per channel before falling back to the global config, then to hardcoded defaults. |

## Tokens available in the patterns

- `[push-object:label]` — the object's label.
- `[push-object:content]` — the object rendered in the selected display mode.
- Plus standard `user` and global tokens (the form shows a token-tree link when the `token` module is
  enabled). Token replacement uses `['clear' => TRUE]`, so unmatched tokens are removed.

## Content resolution order (per key)

`ChannelBase::getConfigValue($key, $default)`: channel's own `<channel>.settings` value → (if empty or
`use_default_settings`) `push_framework.settings` value → (if still empty) the hardcoded `$default`.
