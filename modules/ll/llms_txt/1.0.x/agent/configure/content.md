# Configure — authoring the llms.txt content

Two content sources, combined in order by the `/llms.txt` controller: the **config body**
first, then published **section entities**.

## 1. The config body — `llms_txt.settings.content`

A single text value (schema type `text`) edited on the config form
`llms_txt.llms_txt_config` at **`/admin/content/llms-txt`** (permission
`administer llms.txt configuration`). It supports **tokens** (core tokens like `[site:name]`,
plus the module's `llms_txt_markdown_menu` tokens — see `api/endpoint-and-tokens.md`).

Shipped default (`config/install/llms_txt.settings.yml`):

```yaml
content: |
  # [site:name]

  [site:slogan]
```

Read / write:

```bash
drush cget llms_txt.settings content
```

```php
\Drupal::configFactory()->getEditable('llms_txt.settings')
  ->set('content', "# Acme Docs\n\nMachine-readable index for AI agents.\n")
  ->save();
```

## 2. Section entities — `llms_txt_section`

A **content entity** (base table `llms_txt_section`, `admin_permission`
`administer llms.txt configuration`) appended after the config body. Each **published**
section renders as `## <title>` + its Markdown body, ordered by `weight`.

Base fields:

| Field | Type | Notes |
|---|---|---|
| `title` | string (required) | becomes the `## ` heading |
| `content` | text_long | Markdown body (avoid HTML) |
| `weight` | (entity key) | ordering |
| `status` | published flag | only published sections appear in /llms.txt |

Managed at **`/admin/content/llms-txt/sections`** (collection), add at
`/admin/content/llms-txt/add-section`, edit/delete under
`/admin/content/llms-txt/sections/{id}/...`. A `system.action` for bulk-deleting sections ships
in `config/install`.

```php
// Create a published section programmatically.
\Drupal::entityTypeManager()->getStorage('llms_txt_section')->create([
  'title' => 'API Reference',
  'content' => ['value' => "- [Docs](/docs.md)\n", 'format' => 'plain_text'],
  'status' => 1,
  'weight' => 0,
])->save();
```

List published sections:

```bash
drush php:eval '$ids=\Drupal::entityTypeManager()->getStorage("llms_txt_section")->getQuery()->accessCheck(FALSE)->condition("status",1)->execute(); print implode(",",$ids);'
```

## Why two sources

Config body = generic, deployable via config management (stays in code). Section entities =
environment-specific content that lives in the database (so it does not clutter exported
config). The controller only includes sections the current user can `view` and whose `content`
field is viewable.
