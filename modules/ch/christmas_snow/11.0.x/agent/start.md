# Christmas Snow — agent index

Decorative animated snowfall (Snowstorm JS library) on the front end. One admin settings form; no
permissions of its own (config gated by core `administer site configuration`), no plugins, no Drush.
`configure` = `christmas_snow.settings` → `/admin/config/christmas_snow/cs_settings`.

- **Every settings key, how snow is attached, the CDN caveat** → [configure/settings.md](configure/settings.md)

Submodule (own docs):
- `christmas_snow_schedule` (date-range auto on/off via cron) →
  [../../modules/christmas_snow_schedule/11.0.x/agent/start.md](../../modules/christmas_snow_schedule/11.0.x/agent/start.md)

Key facts:
- `Hook\ChristmasSnowHooks::pageAttachments()` attaches `christmas_snow/snow` + the Snowstorm library and
  emits `drupalSettings.christmas_snow.*`; suppressed on admin routes; cache tag
  `config:christmas_snow.settings`.
- No `config/install` defaults ship — config keys are created only when the settings form is saved
  (`buildForm` uses inline `?:` fallbacks like `128`, `#FFFFFF`, `500`, `'33'`).
- Snowstorm is an **external CDN asset** on the defunct `cdn.rawgit.com` host; repoint the library to a
  working/self-hosted copy for the effect to load.
