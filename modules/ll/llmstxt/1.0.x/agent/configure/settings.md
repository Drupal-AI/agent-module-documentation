<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the llms.txt content

The entire file body is one config value. There is no per-content-type or per-node setting —
what you store is served verbatim (plus `hook_llmstxt()` additions; see
[../api/serving.md](../api/serving.md)).

## Settings form

- Route `llmstxt.settings` → `/admin/config/search/llmstxt` (menu link under *Configuration »
  Search and metadata*, title "llms.txt").
- Permission required: `administer llmstxt`.
- Form: `\Drupal\llmstxt\Form\LlmsTxtSettingsForm` (extends `ConfigFormBase`, form id
  `llmstxt_settings`).
- One field: `llmstxt_content` — a `textarea` (10 rows) whose value is saved to
  `llmstxt.settings:content`. On submit the form saves config **and** calls
  `Cache::invalidateTags(['llmstxt'])` so `/llms.txt` reflects the change immediately.

## Config object + schema

| Config | Key | Schema type | Install value |
|---|---|---|---|
| `llmstxt.settings` | `content` | `string` (label "Contents of llms.txt") | `''` |

Schema is `config_object` in `config/schema/llmstxt.schema.yml`. There are no other keys.

## Set it without the UI

Drush:

```bash
drush config:set llmstxt.settings content '# Example Site

> A short site summary.

## Docs
- [Getting started](https://example.com/docs)' -y
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('llmstxt.settings')
  ->set('content', "# Example Site\n\n> A short site summary.")
  ->save();
\Drupal\Core\Cache\Cache::invalidateTags(['llmstxt']);
```

(Editing config directly does not fire the form's tag invalidation — invalidate `llmstxt`
yourself, as above, or run `drush cr`.)

## Install-time default (`hook_install`)

On install, if `content` is still empty, `_llmstxt_get_default_content()` seeds it:

1. If `DRUPAL_ROOT/sites/default/default.llms.txt` exists and is readable, its contents are
   used verbatim. (Place your own file there before enabling the module to ship a canned
   default. Fixed path — not request-controlled.)
2. Otherwise a sample template is generated from public site data: `{site_name}` and
   `{site_slogan}` from `system.site`, plus the **`main` menu** rendered (max depth 2) as a
   nested Markdown link list via `_llmstxt_format_menu_item_markdown()` (link title →
   absolute URL). If the `main` menu is missing/empty, placeholder sample text is used.

This seed runs once at install only; it does not re-run and does not read nodes or any
access-restricted content — only the site name/slogan and menu-link titles/URLs.

## Runtime requirements (`hook_requirements`)

- **Clean URLs are mandatory.** If off, the module reports `REQUIREMENT_ERROR`. (The README's
  FAQ gives an `.htaccess` `RewriteRule ^(llms.txt)$ index.php?q=$1` workaround.)
- If a real `llms.txt` file exists in the docroot, the webserver serves that instead of the
  route; the module reports `REQUIREMENT_WARNING` telling you to remove it.
- With core Fast 404 enabled, add `llms.txt` to
  `$config['system.performance']['fast_404']['exclude_paths']` in `settings.php`.
