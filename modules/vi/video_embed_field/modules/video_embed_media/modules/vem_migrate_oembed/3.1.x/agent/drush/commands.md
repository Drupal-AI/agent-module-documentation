# Drush commands

Registered via `drush.services.yml` → `VemCommands` (arg: `@vem_migrate_oembed.migrate`, the
`VemMigrate` service).

| Command | Alias | Purpose |
|---|---|---|
| `vem:migrate_oembed` | `vemmo` | Migrate video_embed_media entities to core oEmbed video source |

Usage:
```bash
drush vemmo
# or
drush vem:migrate_oembed
```
No arguments/options. Run once after setting up a core oEmbed (Remote video) media type; verify
results before removing the contrib video source. Logic lives in
`src/VemMigrate.php`.
