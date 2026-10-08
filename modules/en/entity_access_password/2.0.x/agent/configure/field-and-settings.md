# Configure Entity Access Password

## Global settings

Route `entity_access_password.settings_form` → `/admin/config/content/entity_access_password/settings`
(perm `administer_entity_access_password`). Config object `entity_access_password.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `global_password` | string | `''` | Site-wide password, stored **hashed** (`PasswordInterface::hash`). Empty submit leaves it unchanged. |
| `random_password_length` | int (8–50) | `8` | Length of passwords the widget's "generate random" produces. |

Set via drush:
```php
// Hash and store a global password.
$hash = \Drupal::service('password')->hash('s3cret');
\Drupal::configFactory()->getEditable('entity_access_password.settings')
  ->set('global_password', $hash)->save();
```

## The field type

Add a field of type **`entity_access_password_password`** (label "Password protection", category *access*,
cardinality 1) to any fieldable bundle. Default widget `entity_access_password_password`, default formatter
`entity_access_password_form`.

**Field-instance settings** (`field.field.<entity>.<bundle>.<field>` → `settings`, schema
`field.field_settings.entity_access_password_password`):

| Setting | Meaning |
|---|---|
| `password_entity` (bool) | Enable per-entity password check (password taken from the entity's field value). |
| `password_bundle` (bool) | Enable bundle password check. |
| `password` (string) | The bundle password, stored **hashed**. Empty submit keeps the current one. |
| `password_global` (bool) | Enable the global-password check (uses `entity_access_password.settings:global_password`). |
| `view_modes` (array) | View mode IDs on which protection is enforced. Empty = none enforced. |

Any enabled scope whose password matches grants access (checked in order entity → bundle → global in
`PasswordValidator`).

**Field value** (per entity, schema `field.value.entity_access_password_password`):

| Property | Meaning |
|---|---|
| `is_protected` (bool) | Whether this entity is currently protected. |
| `show_title` (bool) | If FALSE, the label is masked ("Protected entity") to users without access. |
| `hint` (text) | Optional hint shown above the password form (`Xss::filter`). |
| `password` (string) | The per-entity password, stored **hashed**. |

**Widget settings** (`field.widget.settings.entity_access_password_password`): `open` (details open by
default), `show_entity_title`, `show_hint`, `allow_random_password` (offer a generate-random button).

**Formatters:**
- `entity_access_password_form` — renders the password form; setting `help_text` (text, `Xss::filterAdmin`).
- `entity_access_password_boolean` — boolean formatter with `condition_property` (e.g. show whether protected).

## How enforcement works

- `hook_entity_view_mode_alter` (`src/Hook/ViewModeAlter.php`): if the requested view mode is in the
  field's `view_modes` and the user lacks access, the view mode is replaced with the constant
  `password_protected` view mode (config `core.entity_view_mode.node.password_protected` is installed
  optional). That display should use the `entity_access_password_form` formatter to show the form.
- Label masking: `src/Hook/LabelReplacer.php` (preprocess html/page_title/node/taxonomy_term) and the
  `[entity:protected-label]` token (`src/Hook/Token.php`) output "Protected entity" when `show_title` is off.
- Cache correctness: renders add the calculated cache context
  `entity_access_password_entity_is_protected:<entity_type>||<id>[||<view_mode>]`.

## Choose an access-storage backend

Enable at least one submodule or a successful password submission is never remembered:
`drush en entity_access_password_session_backend` (session; supports anonymous) and/or
`entity_access_password_user_data_backend` (per authenticated user).
