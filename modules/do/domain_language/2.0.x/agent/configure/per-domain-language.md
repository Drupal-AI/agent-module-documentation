<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a domain's languages

## Install

```bash
composer require drupal/domain_language
drush en domain_language -y     # requires domain, domain_config, language
```

## The form

`/admin/config/domain/language/{domain}/edit` (`domain_language.admin`, permission
`administer domains`). Reach it from *Configuration → Domains* → the domain's **Languages**
operation.

| Field | Meaning |
|---|---|
| **Default language** (required select) | The domain's default language. The first option, *Site's default language (X)*, maps to the sentinel `***LANGUAGE_site_default***` and means "no override". Other options come from `languageManager()->getNativeLanguages()`. |
| **Languages allowed** (checkboxes) | The languages this domain offers. *If none are selected, all are available.* The chosen default is added automatically on save. |

Saving redirects back to `domain.admin` with a status message and rebuilds the router.

## What gets written

```yaml
# domain.config.{domain_id}.system.site
default_langcode: fr

# domain.language.{domain_id}.language.negotiation
languages:
  fr: fr
  de: de
```

`{domain_id}` is the domain entity's **original id** (`$domain->getOriginalId()`).

Deletion semantics matter when scripting:

- Default = *Site's default language* → `default_langcode` is unset; if the config object is then
  empty it is **deleted**.
- No checkboxes ticked → `domain.language.{domain}.language.negotiation` is **deleted**, which
  means "all languages allowed", not "none".
- The handler also removes `url.prefixes` and `url.domains` from
  `domain.config.{domain}.language.negotiation` (and deletes that object if it empties out), so a
  stale `domain_config` override cannot fight the module's own negotiation override.

## Doing it from the CLI

```bash
# Domain "example_com": default French, allow French + German.
drush cset domain.config.example_com.system.site default_langcode fr -y
drush cset domain.language.example_com.language.negotiation languages.fr fr -y
drush cset domain.language.example_com.language.negotiation languages.de de -y
drush cr

# Inspect what a domain currently allows.
drush cget domain.language.example_com.language.negotiation
drush cget domain.config.example_com.system.site default_langcode

# Back to "all languages / site default".
drush config:delete domain.language.example_com.language.negotiation -y
drush cdel domain.config.example_com.system.site default_langcode -y
```

Neither config object has a schema in this module (`provides_config_schema: false`), so
`drush config:import` of these keys works but schema validation tooling will report them as
untyped. Setting `languages` by hand: it is a map, so both key and value must be the langcode.

## Verifying the effect

```bash
# The language switcher on that domain should only list allowed languages.
curl -sI https://example.com/ | grep -i content-language

# Which default does the site think a domain has?
drush php:eval '$d = \Drupal::service("domain.negotiator")->getActiveDomain(); print $d ? $d->id() : "none";'
```

Remember overrides only apply for the **active domain of the request**, so CLI checks run outside
a domain context unless you pass `--uri=https://example.com`.
