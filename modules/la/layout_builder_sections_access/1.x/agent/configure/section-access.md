<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring per-section access

There is no admin settings page. The options are added to the core Layout Builder section form and
stored inside the section's layout configuration.

## In the UI

1. Edit a layout (Layout Builder), then **Configure** a section (or add one and configure it).
2. In the section form you get an **Access** fieldset (`layout_builder_sections_access.module:35`):
   - **Disable this section in front end** (`disable_section`) — checkbox. If checked, the section is
     removed from the rendered page for everyone.
   - **Roles** (`visibility_roles`) — a multi-select of all site roles. Only users with **at least one**
     of the selected roles see the section. If none is selected, the section shows for all roles.
3. Save the section, then save the layout.

## Where the values live

The prepended submit handler `_layout_builder_sections_access_submit_form`
(`layout_builder_sections_access.module:75`) writes the fieldset values into the **layout plugin
configuration** of the section:

```php
$config = $formObject->getCurrentLayout()->getConfiguration();
$config['layout_builder_sections_access_config'] = $form_state->getValue('layout_builder_sections_access_config');
$formObject->getCurrentLayout()->setConfiguration($config);
```

So the values are part of `Section::getLayoutSettings()` (the layout plugin's `configuration`), **not**
the section's third-party settings. Shape:

```php
'layout_builder_sections_access_config' => [
  'disable_section'  => 0,          // 0|1
  'visibility_roles' => ['editor'], // array of role machine names; [] = all roles
],
```

At render, `hook_preprocess_layout` reads this from `$variables['settings']['layout_builder_sections_access_config']`
(the layout `settings` variable is the layout plugin configuration). There is **no config schema file**
in the module, so these keys are not separately typed/validated by config schema.

## Setting it programmatically on a Section

When you build sections in code (e.g. a default layout, an update hook, or a test), pass the config as
the layout plugin settings — the second `Section` constructor argument, exactly as the module's own test
does (`tests/src/Functional/SectionAccessTest.php:95`):

```php
use Drupal\layout_builder\Section;

$section = new Section('layout_onecol', [
  'layout_builder_sections_access_config' => [
    'disable_section'  => 0,
    'visibility_roles' => ['editor', 'premium'],
  ],
], $components);
```

To edit an existing section on a stored layout, mutate the layout settings and re-save:

```php
$settings = $section->getLayoutSettings();
$settings['layout_builder_sections_access_config']['disable_section'] = 1;
$section->setLayoutSettings($settings);
```

## Behavior notes

- **Role match is OR** — any one matching role grants the section.
- **Empty `visibility_roles`** (or the key absent) means no role restriction.
- **`disable_section` wins** — if set, content is removed regardless of roles.
- Only users who can reach the core section form (LB permissions `configure any layout` /
  `configure all layouts`) can set these options; the module adds no permission of its own.
