# Drush: clear the token cache

Token registers a Drush cache-clear type (via `drush.services.yml` →
`Drupal\token\Drush\Commands\TokenCommands`). It hooks the `cache:clear` event and adds a
`token` clear type that runs `token_clear_cache()`.

```
drush cache:clear token      # clear only cached token info
drush cc token               # alias
drush cr                     # full rebuild also refreshes token info
```

Use after implementing/altering `hook_token_info()` so new tokens show in the browser.
Token defines **no** custom top-level Drush commands beyond this cache type.
