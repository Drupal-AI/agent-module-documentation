# Drush commands

Provided by `Drupal\simple_oauth\Drush\Commands\SimpleOauthCommands`.

| Command | Aliases | Purpose |
|---|---|---|
| `simple-oauth:generate-keys <keypath>` | `so:generate-keys`, `sogk` | Generate the RSA public/private key pair used to sign tokens, writing `public.key` and `private.key` into the given directory. |

```
# Generate keys into a directory outside the docroot.
drush simple-oauth:generate-keys ../keys

# Then point the module at them:
drush config:set simple_oauth.settings public_key ../keys/public.key -y
drush config:set simple_oauth.settings private_key ../keys/private.key -y
```

Equivalent to the "Generate keys" button on the settings form. Keep the private key out of the
web root and out of version control.
