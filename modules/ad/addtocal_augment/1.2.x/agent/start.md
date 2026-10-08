# Add to Calendar Date Augmenter — agent index

Implements **one Date Augmenter plugin** (`addtocal`) that injects Google / iCal (Apple) /
Outlook "add to calendar" links into a date field's rendered output. It does **not** define a
plugin type (it consumes `date_augmenter`'s type), has no admin page, no configure route, no
permissions, no Drush. Persistent state is the plugin's settings stored as **field-formatter
third-party settings** under the `date_augmenter` key.

- **Enable/configure the plugin on a field formatter, its setting keys, and where they are stored** →
  [configure/settings.md](configure/settings.md)
- **The `addtocal` plugin: what it builds (VEVENT, Google URL), theme hooks, timezone, extending** →
  [plugins/addtocal.md](plugins/addtocal.md)

Key facts:
- Plugin class `Drupal\addtocal_augment\Plugin\DateAugmenter\AddToCal`, id `addtocal`
  (`#[DateAugmenter(id: "addtocal")]`), plugin manager service `plugin.manager.dateaugmenter`.
- Config schema id `date_augmenter.plugin.addtocal` (extends `date_augmenter.plugin_settings`).
- Requires a date formatter that supports the Date Augmenter API (e.g. Smart Date) to actually
  render — core's `datetime_default` formatter does not invoke augmenters.
- Theme hooks `addtocal_links` and `addtocal_links__modal`; libraries `addtocal_augment/modal`
  and `addtocal_augment/icons`.
