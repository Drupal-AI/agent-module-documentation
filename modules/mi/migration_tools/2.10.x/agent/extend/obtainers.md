# Writing Obtainers / SourceParsers / Modifiers

Migration Tools' HTML-scraping framework. These are **plain PHP classes**, not Drupal plugins — you
reference them by class name from a migration's `dom_config`/`migration_tools` settings and run them via
`Operations::process()` (which the `dom` data parser calls per row).

## Obtainers — extract one field from messy HTML
Subclass `Drupal\migration_tools\Obtainer\ObtainHtml` (or a nearer base like `ObtainTitle`,
`ObtainDate`, `ObtainBody`). Override, as needed:
- `findX()` protected methods — locate the value via `$this->queryPath->find('.selector')`; call
  `$this->setElementToRemove($element)` to strip matched markup from the page after extraction; return
  the text/value.
- `cleanString($string)` (static) — normalise the raw match.
- `processString($string)` — post-process the cleaned value.
- `validateString($string)` — return whether the candidate is acceptable.

Reference stub: `src/Obtainer/Obtainer.api.php` (`ObtainExample`). Ships obtainers cover title, body,
subtitle, date (+ Spanish), id, city/state/country/location, image, image file, link, link file, table,
content type, plain-text-with-newlines — read the matching `Obtain*.php` before writing a new one.

## Jobs — queue obtainers per field
`Obtainer\Job` binds a destination `row_property` to an obtainer class and an ordered list of search
methods:
```php
$job = new Job('title', 'Drupal\\migration_tools\\Obtainer\\ObtainTitle');
$job->addSearch('findH1First');           // methods tried in order
$job->addSearch('pluckSelector', ['h2', 1]);
// Jobs are listed in the migration's dom_config.migration_tools settings; Operations runs them.
```
`Job::run(&$query_path)` instantiates the obtainer and runs each search until one validates. A
non-existent obtainer class raises a translated error.

## SourceParsers — orchestrate a page
`SourceParser\HtmlBase` (and `SourceParser\Node`) load the source HTML into QueryPath, apply Modifiers,
then run the field Jobs. Subclass `HtmlBase` for a site-specific parsing routine.

## Modifiers — mutate the source before extraction
`Modifier\DomModifier` and `Modifier\SourceModifierHtml` (extending `Modifier\Modifier` /
`Modifier\SourceModifier`) strip/rewrite markup (remove nav, fix tags) prior to obtaining. Configure the
modifier method list alongside the Jobs in the migration settings.

## Requirement
All of the above depend on the **QueryPath** library (enable the QueryPath module, or install
`technosophos/querypath` as a library). Without it the obtainer/parser classes cannot run.
