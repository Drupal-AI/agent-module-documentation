# index_now — Drush commands

Registered via `index_now.services.yml` (`index_now.key_commands`, tagged `drush.command`) →
`IndexNowKeyCommands`.

| Command | Alias | Purpose |
|---|---|---|
| `index_now:keygenerate` | `indnowkeygen` | Generate (or rotate) the IndexNow API key. Calls `IndexNowKeyManager::generateKey()` (a new UUID stored at `index_now.settings:api_key`) and prints the new key. |

```bash
drush index_now:keygenerate
# Index Now API key has been generated: 1b2c...uuid
```

Use it when the runtime requirements check reports a missing key, or to rotate the key. After
rotation the key file is served at the new `/index_now_api_key_{new-key}.txt` path.

Note: content saves made **through Drush** only ping search engines when `cli_mode` is enabled in
the settings (otherwise CLI context is skipped by `isEntityIndexable()`).
