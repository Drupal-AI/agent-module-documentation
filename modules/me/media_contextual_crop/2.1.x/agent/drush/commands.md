# Drush commands

One command, registered via `drush.service.yml` (service `media_contextual_crop.migrate` →
`Drush\Commands\MediaContextualCropCommands`).

| Command | Alias | Args | What it does |
|---|---|---|---|
| `media_contextual_crop:migrateToImageFormatter` | — | none | One-shot migration of view displays off the deprecated `contextual_image` formatter |

## Behaviour

Iterates every `core.entity_view_display.*` config. For each display that targets the **media**
entity type and depends on `media_contextual_crop`, it inspects each field's formatter; where the
formatter is the deprecated `contextual_image` **and** the configured image style actually
multi-crops (`MediaContextualCropService::styleUseMultiCrop($style_name)` is TRUE), it rewrites
the formatter `type` to the plain core `image` formatter, saves the config, and re-saves the
`entity_view_display` entity. It logs each changed display and a summary
("No configuration changed." or a note to review the changes).

This exists because 2.x no longer needs a dedicated formatter — the preprocess interception
(see [../hooks/preprocess.md](../hooks/preprocess.md)) upgrades the plain `image` formatter in
place. Run once after upgrading a site that still uses `contextual_image`.

```bash
drush media_contextual_crop:migrateToImageFormatter
```
