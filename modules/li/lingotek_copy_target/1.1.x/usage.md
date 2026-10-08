<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lingotek Copy Target duplicates a downloaded Lingotek translation into additional target locales.

---

Using admin-configured locale mappings (original locale -> copy locale), the module hooks Lingotek's content and config translation presave events and calls Lingotek's own translation services to save the same downloaded data into the mapped target language. Mappings are managed through a config form (`configure lingotek_copy_target` permission) linked from the language edit form. It saves re-translating locales that should mirror another (e.g. regional variants).

---

- Copy a Lingotek translation into another locale.
- Mirror translations across regional language variants.
- Configure original-to-copy locale mappings.
- Trigger copying on Lingotek translation download.
- Cover both content and configuration translations.
- Reuse Lingotek's own save-target-data services.
- Manage mappings from a dedicated config form.
- Link the config from the language edit form.
- Gate configuration behind a dedicated permission.
- Avoid paying to re-translate mirror locales.
- Warn when a target language is not yet configured.
- Support multiple mappings simultaneously.
- Integrate with the Lingotek TMS module.
- Support Drupal 8.8, 9, and 10.
- Delete mappings via a confirm form.
- Keep mirror locales in sync automatically.
