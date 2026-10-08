<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Reference Field Filter — agent index

Adds one `ViewsReferenceSetting` plugin (**id `exposed_filters`**) to the [viewsreference]
field so editors can set a referenced view's **exposed filter** values on the entity form,
plus a "Show Filters on Page" toggle. No config UI, no permissions, no Drush, no config
schema of its own. It rides entirely on viewsreference's field/widget machinery.

- **The `exposed_filters` setting plugin: what it does, `vr_exposed_filters_visible`, alterView/alterFormField** →
  [plugins/exposed-filters-setting.md](plugins/exposed-filters-setting.md)
- **Turn it on for a viewsreference field / where enablement is stored** →
  [configure/enable-on-field.md](configure/enable-on-field.md)

Key facts:
- Enabled by adding `exposed_filters` to a viewsreference field's **`enabled_settings`**
  field setting (`field.field.<entity>.<bundle>.<field>` → `settings.enabled_settings`).
- Requires `viewsreference` (^2.0@beta) and `views`.
- Service `viewsreference_filter.views_utility` (`ViewsRefFilterUtility::loadView`) just loads
  and initialises the referenced view executable so its exposed handlers can be read.
