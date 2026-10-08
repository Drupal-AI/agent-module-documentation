<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Bibcite content entities

## `bibcite_reference` — a bibliographic record

- Class `Drupal\bibcite_entity\Entity\Reference`. Revisionable + publishable. **Bundle** =
  `bibcite_reference_type` (book, journal_article, …).
- Key fields: `title`, `type` (bundle), `author` (contributor field), `keywords` (reference to
  `bibcite_keyword`), `bibcite_citekey`, and dozens of `bibcite_*` bibliographic fields
  (`bibcite_year`, `bibcite_publisher`, `bibcite_isbn`, `bibcite_doi`, `bibcite_pages`, …). The
  exact field set per bundle is declared in the reference type's `fields`.

```php
use Drupal\bibcite_entity\Entity\Reference;
$ref = Reference::create([
  'type' => 'book',
  'title' => 'The Structure of Scientific Revolutions',
  'bibcite_year' => 1962,
  'bibcite_publisher' => 'University of Chicago Press',
]);
$ref->save();
```

Storage: `ReferenceStorage` / `ReferenceStorageSchema` (custom table mapping). Access:
`ReferenceAccessControlHandler` (see permissions). A route subscriber and preview controller add
a live citation preview on the edit form.

## `bibcite_contributor` — authors / editors / organizations

- Class `Contributor`. Names are parsed into prefix/first/last/suffix (via bibcite core's
  `human_name_parser`); display name assembled from `contributor.settings:full_name_pattern`.
- `ContributorStorage`, `ContributorSelection` (entity-reference selection),
  `ContributorPropertiesService`.

## `bibcite_keyword` — subject keywords

- Class `Keyword`. Reusable tags referenced by references (`KeywordSelection` selection plugin).

## CSL normalization (format `csl`)

`CslReferenceNormalizer` (service `bibcite_entity.normalizer.reference`, priority 10, `setFormat('csl')`)
turns a Reference into CSL-JSON using `bibcite_entity.mapping.csl`. Feed that to
`bibcite.citation_styler->render()` to get a formatted citation. Contributor/Keyword normalizers
also registered.

## Bulk actions (config entities `system.action.bibcite_entity_*`)

Per entity type: **save**, **delete**, **merge** (contributor/keyword), and for references a
**regenerate citekey** action (`bibcite_entity_reference_regenerate_citekey`). These appear in the
Action dropdown / VBO on the admin listings.

## Views field handlers

`Plugin/views/field/Citation.php` (renders the citation) and `Links.php` (renders the
`bibcite_link` links), plus argument/filter handlers for contributor/keyword/reference ids.

> Note: creating `bibcite_reference` **content** requires the entity's field-storage tables to be
> installed. Reference/Contributor/Keyword *types and settings* are config and can be managed even
> where content storage is unavailable.
