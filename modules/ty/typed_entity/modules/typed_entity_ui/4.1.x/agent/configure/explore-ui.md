# The Typed Entity explorer — routes & permission

No settings form and no config entities — the "configure" route is the explorer itself.

## Routes (`typed_entity_ui.routing.yml`)

| Route | Path | Handler | Permission |
|---|---|---|---|
| `typed_entity_ui.explore` | `/admin/config/development/typed-entity` | `ExploreForm` (form) | `explore typed entity classes` |
| `typed_entity_ui.details` | `/admin/config/development/typed-entity/{typed_entity_id}` | `ExploreDetails::__invoke` | `explore typed entity classes` |
| `typed_entity_ui.hide_video` | `/admin/config/development/typed-entity/hide-video` | `ExploreDetails::hideVideo` | `access content` |

Menu link `typed_entity_ui.explore` ("Explore Typed Entity") sits under
`system.admin_config_development` (*Configuration → Development*).

## Permission (`typed_entity_ui.permissions.yml`)

```yaml
explore typed entity classes:
  title: 'Explore typed entity classes'
```

Grant it to a role to let non-admins reach the explorer, e.g.:

```bash
drush role:perm:add developer 'explore typed entity classes'
```

or in config: add `explore typed entity classes` to the role's `permissions` list in
`user.role.<role>`.

## What the page shows

`ExploreForm` lets you choose an entity type + bundle and renders the matching typed repository,
its wrapper `ClassWithVariants` (fallback + variants) and renderer variants, plus a
reflection-based summary of each class via the theme hooks:

- `php_class_info` — parent class + implemented interfaces of a class.
- `class_with_variants` — the fallback and variant list of a `ClassWithVariants` (shows
  "- None available -" when the fallback does not resolve).
- `php_class_summary` — namespace, `final class`/`class` keyword, doc comment, source file path,
  and (for repositories) the reconstructed `#[TypedRepository(...)]` attribute source.

## State

One State flag, `typed_entity_ui.hide_video_thumbnail`, records that the intro video was
dismissed (`ExploreDetails::hideVideo`); `hook_uninstall` deletes it. There is nothing else to
configure.
