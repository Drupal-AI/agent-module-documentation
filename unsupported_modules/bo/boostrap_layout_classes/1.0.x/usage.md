<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Boostrap Layout Classes (machine name `boostrap_layout_classes`, note the misspelling) is a small Fields module that lets editors attach Bootstrap layout CSS classes (columns, spacing, ordering, etc.) to a field value through a dedicated widget, and renders those classes back out through a matching field formatter.

Use it when a site is built on a Bootstrap-style front-end theme and you want per-entity, editor-controlled layout tweaks stored as data on a field rather than hard-coded in templates.
---
Install like any module (`drush en boostrap_layout_classes`); it depends only on core `field`. There is no admin settings page and it declares no routes or permissions of its own.

Add a field to a content type, then choose the "Boostrap Layout Classes" widget on the Form Display tab and the matching formatter on the Manage Display tab. The widget stores the selected Bootstrap classes; the formatter (`src/Plugin/Field/FieldFormatter/BoostrapLayoutClassesFormatter.php`) emits them as CSS classes at render time. Class lists are read from the module's shipped config/CSS assets. It targets Drupal 8/9 (composer allows up to ^10).
---
- Let editors pick Bootstrap grid classes per entity without editing Twig.
- Attach spacing utility classes (margins/padding) to a field.
- Store layout choices as structured field data instead of inline markup.
- Render Bootstrap column classes from a field formatter.
- Give content teams controlled layout options on a Bootstrap theme.
- Add a layout-classes widget to any fieldable entity type.
- Standardize which Bootstrap classes editors may apply.
- Avoid free-text class fields that invite typos.
- Pair with a Bootstrap base theme for responsive columns.
- Expose ordering/offset utility classes to editors.
- Keep presentation choices editable in the content form.
- Reuse the same widget across multiple content types.
- Drive per-node responsive behavior via stored classes.
- Migrate hard-coded template classes into editable field data.
- Prototype Bootstrap layouts quickly during a build.
- Ship a consistent class vocabulary via module config.
- Combine with view modes to vary layout per display.