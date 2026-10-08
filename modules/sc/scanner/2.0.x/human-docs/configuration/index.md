# Configuration

Before the search-and-replace tool will do anything, you need to tell Scanner
which fields it may touch, set the default match options editors start from, and
grant the right permissions. The settings live on a page *separate* from the tool
itself.

## Open the settings form

1. Log in as a user with the **Administer scanner settings** permission.
2. Go to **Configuration → Content authoring → Search and Replace Scanner**
   (`/admin/config/content/scanner`).

(The tool where you actually run searches is elsewhere, at **Content → Search and
Replace Scanner**, `/admin/content/scanner`.)

## Choose which fields can be scanned

This is the key step — until you enable a field here, the tool will not scan it.

1. Under **Content types to be searched**, tick each entity type and bundle you
   want to allow (for example *Article* nodes, a Paragraph type, or a Commerce
   product type).
2. Then tick the specific **fields** on those bundles that may be scanned. Only
   **text**, **string**, and **link** fields are offered.

Field references throughout the module use the form
`entity_type:bundle:field_name` (for example `node:article:body`).

## Default match options

These set the defaults that appear on the tool form; editors can still change them
per search.

- **Case sensitive** — whether searches are case-sensitive by default (on by
  default).
- **Match whole word** — only match whole words, so "cat" doesn't hit "category"
  (on by default).
- **Regular expression** — treat the search term as a regular expression by
  default (off by default).
- **Published only** — restrict searches to published content by default (off by
  default).
- **Maintain custom aliases** — Pathauto integration, kept off by default.
- **Language** — the default content language to search: *all* languages, or a
  specific one.
- **Word boundaries** — how word boundaries are matched at the database level:
  **auto** (let the module choose), **Spencer** (for MariaDB and MySQL up to
  8.0.3), or **ICU** (for MySQL 8.0.4 and newer). Leave this on *auto* unless you
  hit database-specific matching problems.

## Setting scannable fields with Drush

If you prefer configuration as code, the settings live in the
`scanner.admin_settings` config object. You can enable a field without the UI:

```php
\Drupal::configFactory()->getEditable('scanner.admin_settings')
  ->set('enabled_content_types', ['node:article' => 'node:article'])
  ->set('fields_of_selected_content_type', ['node:article:body' => 'node:article:body'])
  ->save();
```

## Grant the permissions

On **People → Permissions**, grant the appropriate one to each role. All three are
"restrict access" permissions — give them only to trusted roles.

- **Perform search only** — reach the tool and search, but *not* replace. Good for
  an auditor who needs to see where a term appears.
- **Perform search and replace** — full search, replace, and undo. **Important:**
  this bypasses normal entity edit access — a holder can rewrite fields even
  without edit permission on the entity itself, so grant it carefully.
- **Administer scanner settings** — configure the defaults and choose which fields
  are scannable (the settings form on this page).

For example:

```bash
drush role:perm:add editor 'perform search and replace'
drush role:perm:add auditor 'perform search only'
```
