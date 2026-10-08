<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fivestar hooks (from `fivestar.api.php`)

Implement these in your module (procedural `hook_...` in `.module`, or an OOP `#[Hook(...)]`
class) to extend Fivestar.

## `hook_fivestar_widgets()`

Register custom star skins. Return `key => ['label' => t('…'), 'library' => 'my_module/x']`,
where `library` is a fully-qualified asset library holding the skin's CSS/images.

```php
function my_module_fivestar_widgets() {
  return [
    'awesome' => ['library' => 'my_module/awesome', 'label' => t('Awesome Stars')],
  ];
}
```

## `hook_fivestar_widgets_alter(array &$widgets)`

Rename or remove skins after discovery.

```php
function my_module_fivestar_widgets_alter(array &$widgets) {
  $widgets['awesome']['label'] = t('Pretty good stars');
  unset($widgets['hearts']);
}
```

## `hook_fivestar_access($entity_type, $id, $vote_type, $uid)`

Called before every vote. Return:
- `TRUE` — this module supports/permits voting on the object,
- `FALSE` — hard-deny (overrides everything),
- `NULL` — no opinion. **If every module returns `NULL`, access is denied.**

```php
function my_module_fivestar_access($entity_type, $id, $vote_type, $uid) {
  if ($uid == 1) {
    return FALSE; // never let the admin user vote
  }
}
```

Fivestar's own implementation (`fivestar_fivestar_access`) returns `TRUE` when a
fivestar field instance exists on the entity for that vote type.

These are the only hooks Fivestar *invites*. (It also implements core hooks internally —
`hook_theme`, `hook_form_*_alter`, preprocess — but those are not extension points for you.)
