<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Field - SDC display lets you render an entity view mode through a Single Directory Component (SDC), mapping Custom Field column values to the component's props and other fields to its slots.

---

The submodule adds a **"Custom Field - Single directory component options"** section to a bundle's *Manage display* form (`hook_form_entity_view_display_edit_form_alter()`), where you tick **"Render using a component"** and pick an SDC **component** from the components available on the site. Its choice is stored as a **third-party setting on the `entity_view_display` config entity** under provider `custom_field_sdc`, key `settings`: `{enabled, component, variant, props, slots}`. At render time `hook_entity_view_alter()` reads that setting and, when enabled with a valid component, **replaces the entire built output** with a `#type => component` render element: Custom Field column values are turned into the component's **props** via the module's PropWidget plugins (from the parent `custom_field` module), and named **slots** are filled from other fields on the display. Required props with no value abort the render (falling back to the normal display), invalid/malformed components are logged and skipped, and if the separate `sdc_display` module is controlling the display this module defers to it. There is no field type, widget, or admin settings page of its own — configuration is entirely per view mode via the display's third-party settings, validated by the schema `core.entity_view_display.*.*.*.third_party.custom_field_sdc`.

---

- Render an Article's default view mode through a themed SDC card component instead of the field list.
- Map a Custom Field "spec" column (title, price) onto an SDC component's props.
- Drive a `navigation:badge` or `olivero:teaser` style component from Custom Field data.
- Configure a component per view mode (e.g. a compact component for "teaser", a rich one for "full").
- Fill an SDC slot with another field's rendered output (e.g. body into a component's content slot).
- Choose a component **variant** for a view mode without writing a formatter.
- Present structured Custom Field data as a reusable design-system component.
- Keep markup in a versioned SDC component while Drupal only supplies the data.
- Turn off component rendering for a view mode by unchecking "Render using a component".
- Swap the component used by a view mode by changing one select on Manage display.
- Avoid a bespoke field formatter by binding fields to component props declaratively.
- Reuse the same SDC component across multiple bundles' view modes.
- Gracefully fall back to normal field rendering when a required prop is empty.
- Let front-end developers own component markup while site builders wire up data.
- Coexist with the `sdc_display` module (this module steps aside when sdc_display is active).
- Export the component binding as configuration (`entity_view_display` third-party settings) for deployment.
- Map a Custom Field image/entity-reference column to a component's image prop via PropWidgets.
- Build a card grid view mode where each node renders as one component instance.
- Migrate ad-hoc Twig field templates to standardized SDC components.
- Preview how a view mode looks as a component directly from Manage display.
- Bind a Custom Field color column to a component's color/style prop.
