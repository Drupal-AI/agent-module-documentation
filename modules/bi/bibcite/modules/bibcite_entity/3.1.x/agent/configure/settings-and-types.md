<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & config entities

## `bibcite_entity.reference.settings` (config object)

| Key | Default | Meaning |
|---|---|---|
| `ui_override.enable_form_override` | `true` | Use the module's custom reference form builder. |
| `display_override.reference_page_view_mode` | `table` | View mode used to render the reference page. |
| `citekey.pattern` | `bibcite_[bibcite_reference:id]` | Token pattern for auto-generated citation keys. |

Configure form route: **`bibcite_entity.reference.settings`** (the module's `configure` route).

```bash
drush cget bibcite_entity.reference.settings
drush cset bibcite_entity.reference.settings citekey.pattern 'ref_[bibcite_reference:id]' -y
```

## `bibcite_entity.contributor.settings` (config object)

- `full_name_pattern` — default `@prefix @first_name @last_name @suffix`. Controls how a
  contributor's display name is assembled.

## `bibcite_reference_type` (config entity — the reference bundles)

`bibcite_entity.bibcite_reference_type.<id>`. ~40 shipped (book, journal_article, thesis, patent,
conference_paper, report, …). Schema keys: `id`, `label`, `description`, `new_revision`,
`override` (bool — override default field set), `preview_mode`, `citekey_pattern`, and a
`fields` sequence keyed by field name with `required` (bool), `label`, `hint`.

```php
use Drupal\bibcite_entity\Entity\ReferenceType;
ReferenceType::create(['id' => 'working_paper', 'label' => 'Working paper'])->save();
ReferenceType::load('book')->label();   // "Book"
```

## Contributor taxonomy config entities

- `bibcite_contributor_role` (`bibcite_entity.bibcite_contributor_role.<id>`): author,
  editor, translator, series_editor, … — `id`, `label`, `weight`.
- `bibcite_contributor_category` (`bibcite_entity.bibcite_contributor_category.<id>`): primary,
  secondary, corporate_institutional, …

```php
use Drupal\bibcite_entity\Entity\ContributorRole;
ContributorRole::create(['id' => 'reviewer', 'label' => 'Reviewer', 'weight' => 0])->save();
```

## CSL mapping — `bibcite_entity.mapping.csl`

A `bibcite_entity.mapping.<format>` config object maps a serialization format's field/type names
to Bibcite's. The `csl` mapping is what the `CslReferenceNormalizer` uses to turn a Reference into
CSL-JSON for citation rendering. The format submodules (bibtex/endnote/marc/ris) each ship their
own `bibcite_entity.mapping.<format>` (see those submodules).

## View modes

Ships `citation` and `table` view modes for `bibcite_reference`, plus optional view/form displays
per reference type and admin Views (`bibcite_reference_admin`, `bibcite_contributor`,
`bibcite_keyword`, …).
