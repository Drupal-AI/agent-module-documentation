# Configure Domain Path

Requires the **domain** module and at least one Domain entity. Settings form:
route `entity.domain_path_settings` → `/admin/config/domain/domain_path`
(permission `administer domain paths`).

## Config object: `domain_path.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `entity_types` | sequence of strings | `[node]` | Entity types that get per-domain alias fields. |
| `alias_title` | string | `name` | How domains are labelled in the alias widget: `name` (domain name), `hostname`, or `url`. |
| `hide_path_alias_ui` | boolean | `true` | Hide core's default *URL alias* field on entity forms (avoids confusion with the per-domain fields). |
| `use_advanced_group` | boolean | `true` | Put the domain-path widget in the *advanced* vertical-tab sidebar (vs inline in the main form). |
| `language_method` | string | `language_content` | Language used to resolve aliases: `language_content` (entity language), `language_interface`, or `language_url`. |

Shipped defaults (config/install/domain_path.settings.yml):

```yaml
entity_types: [node]
alias_title: name
hide_path_alias_ui: true
use_advanced_group: true
language_method: language_content
```

Set in code:

```php
\Drupal::configFactory()->getEditable('domain_path.settings')
  ->set('entity_types', ['node', 'taxonomy_term'])
  ->set('alias_title', 'hostname')
  ->save();
```

Enabling an entity type here makes its base-field `domain_path` (a computed field) appear on
that type's edit form; disabling removes the per-domain alias fields.

## Integration toggles (behavior, not config keys)

- **Domain Access** (if enabled): editors only see/set aliases for domains they are assigned
  to; on save, aliases are only written for domains the entity belongs to; users with
  `administer url aliases` see all domains.
- **Domain Source** (if enabled): sets the target domain on outbound links so Domain Path
  resolves that domain's alias (processing order: Domain Source 310 → Domain Path 305 → core
  alias 300).
- **Pathauto**: install the `domain_path_pathauto` submodule for automatic per-domain aliases.

## Permission

`administer domain paths` (restricted) — gates the settings form.
