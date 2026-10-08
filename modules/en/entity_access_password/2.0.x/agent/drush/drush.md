# Drush

The module ships **no** Drush commands. Use core drush for setup:

```bash
# Enable an access-storage backend (required to remember granted access).
drush en entity_access_password_session_backend -y     # session, supports anonymous
drush en entity_access_password_user_data_backend -y    # per authenticated user

# Set the hashed global password (see configure/field-and-settings.md for the hash step).
drush php:eval "\$h=\Drupal::service('password')->hash('s3cret'); \Drupal::configFactory()->getEditable('entity_access_password.settings')->set('global_password',\$h)->save();"
```

Fields, widgets, and formatters are configured through the entity's field UI / config, not drush commands.
