<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three Drupal.org link formatters

## Install & enable

```bash
composer require drupal/drupalorg_links
drush en drupalorg_links -y
```

No dependencies beyond Drupal core, no permissions, no Drush commands, no config to set up.

## The formatters

All three live in `src/Plugin/Field/FieldFormatter/`, extend core `FormatterBase`, and declare
`field_types = { "integer", "decimal", "string" }` — so they appear as a display option on core
integer, decimal and plain-text fields (not on link, reference or file fields).

| Class (file) | Plugin id | Label | URL produced |
|---|---|---|---|
| `DrupalUidLink.php` | `drupal_uid_link` | *Drupal.org user link* | `https://www.drupal.org/user/N` |
| `DrupalNidLink.php` | `drupal_nid_link` | *Drupal.org node link* | `https://www.drupal.org/node/N` |
| `DrupalCidLink.php` | `drupal_cid_link` | *Drupal.org comment link* | `https://www.drupal.org/comment/N` |

The three classes are identical except for the URL path segment (`user` / `node` / `comment`) and
the local variable name (`$uid` / `$nid` / `$cid`).

## How a value is rendered

Each `viewElements(FieldItemListInterface $items, $langcode)` does, per field item:

```php
if (!empty($item->value)) {
  $n = intval($item->value);          // decimal/string reduced to its integer part
  if (!empty($n)) {                    // zero / non-numeric → nothing rendered
    $element[$delta] = [
      '#type' => 'link',
      '#title' => '#' . $n,            // link text is "#123"
      '#url' => Url::fromUri('https://www.drupal.org/user/' . $n),  // path differs per formatter
    ];
  }
}
```

- The stored value is always `intval()`-cast before it is used, so `"42abc"` → `42` and `"3.9"` →
  `3`. A value that casts to `0` (empty, non-numeric, or literally zero) renders nothing.
- Output is a core `#type => 'link'` render element; the link title (`#N`) is an integer and the URL
  is a fixed `https://www.drupal.org/...` base plus that integer.
- Each class injects the `link_generator` service (`create()` / constructor), but the shipped
  `viewElements()` builds a render element instead of calling it — the injected service is unused.

## Enable one on a field

UI: *Structure → (entity type) → (bundle) → Manage display* → for an **integer / decimal / plain
text** field set the *Format* to **Drupal.org user link**, **Drupal.org node link** or **Drupal.org
comment link**. There is no gear/settings form — the formatter has no options.

Config / Drush equivalent (view display), e.g. a `field_dorg_uid` on the article default display:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_dorg_uid.type drupal_uid_link -y
drush cr
```

```yaml
# core.entity_view_display.node.article.default
content:
  field_dorg_uid:
    type: drupal_uid_link
    label: above
    settings: {}
```

Use `drupal_nid_link` or `drupal_cid_link` as the `type` for node or comment links.

## Notes

- No config schema ships for these formatters, but they have no settings to store, so strict
  config-schema tooling has nothing to flag beyond the empty `settings: {}`.
- Multi-value fields render one `#N` link per delta.
