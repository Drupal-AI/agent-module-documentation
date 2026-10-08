# Drush commands

Defined in `src/Commands/EncryptCommands.php` (registered via `drush.services.yml`,
service `encrypt.commands`, injected `@encryption`).

| Command | Aliases | Args / options | Purpose |
|---|---|---|---|
| `encrypt:encrypt <profile> <text>` | `encrypt`, `enc` | `--base64` | Encrypt `text` with the named profile; `--base64` base64-encodes the output. |
| `encrypt:decrypt <profile> <text>` | `decrypt`, `dec` | `--base64` | Decrypt `text` with the named profile. |
| `encrypt:validate-profile <profile>` | `evp` | — | Validate that the profile is usable (method + key resolve). |

Examples:
```
drush encrypt:encrypt --base64 my_profile 'text to encrypt'
drush encrypt:decrypt my_profile '<cipher>'
drush encrypt:validate-profile my_profile
```
Each throws if the encryption profile name can't be loaded.
