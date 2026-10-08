<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Token — configuration objects & workflows

Config Token stores everything in two plain config objects. There is no entity type and no custom
storage — this is the whole point of the module (contrast `token_custom`, which uses a content entity).
Both objects are simple config with typed schema, so they export to `config/sync` and import cleanly.

## `config_token.settings` — token definitions

Schema: `config/schema/config_token.settings.schema.yml`.

```yaml
allowed_tokens:
  <machine_name>:
    name: 'Human label'          # shown in token_info and the value form
    description: 'What it is'     # shown in token_info
    format_id: plain_text        # text-format machine name, or '' for raw value
```

- `<machine_name>` must match `^[a-z0-9_-]+$` (enforced by `AllowedConfigTokensForm::validateForm()`).
  It becomes `[config_token:<machine_name>]`.
- `format_id` is a text-format id (e.g. `plain_text`, `basic_html`, `full_html`) **or** an empty string
  meaning "None (raw value)". A missing `format_id` key defaults to `plain_text` at render time.

## `config_token.tokens` — token values

Schema: `config/schema/config_token.schema.yml`.

```yaml
replacements:
  <machine_name>: 'The value'
```

- Keyed by the same machine name. A value whose key is not in `allowed_tokens` is an "orphan": it is not
  rendered, and the value form surfaces a warning rather than dropping it.
- The definitions and values are deliberately split across two objects so a workflow can deploy the *set*
  of tokens and their *values* independently (e.g. define once, override values per environment/domain).

## Install defaults

`config/install/config_token.settings.yml` and `config/install/config_token.tokens.yml` seed three
example tokens on enable (`example_email`, `example_phone`, `example_link`). Remove them if unwanted.

## Bulk / CLI workflow (no UI)

The forms are convenient but not required; you can drive the config directly:

```bash
# Inspect
drush cget config_token.settings
drush cget config_token.tokens

# Set a definition and value (single keys)
drush cset config_token.settings allowed_tokens.support_phone.name 'Support phone'
drush cset config_token.settings allowed_tokens.support_phone.format_id ''      # raw value
drush cset config_token.tokens replacements.support_phone '+44 20 7000 0000'

# Clear the token cache so hook_token_info() picks up new definitions
drush php:eval 'token_clear_cache();'
```

For many tokens at once, edit the two YAML files and `drush cim`, or use the CSV to Config module (the
maintainer's suggested bulk approach). Editing definitions through the UI calls `token_clear_cache()`
for you; direct config writes do not, so clear it yourself.

## Per-environment / per-domain overrides

Because both are ordinary config, standard override mechanisms apply:

- `settings.php`: `$config['config_token.tokens']['replacements']['support_phone'] = '...';`
- Config Override / Config Split for environment-specific values.
- Domain module: create `domain.config.<domain_alias>.config_token.tokens.yml` to vary values per domain.
  `hook_tokens()` adds both config objects as cache dependencies, so whatever cacheability an override
  contributes (e.g. a domain/url cache context) bubbles to everything embedding the token.

## What this is NOT

This module does not read `[token]` patterns out of *other* modules' config and replace them. It only
publishes `config_token:*` tokens for the Token API. To actually substitute one inside text you still
need a consumer: Token Filter on a text format, a token-enabled module setting, or
`\Drupal::token()->replace()`.
