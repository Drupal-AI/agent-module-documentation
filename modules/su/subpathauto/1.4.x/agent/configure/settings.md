<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Sub-pathauto

## The config object

```yaml
# subpathauto.settings  (config/install default)
depth: 0
redirect_support: true
```

Schema (`config/schema/subpathauto.schema.yml`), type `config_object`:

| Key | Type | Meaning |
|---|---|---|
| `depth` | integer | How many trailing path segments to try when looking for a parent alias. |
| `redirect_support` | boolean | When TRUE **and** the `redirect` module is installed, resolve redirects on the parent path before alias lookup. |

**`depth` semantics (important, and the form label is misleading):**

- `PathProcessor::getMaxDepth()` returns `subpathauto.settings:depth` verbatim.
- The loop condition is `$max_depth === 0 || $i < $max_depth`, so **`0` = unlimited**.
- The settings form renders the option list as `[0 => 'Disabled'] + range(1, 8)`
  (`MenuTreeStorage::MAX_DEPTH - 1` = 8), i.e. it *calls* 0 "Disabled" while the processor
  treats it as no limit.
- If the config object does not exist (or `depth` is NULL) the strict `=== 0` fails and
  `$i < NULL` is false, so **no sub-path is ever processed** — that is the real "off" state.
  Deleting `subpathauto.settings` therefore disables the module's behaviour.

`subpathauto_update_8001()` sets `redirect_support` to FALSE on existing sites so their
behaviour does not change on upgrade; new installs get TRUE from `config/install`.

## Settings form

| | |
|---|---|
| Route | `subpathauto.admin_settings` (the module's `configure` route) |
| Path | `/admin/config/search/subpathauto` |
| Menu | *Configuration → Search and metadata → Sub-path settings* |
| Permission | `administer url aliases` (core, from the path module) |
| Form class | `Drupal\subpathauto\Form\SettingsForm` |

The **Support for redirects** checkbox is disabled (and forced to FALSE) when the `redirect`
module is not installed.

## Set it from the command line

```bash
drush cget subpathauto.settings                       # read both values
drush cset subpathauto.settings depth 3 -y            # try up to 3 trailing segments
drush cset subpathauto.settings redirect_support 1 -y # requires drupal/redirect
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('subpathauto.settings')
  ->set('depth', 3)
  ->set('redirect_support', TRUE)
  ->save();
```

Saving the object fires `subpathauto.config_cache_invalidator`
(`Drupal\subpathauto\EventSubscriber\ConfigCacheInvalidator`, `ConfigEvents::SAVE`), which
invalidates the **`rendered`** cache tag — every cached page is discarded, because outbound
URL generation may now differ. Expect a cold cache after each change.

## Choosing a value

- `1` covers the common case (`/alias/edit`, `/alias/delete`).
- Higher values cover deeper routes (`/alias/webform/results/download`) at the cost of one
  extra alias lookup per level on every unmatched request.
- `0` (unlimited) is the shipped default and is fine on small sites.
