# Layout Builder Tabs — agent index

Adds one Layout Builder section type, the **`tabs`** layout ("Tabs", category *Extra Layouts*).
Each block placed in the section's single `tabs` region renders as its own tab. No config UI, no
settings, no permissions, no Drush — you use it by adding a Tabs section in Layout Builder.

- **Add/use the Tabs layout in Layout Builder; where it is stored in config** →
  [configure/use-tabs-layout.md](configure/use-tabs-layout.md)
- **Template, the `sortbyweight` Twig filter, tab labels, Olivero library, in-editor preview** →
  [theming/template.md](theming/template.md)

Key facts:
- Layout plugin id `tabs`, defined in `layout_builder_tabs.layouts.yml` via core `layout_discovery`.
- Class `Drupal\layout_builder_tabs\Plugin\Layout\TabsLayout` (extends `LayoutDefault`).
- Single region: `tabs`.
- Stored in the entity view display's Layout Builder sections
  (`core.entity_view_display.<entity>.<bundle>.<mode>` → `third_party_settings.layout_builder.sections[*].layout_id: tabs`).
- Frontend library `layout_builder_tabs/tabs`; extra `olivero/tabs` attached when the Olivero theme is active.
