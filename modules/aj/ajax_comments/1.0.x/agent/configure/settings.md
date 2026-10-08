<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AJAX Comments

Two independent layers.

## 1. Global settings — `ajax_comments.settings`

Form at `admin/config/content/ajax_comments` (route `ajax_comments.settings`, permission
`administer site configuration`). Config object `ajax_comments.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `notify` | bool | `true` | Show a status message after a comment is posted via AJAX. |
| `enable_scroll` | bool | `true` | Scroll the browser to the affected comment after an AJAX action. |
| `reply_autoclose` | bool | `false` | When a reply form opens, auto-close any other open reply form. |

```bash
drush cget ajax_comments.settings
drush php:eval '\Drupal::configFactory()->getEditable("ajax_comments.settings")
  ->set("notify", TRUE)->set("enable_scroll", TRUE)->set("reply_autoclose", TRUE)->save();'
```

The settings page also lists every entity type/bundle that has a comment field, linking to each
one's display-settings form (that is where you flip the per-field switch below).

## 2. Per-field enablement — a third-party setting

Whether AJAX is actually used on a given comment field is a **third-party setting on the comment
field's formatter component** in the entity view display:

```
core.entity_view_display.<entity_type>.<bundle>.<view_mode>
  content.<comment_field>.third_party_settings.ajax_comments.enable_ajax_comments: '1'
```

- Default when unset is `'1'` (enabled) — `FieldSettingsHelper::isEnabled()` returns the
  third-party setting with a default of `'1'`. So AJAX comments is ON for every comment field
  out of the box.
- Set the value to `'0'` to disable AJAX on that field/view-mode while keeping the comments
  themselves.

UI: on the bundle's *Manage display*, open the comment field's format settings (the cog) and
toggle "Enable Ajax Comments", then Update + Save.

Scriptable:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('comment');                 // the comment field name
$c['third_party_settings']['ajax_comments']['enable_ajax_comments'] = '0';   // disable
$vd->setComponent('comment', $c)->save();
```

Read it back:

```bash
drush cget core.entity_view_display.node.article.default content.comment.third_party_settings
```

## Access

No permissions are defined by this module. Access to the AJAX add/reply/edit/delete endpoints is
governed by core comment entity access (`post comments`, `edit own comments`,
`administer comments`, etc.).
