<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Choosing a block title's HTML element

## Install & enable

```bash
composer require drupal/block_title_html_element
drush en block_title_html_element -y
```

Only dependency is core **`block`**. No sub-modules, no Drush commands, no routes, no config forms.

Grant the permission **`administer block title element`** (machine string; label *"Administer block
title element"*, defined in `block_title_html_element.permissions.yml`) to the roles that should be
allowed to set the element. Without it, the extra section does not appear on the block form
(`hook_form_block_form_alter` returns early).

## The one required theme change

The module only **provides a Twig variable**; it does not change block markup by itself. Your theme's
`block.html.twig` must render the title with that variable. Copy `examples/block.html.twig` into your
theme's `templates/block/block.html.twig` (or edit your existing one), then `drush cr`. The relevant
lines:

```twig
{% if label %}
  <{{ title_element | default('strong') }}{{ title_attributes.addClass('block-title') }}>
    {{ label }}
  </{{ title_element | default('strong') }}>
{% endif %}
```

`title_element` is supplied by `hook_preprocess_block`; `| default('strong')` covers any block
that never went through the preprocess (belt-and-suspenders).

## Setting it on a block (UI)

1. *Administration → Structure → Block layout*.
2. **Configure** the desired block.
3. Open **Block Title HTML Element** (a `details` group; open automatically when a value is set).
4. Pick from the **HTML Element** dropdown; `- Default (strong) -` means "no wrapper override".
5. Save.

The value is stored as a **block third-party setting** under key
`block_title_html_element.title_element`, e.g. in `block.block.<id>.yml`:

```yaml
third_party_settings:
  block_title_html_element:
    title_element: h2
```

Config schema for it: `block.block.*.third_party.block_title_html_element` →
`title_element` (type `string`, `Length max: 10`).

## The allowed element list

From `ElementValidator::getAllowedElements()` (`src/Service/ElementValidator.php`):

| Value | Label |
|---|---|
| `h2` | Heading 2 (h2) |
| `h3` | Heading 3 (h3) |
| `h4` | Heading 4 (h4) |
| `h5` | Heading 5 (h5) |
| `h6` | Heading 6 (h6) |
| `span` | Span |
| `p` | Paragraph (p) |
| `em` | Emphasis (em) |
| `b` | Bold (b) |
| `i` | Italic (i) |

`h1` is deliberately not offered (document-hierarchy / SEO). The default when nothing is chosen is
`strong` (that word is not itself in the list — it is the fallback baked into preprocess and the
Twig `default`).

## Validation flow (three enforcement points)

`ElementValidator::validateElement($element)` = `in_array($element, array_keys(getAllowedElements()),
TRUE)` — a strict allowlist membership test. It runs at:

1. **Form submit** — `block_title_html_element_block_form_validate` sets a form error on any
   non-empty value that is not in the allowlist.
2. **Entity presave** — `block_title_html_element_block_presave` unsets a blank value; unsets an
   invalid one (falls back to default) and shows a warning message.
3. **Render** — `block_title_html_element_preprocess_block` only assigns
   `$variables['title_element']` when the stored value validates, else uses `strong`.

So the tag exposed to Twig is always a member of the allowlist (or `strong`).

## Extending the allowed elements

Implement the alter hook to add tags to the dropdown and allowlist:

```php
/**
 * Implements hook_block_title_html_element_allowed_elements_alter().
 */
function mymodule_block_title_html_element_allowed_elements_alter(array &$elements) {
  $elements['article'] = t('Article');
}
```

Anything you add here is treated as allowed by all three validation points above and by the schema's
`Length max: 10`, so keep additions to plain semantic tag names.
