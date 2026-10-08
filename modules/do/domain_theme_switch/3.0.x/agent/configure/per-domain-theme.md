<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting a theme per domain

## Install

```bash
composer require drupal/domain_theme_switch
drush en domain_theme_switch -y     # requires domain + domain_config
```

If `domain_config` is missing, `drush updatedb` refuses to run with
*"Domain Theme Switch 3.x requires the Domain Configuration module"*.

## The form

`/admin/config/domain/domain_theme_switch/config` — one fieldset per domain:

| Element | Name | Meaning |
|---|---|---|
| Enable theme override | `{domain_id}_override` | Checkbox. Unchecked = domain inherits the site theme |
| Site theme for domain | `{domain_id}_site` | Select over installed themes; default = current override or site `system.theme:default` |
| Admin theme for domain | `{domain_id}_admin` | Select over installed themes; default = current override or site `system.theme:admin` |

Both selects are `#states`-hidden until the checkbox is ticked. Only **installed** themes appear
(`theme_handler->listInfo()`), so install the theme first:

```bash
drush theme:enable olivero_brand_b -y
```

## Where the values live

Not in `domain_theme_switch.settings` (3.x deletes that object). They are per-domain overrides of
core's `system.theme`, stored in the config collection `domain_config` manages:

```bash
# List override collections and read one domain's theme override.
drush php:eval '
$f = \Drupal::service("domain.config_factory_override");
$s = $f->getStorage("example_com");
var_dump($s->exists("system.theme"), $s->read("system.theme"));
'
```

Write one without the UI:

```bash
drush php:eval '
\Drupal::service("domain.config_factory_override")
  ->getOverrideEditable("example_com", "system.theme")
  ->set("default", "olivero_brand_b")
  ->set("admin", "claro")
  ->save();
'
drush cr
```

Remove the override (back to the site default):

```bash
drush php:eval '
\Drupal::service("domain.config_factory_override")
  ->getOverride("example_com", "system.theme")
  ->delete();
'
drush cr
```

## The empty-row gotcha

`domain_config` 3.x stores overrides as a **diff against the baseline**. If you pick exactly the
themes the site already uses, the diff is empty and the row is written as `{}`. That row is still
semantically "override enabled" — the module deliberately checks
`StorageInterface::exists('system.theme')` rather than inspecting the values, in both
`buildForm()` and `submitForm()`.

Consequences when scripting:

- Testing `if (!empty($storage->read('system.theme')))` gives the **wrong** answer for a
  baseline-equal override. Use `exists()`.
- Deleting the row — not blanking it — is what disables the override.

## Verify the switch works

```bash
# Which theme does a request to that domain get?
curl -s -H 'Host: example.com' https://module-documentor.ddev.site/ | grep -o 'themes/[^/]*/[^"]*css' | head -3

# Or from PHP with the domain negotiated:
drush --uri=https://example.com php:eval 'print \Drupal::config("system.theme")->get("default");'
```

Remember overrides only apply when a domain is the **active** domain for the request, so CLI
checks need `--uri`.

## Upgrading from 2.x

1. `drush updatedb` runs `domain_theme_switch_update_10001()`, which reads the old
   `{domain}_site` / `{domain}_admin` keys out of `domain_theme_switch.settings`, writes them as
   overrides, logs one notice per migrated domain, then **deletes** the old config object.
   Domains missing either key are skipped.
2. `domain_theme_switch_update_10002()` revokes the obsolete `domain administration theme`
   permission (defined by 2.x's theme negotiator, gone in 3.x) from every role, so role saves and
   config imports stop warning about a non-existent permission.

Both are idempotent enough to re-run: the first finds no old config, the second no roles.
