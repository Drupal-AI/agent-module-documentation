Field Group lets you organize fields into visual groups — tabs, accordions, fieldsets, HTML elements and more — on both entity forms and entity displays, without writing any code.

---

Out of the box Drupal shows fields as a flat vertical list on both the edit form and the rendered display. Field Group adds a layer on top of core's Field UI so site builders can wrap those fields in groups directly from **Manage form display** and **Manage display**. Groups are created with the "Add group" action, given a format type (Tabs, Tab, Fieldset, Details, Details sidebar, HTML element), and populated by dragging fields (and even other groups) into them, so groups can nest arbitrarily. Each format type is a `FieldGroupFormatter` plugin with its own settings form (labels, wrapper element, CSS classes, open/closed state, required marks, etc.), and the chosen settings are stored as third-party settings on the entity form/view display config entity — meaning groups are fully exportable and deployable like any other configuration. On the front end and in forms, groups render through Twig templates and render elements (details, vertical/horizontal tabs, html_element) that developers can theme or extend. Modules can define brand-new group formats by adding their own `FieldGroupFormatter` plugin, and can alter grouping behavior through a set of `hook_field_group_*` pre-render and process hooks. The deprecated `field_group_accordion` submodule adds a jQuery-UI accordion format. It is one of Drupal's most widely used contrib modules and a building block for complex content-editing experiences.

---

- Group related node fields into tabs on the edit form to shorten a long page.
- Wrap SEO/meta fields in a collapsible "Details" element that starts closed.
- Build a multi-section content type (e.g. Hero, Body, Sidebar) with fieldsets.
- Create horizontal tabs across the top of a media or paragraph edit form.
- Nest a group inside another group for multi-level form organization.
- Add an HTML wrapper element with custom classes around a set of display fields.
- Render a "Details sidebar" group beside the main form column (like core's node sidebar).
- Group fields on the rendered entity view for structured, themeable output.
- Move rarely used fields into a collapsed group to declutter the editor UI.
- Give each group a heading/label that shows on the front end.
- Export field groups as configuration and deploy them between environments.
- Apply per-view-mode grouping (different groups for "teaser" vs "full").
- Add required-field markers and validation-aware tab highlighting on forms.
- Create a custom group format (e.g. a slider or step wizard) via a FieldGroupFormatter plugin.
- Attach custom `drupalSettings`/JS to a group through a pre-render hook.
- Alter an existing group's region or attributes with `hook_field_group_pre_render_alter`.
- Add `#states` conditional visibility to a whole group of form fields.
- Theme a group by overriding its Twig template or theme suggestion.
- Provide a consistent tabbed layout across many content types.
- Organize Commerce product or profile fields into logical sections.
- Group paragraph and media entity fields for cleaner nested forms.
- Migrate Drupal 6/7 field groups forward with the field_group_migrate submodule.
- Improve editor UX by chunking dozens of fields into digestible groups.
- Show an accordion of collapsible sections (deprecated field_group_accordion submodule).
- Add per-group CSS classes to hook into a design system.
- Keep display markup semantic by wrapping field groups in chosen HTML5 elements.
- React to group deletion in code via `hook_field_group_delete_field_group`.
- Standardize form layouts site-wide without a custom theme or Layout Builder.
