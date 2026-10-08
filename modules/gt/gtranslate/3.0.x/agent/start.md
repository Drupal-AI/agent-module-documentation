# gtranslate — agent start

Adds a Google-Translate-powered JavaScript language switcher **block** ("GTranslate",
block id `gtranslate_block`, category *Accessibility*) that machine-translates the current
page into ~103 languages **client-side**. This is Google machine translation, **not**
Drupal core i18n / Content Translation — no source strings are stored or reviewed.
Depends on core `block`. Config UI: **Admin → Configuration → Regional and language →
GTranslate** (`/admin/config/regional/gtranslate`, route `gtranslate.settings`, permission
`gtranslate settings`).

- Place the block, pick widget look + languages, and tune every setting → [configure/gtranslate.md](configure/gtranslate.md)
