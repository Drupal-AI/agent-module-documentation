<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Comment Delete (per comment field)

There is **no admin settings page**. Settings are stored as **third-party settings on the comment
field config entity** and edited in the "Comment Delete" section of that field's edit form
(`hook_form_field_config_edit_form_alter`, only for fields whose `field_type` is `comment`).

## Where it is stored

Config entity: `field.field.<entity_type>.<bundle>.<comment_field>`
(e.g. `field.field.node.forum.comment_forum`). Path within it:

```yaml
third_party_settings:
  comment_delete:
    operation:            # allowed operations (checkboxes -> keeps selected keys)
      hard: hard
      hard_partial: hard_partial
      soft: soft
    visibility: visible   # visible | visible_multiple | invisible
    label:                # optional per-operation label overrides
      hard: ''
      hard_partial: ''
      soft: ''
    message:              # optional per-operation confirmation messages (comment tokens allowed)
      hard: ''
      hard_partial: ''
      soft: ''
    mode: unset           # soft-delete mode: unset | unpublished
    anonymize: false      # on soft delete (unset mode) set author to Anonymous
    default: soft         # default selected operation (must be one of the allowed operations)
    time_limit: false     # only allow deletion within a window after creation
    timer: 0              # window length in seconds (used when time_limit is true)
```

## Field meanings

- **operation** — which of `hard` / `hard_partial` / `soft` are offered. If none selected, the
  module does nothing (delete falls back to core behavior).
- **visibility** — `visible` always shows the operation radios; `visible_multiple` shows them only
  when the user has more than one available operation; `invisible` hides them and always uses
  `default`.
- **label / message** — override the operation's radio label and post-delete confirmation message
  (message supports `comment` tokens).
- **mode** — for soft delete: `unset` blanks the comment's subject and non-base fields;
  `unpublished` instead sets the comment unpublished (keeps thread levels).
- **anonymize** — with `unset` mode, reassigns the deleted comment's author to uid 0.
- **default** — pre-selected operation; validated to be one of the allowed `operation` keys.
- **time_limit / timer** — when enabled, non-"anytime" delete permissions expire `timer` seconds
  after the comment (or, for reply permissions, the parent comment) was created.

## Set it scriptably

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'forum', 'comment_forum');
$field->setThirdPartySetting('comment_delete', 'operation', ['soft' => 'soft', 'hard' => 'hard']);
$field->setThirdPartySetting('comment_delete', 'visibility', 'visible');
$field->setThirdPartySetting('comment_delete', 'default', 'soft');
$field->setThirdPartySetting('comment_delete', 'mode', 'unset');
$field->save();
```

Read it back:

```bash
drush cget field.field.node.forum.comment_forum third_party_settings.comment_delete
```

## Config schema

Ships `field.field.*.*.*.third_party.comment_delete` (a mapping validating operation/visibility/
label/message/mode/anonymize/default/time_limit/timer), so values are schema-checked as part of the
field config.
