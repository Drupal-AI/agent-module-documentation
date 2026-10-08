# Configure Admin User Language

Config object **`admin_user_language.settings`** (form `BasicForm`, route
`admin_user_language.basic_form` = `/admin/config/admin_user_language/settings`).

```yaml
default_language_to_assign: '-1'   # shipped default
prevent_user_override: false       # shipped default
```

## `default_language_to_assign`

The value written to each user's `preferred_admin_langcode`. Options offered by the form:

- `-1` → **"- No preference -"**: the module does nothing (no language forced).
- `preferred_langcode` → **"The user's site language"**: at save time it is replaced with the user's
  own `getPreferredLangcode()`.
- any active **langcode** (e.g. `en`, `nl`) → that language is assigned.

The assignment only happens if the resolved langcode is one of the site's **active** languages
(checked against `language_manager`).

## `prevent_user_override`

- `FALSE` → the language is set **only when the user is new** (`$entity->isNew()`). Existing users
  keep whatever they chose. A soft default.
- `TRUE` → the language is **re-applied on every user save**, and
  `admin_user_language_form_user_form_alter()` sets `#disabled` on the
  `language.preferred_admin_langcode` form element, so users cannot change it in the UI.

## Mechanism

`admin_user_language_entity_presave()` runs for every `UserInterface` save:

```php
$default = $config->get('default_language_to_assign');
if ($default === 'preferred_langcode') { $default = $entity->getPreferredLangcode(); }
if ($default && isset($active_languages[$default])) {
  if ($prevent_user_override === TRUE || $entity->isNew()) {
    $entity->set('preferred_admin_langcode', $default);
  }
}
```

## Set it with drush

```bash
drush cset admin_user_language.settings default_language_to_assign en -y
drush cset admin_user_language.settings prevent_user_override true -y
drush cget admin_user_language.settings
```

Read a user's resulting admin language:
`drush ev '$u=\Drupal\user\Entity\User::load(2); print $u->get("preferred_admin_langcode")->value;'`

Requires at least two active languages (add one with `drush language:add <langcode>`); with only one
language the *administration pages language* field is not meaningful.
