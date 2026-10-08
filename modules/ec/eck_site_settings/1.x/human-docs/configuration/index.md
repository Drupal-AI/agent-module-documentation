# Configuration

Configuring ECK Site Settings is mostly about deciding *what* settings you want
and adding fields for them. The module creates a **Settings** entity type and a
**General** bundle for you on install, so there's nothing you *must* set before
you begin — you just add fields and fill them in.

## Add fields to the General bundle

1. Go to **Content → Site settings** (`/admin/content/site-settings`) to see your
   settings pages, and to ECK's admin pages (**Structure → ECK entity types**) to
   manage their structure.
2. On the **General** bundle of the **Settings** entity type, add the fields you
   want to expose as settings — a phone number, a text field for a banner, an
   image field for a logo, and so on — exactly as you would add fields to any
   entity bundle.
3. Arrange the fields on the bundle's **Manage form display** and **Manage
   display** as needed.
4. Editors then open the settings page for that bundle and fill in the values;
   there is a single settings entity per bundle, so the page behaves like a
   simple settings form.

## Create more bundles

If the General bundle starts to hold too many fields, or you want to group fields
onto separate pages, create additional bundles on the Settings entity type. Every
settings bundle is listed on the site settings overview page, each as its own
settings page.

## Create more settings entity types

To group bundles at a higher level, create additional ECK entity types and mark
each as a settings entity type by ticking **Use this entity type for site
settings** on the entity type create/edit page. Once you have more than one
settings entity type, the overview page and the admin menu group the bundles by
their entity type.

## Access control

The module defines one permission, **Access site settings overview**, which is
required to reach the overview page. Edit access to individual settings is
governed by the permissions ECK defines for each entity type. (Create, view and
delete permissions are hidden here because they are irrelevant for settings
entities.) If you'd rather control access per *bundle* than per entity type,
combine this with the
[ECK Bundle Permissions](https://www.drupal.org/project/eck_bundle_permissions)
module. Because a site setting affects every page, restrict editing to trusted
roles.

## Read settings in Twig

The module provides a Twig function, `site_settings()`, to load a settings entity
in any template. It takes the bundle name and, optionally, the entity type ID
(which defaults to `settings`, the entity type created on install):

```twig
{# Render a field as configured in the entity view display (needs Twig Tweak): #}
{{ site_settings('general').field_some_rich_text|view }}

{# Get the raw processed value of a field: #}
{{ site_settings('general').field_some_rich_text.processed }}
```

For file or image fields, the `file_uri`, `file_url` and `image_style` filters
from [Twig Tweak](https://www.drupal.org/project/twig_tweak) are handy:

```twig
{% set image_uri = site_settings('general').field_media_optional_image|file_uri %}
{% if image_uri is not null %}
  {{ image_uri|image_style('thumbnail') }}
{% endif %}
```

These Twig patterns aren't specific to this module — they apply to any entity in a
Twig context.

## Migrating from Site Settings and Labels

If you're moving from the Site Settings and Labels module, the module ships a
migration helper. Run it from a deploy hook (or another mechanism that runs during
deployment) **after** config has been imported:

```php
/**
 * Migrate site_settings to eck_site_settings.
 */
function my_module_deploy_8001(): void {
  \Drupal::getContainer()
    ->get('eck_site_settings.module_migration')
    ->fromSiteSettings();
}
```

It copies all bundles, fields, form/view displays and entity data automatically.
Run it locally first, then export and commit the resulting config changes before
deploying.
