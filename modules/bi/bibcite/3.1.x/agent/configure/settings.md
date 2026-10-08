<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibcite core settings & CSL styles

## Config object: `bibcite.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `processor` | string | `citeproc-php` | id of the `bibcite_processor` plugin used to render citations. |
| `default_style` | string | `apa` | id of the default `bibcite_csl_style` config entity. |
| `convert_urls` | boolean | `false` | linkify URLs found inside rendered citations. |

Settings form: `Drupal\bibcite\Form\SettingsForm`, route **`bibcite.settings`** at
`/admin/config/bibcite` ("Processing" tab), permission `administer bibcite`.

```bash
drush cget bibcite.settings
drush cset bibcite.settings default_style chicago_author_date -y
drush cset bibcite.settings processor citeproc-php -y
```

```php
\Drupal::configFactory()->getEditable('bibcite.settings')
  ->set('default_style', 'apa')->set('convert_urls', TRUE)->save();
```

## CSL style config entity: `bibcite_csl_style`

Each citation style is a `bibcite.bibcite_csl_style.<id>` config entity. Schema keys: `id`,
`label`, `csl` (the raw CSL XML), `parent`, `status`, `updated`, `custom` (bool — TRUE for
uploaded styles), `url_id`.

Shipped styles (config/install): `apa`, `chicago_author_date`, `modern_language_association`,
`modern_language_association_8th_edition`, `american_medical_association`.

Admin collection: `/admin/config/bibcite/settings/csl_style` (route
`entity.bibcite_csl_style.collection`). Action links let you **Add style** (paste CSL) or
**Install style from file** (upload a `.csl` from the CSL repository).

Create / manage in code:

```php
use Drupal\bibcite\Entity\CslStyle;
CslStyle::create([
  'id' => 'harvard_cite_them_right',
  'label' => 'Harvard',
  'csl' => file_get_contents('/path/to/harvard.csl'),
  'custom' => TRUE,
])->save();

// Read the raw CSL of a style:
CslStyle::load('apa')->getCslText();
```

To change the site's default style, set `bibcite.settings:default_style` to a style id that
exists. The `bibcite.citation_styler` service reads that default (see
[../api/citation-styler.md](../api/citation-styler.md)).
