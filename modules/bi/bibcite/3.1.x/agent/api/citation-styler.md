<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering citations: `bibcite.citation_styler`

Service id: **`bibcite.citation_styler`** (`Drupal\bibcite\CitationStyler`,
`CitationStylerInterface`). It renders a CSL data array/object to an HTML citation using the
configured processor and CSL style.

## Core methods

```php
$styler = \Drupal::service('bibcite.citation_styler');

// Render with the site default style + processor (from bibcite.settings):
$html = $styler->render($cslData);           // $cslData = CSL JSON array/stdClass

// Render with a specific style:
$styler->setStyleById('chicago_author_date');   // throws if the style id doesn't exist
$html = $styler->render($cslData);

// Or hand it a loaded CSL style entity:
$styler->setStyle(\Drupal\bibcite\Entity\CslStyle::load('apa'));

// Choose a processor explicitly:
$styler->setProcessorById('citeproc-php');

// Language of the rendered citation:
$styler->setLanguageCode('en');
```

Other accessors: `getStyle()`, `getProcessor()`, `getAvailableStyles()` (all
`bibcite_csl_style` entities), `getAvailableProcessors()` (all processor plugin definitions),
`getLanguageCode()`.

Internally `render()` calls `getStyle()->getCslText()` for the CSL XML and delegates to
`getProcessor()->render($data, $csl, $lang)`. If no style/processor is set explicitly it falls
back to `bibcite.settings:default_style` / `:processor`.

> The `$cslData` shape is CSL-JSON (the same structure `bibcite_entity`'s CSL normalizer emits
> from a Reference entity). Bibcite core does not itself produce that data from an entity — that
> is `bibcite_entity`'s `CslReferenceNormalizer` (format `csl`).

## Name parsing: `bibcite.human_name_parser`

`Drupal\bibcite\HumanNameParser` (wraps adci/full-name-parser) splits a full author name string
into prefix / first / last / suffix parts — used when normalizing contributor names.

## No Drush

Bibcite core adds no Drush commands. Configuration is via `bibcite.settings` and the
`bibcite_csl_style` collection (see [../configure/settings.md](../configure/settings.md)).
