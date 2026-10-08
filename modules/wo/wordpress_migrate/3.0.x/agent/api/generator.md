# Generating WordPress migrations

## Programmatic API

```php
use Drupal\wordpress_migrate\WordPressMigrationGenerator;

$configuration = [
  'file_uri' => '/var/data/my_wp_export.xml', // stream wrapper or absolute path; must exist + be readable
  'base_url' => 'https://myoriginalblog.com',
  'group_id' => 'old_blog',        // migration_group id to create
  'prefix' => 'blog_',             // prefix for each migration id (defaults to "<group_id>_")
  'default_author' => 'editor',    // username to own all content; omit to import WP users (created active)
  'tag_vocabulary' => 'tags',
  'category_vocabulary' => 'wp_categories',
  'image_field' => 'field_image',  // enables the attachments migration + thumbnail lookup
  'post' => ['type' => 'article', 'text_format' => 'restricted_html'],
  'page' => ['type' => 'page', 'text_format' => 'full_html'],
];

$generator = \Drupal::service('wordpress_migration_generator_factory')->createGenerator();
$generator->createMigrations($configuration);
```

Service: `wordpress_migration_generator_factory` (`WordpressMigrationGeneratorFactory`) → `createGenerator()`
returns a `WordPressMigrationGenerator`. `createMigrations()` validates `file_uri`, refuses if the
`migration_group` already exists (use a unique `group_id` or a `prefix`), then writes the config
entities.

## Generated migrations

All keyed by `<prefix>` and grouped under `<group_id>`, sourced from the same WXR via migrate_plus
(`url` source, `xml` data parser, WordPress namespaces registered):

| Migration | Created when | Destination |
|---|---|---|
| `wordpress_authors` | no `default_author` | `entity:user` (active) |
| `wordpress_categories` | `category_vocabulary` set | `entity:taxonomy_term` |
| `wordpress_tags` | `tag_vocabulary` set | `entity:taxonomy_term` |
| `wordpress_content_post` | `post.type` set | `entity:node` |
| `wordpress_content_page` | `page.type` set | `entity:node` |
| `wordpress_comment` | always | `entity:comment` |
| `wordpress_attachments` | `image_field` set | `entity:file` (+ thumbnail `migration_lookup`) |

Optional attachment tuning keys: `attachment_replacement_domain`, `attachment_timeout`.

The base migration templates live in `migrations/wordpress_*.yml`; the generator clones and customizes
them (sets `migration_group`, author/vocabulary/default values, image field process).

## Running them

Generation only creates config — execute with **Migrate Tools**:

```bash
drush migrate:import <prefix>wordpress_authors
drush migrate:import <prefix>wordpress_content_post
drush migrate:status --group=<group_id>
drush migrate:rollback <prefix>wordpress_content_post
```

Import media/attachments before content posts so thumbnail lookups resolve. Inline image URLs in post
bodies are **not** rewritten (known limitation).
