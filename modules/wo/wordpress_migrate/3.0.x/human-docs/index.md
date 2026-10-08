# WordPress Migrate Support — manual setup guide

**WordPress Migrate Support** (`wordpress_migrate`) imports a WordPress site into
Drupal. You give it a WordPress **WXR** export file (the XML file WordPress
produces from *Tools → Export*), and it generates a ready‑to‑run set of Migrate
configuration entities — for posts, pages, authors, categories, tags, comments,
and attachments — that you then run (and can roll back and re‑run) with the
Migrate Tools module. It saves you from hand‑writing migration YAML for a common
job.

You can drive it three ways: through a **guided UI wizard** (provided by the
`wordpress_migrate_ui` submodule), through a **Drush command**
(`wordpress_migrate:generate`), or **programmatically** via the generator
service. Options let you map WordPress posts and pages to specific Drupal content
types and text formats, import WordPress users (or assign everything to one
author), choose the taxonomy vocabularies for tags and categories, and pick an
image field for attachments and featured images.

The module has real dependencies that Composer installs for you:
[Migrate Plus](https://www.drupal.org/project/migrate_plus),
[Pathauto](https://www.drupal.org/project/pathauto),
[Ctools](https://www.drupal.org/project/ctools), and
[Migrate Tools](https://www.drupal.org/project/migrate_tools) (Migrate Tools is
what actually *runs* the generated migrations). It needs **PHP 8.2+** and works
on Drupal 10.5 and 11. **Note that version 3.0.x is an alpha release.** The base
module itself has no configuration form — the wizard lives in the
`wordpress_migrate_ui` submodule. It provides Drush commands but no permissions
of its own.

This guide is written for a **human** setting up an import. If you want terse,
token‑cheap references for an AI coding agent — including the generator service,
the generated migrations, and the logging system — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable it (and the wizard submodule).

## Where it lives in the admin menu

With the `wordpress_migrate_ui` submodule enabled, the import wizard is reached
from the Migrate Tools group list under **Structure → Migrations**
(`/admin/structure/migrate`), via an *Add import from WordPress* button
(`/admin/structure/migrate/wordpress_migrate`). The base module has no settings
page of its own.

## How to use it

The overall flow is: generate the migrations from your WXR file, then run them
with Migrate Tools.

1. **Export from WordPress** — in WordPress, use *Tools → Export* to produce a
   WXR (XML) file, and make it reachable from Drupal (for example upload it to
   the server, or a `private://` path).
2. **Generate the migrations** — either walk through the wizard, or run the Drush
   command, for example:

   ```bash
   drush wordpress_migrate:generate /var/data/my_wp_export.xml \
     --group-id=old_blog --prefix=blog_ \
     --tag-vocabulary=tags --category-vocabulary=wp_categories \
     --post-type=article --post-text-format=restricted_html \
     --page-type=page --page-text-format=full_html \
     --image-field=field_image
   ```

   This creates a migration group plus the individual migrations. A pre‑flight
   validator checks your configuration first and aborts on any error.
3. **Run the migrations with Migrate Tools:**

   ```bash
   drush migrate:import blog_wordpress_authors
   drush migrate:import blog_wordpress_attachments   # import media before posts
   drush migrate:import blog_wordpress_content_post
   drush migrate:status --group=old_blog
   drush migrate:rollback blog_wordpress_content_post   # if you need to redo
   ```

   Import attachments/media **before** content posts so featured‑image lookups
   resolve. Once the import is complete, the module does not need to stay
   enabled — you can uninstall it.

## A note on security and content review

Imported WordPress posts and comments can contain unsanitized markup or
JavaScript — review imported content, and choose the text format per bundle with
that in mind (the format you pick controls how that content is filtered on
output). Imported WordPress authors become **active** Drupal users, so review
them after import too (existing users matched by email are not overwritten). One
known limitation: inline image URLs inside post bodies are not rewritten.
