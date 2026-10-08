<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Serialization pipeline (encoders, normalizers, mappings)

Two serializer formats registered in `bibcite_crossref.services.yml` and declared as Bibcite
formats in `bibcite_crossref.bibcite_format.yml`:

| Format | Encoder | Purpose |
|---|---|---|
| `crossref` | `CrossrefEncoder` | Decode one Crossref work JSON into a flat mapped array. |
| `crossref_doi` | `CrossrefDoiEncoder` | Turn a newline-separated DOI list into decoded records (fetches each via the client). |

Both `.bibcite_format.yml` entries list the supported Crossref `types` (book, journal-article,
proceedings, dataset, report, …) and the `fields` that may appear.

## `CrossrefEncoder` (decode-only)

`src/Encoder/CrossrefEncoder.php`, service `bibcite_crossref.encoder.crossref`. `decode()`
json-decodes the response and walks `$json['message']`:

- `chair` → appended to `author` list with role `author`; `author` / `editor` / `translator` →
  appended with their own role (each as `['value' => …, 'role' => …]`).
- `subject` kept as-is; `ISSN` joined with `, `; `published-print` / `published-online` reduced to
  the first date-part (the year); `URL` pushed into a `link` list; `link` reduced to its `URL`s.
- `abstract` → `cleanJats()`: converts closing `</jats:p|sec|title|list-item>` to blank lines,
  strips all remaining `<jats:*>` tags, collapses blank runs, trims — so abstracts store as clean
  text, not literal markup.
- default: array values reduced to their first element, scalars passed through.

## `CrossrefDoiEncoder` (list import)

`src/Encoder/CrossrefDoiEncoder.php`, service `bibcite_crossref.encoder.crossref_doi`
(arg `@bibcite_crossref.client`). `decode()` splits input on `\R`, trims/filters, and for each DOI
calls `client->lookupDoiRaw($doi)` then `serializer->decode($record, 'crossref')`, appending each
result as its own import entry. On a fetch exception it logs a `bibcite_crossref` warning and emits
a marker entry keyed by `CrossrefDoiEncoder::FETCH_ERROR_KEY` (`__doi_fetch_error`) carrying the
DOI + message, so the failure is reported in the batch rather than lost. `encode()` (reverse) just
joins the `DOI` column with newlines.

## `CrossrefReferenceNormalizer`

`src/Normalizer/CrossrefReferenceNormalizer.php`, extends `ReferenceNormalizerBase`,
`setFormat(['crossref','crossref_doi'])`, properties `defaultType: other`, `contributorKey: author`,
`keywordKey: subject`. `denormalize()`:

- if the entry carries `FETCH_ERROR_KEY`, throws `UnexpectedValueException` (so the import batch
  records that DOI as failed);
- converts each Crossref contributor to a "Given Family" string (organizational authors use
  `name`; otherwise `Unknown`), remembering roles;
- delegates to the parent normalizer, then writes the remembered `role` onto each `author` field
  item. `normalize()` throws (export to Crossref is unsupported); `supportsNormalization()` is
  FALSE.

## `CrossrefContributorNormalizer`

`src/Normalizer/CrossrefContributorNormalizer.php`, extends `ContributorNormalizer`,
`format = crossref`, supports `ContributorInterface`. Maps a Crossref contributor to contributor
entity data: `family`/`given` → `last_name`/`first_name`, `affiliation[].name` joined into
`suffix`; an org author's `name` → `last_name`; empty/invalid → `Unknown`; a plain string name is
passed through for the parent's name parser.

## Field & type mapping

`config/install/bibcite_entity.mapping.crossref_doi.yml` (and the `crossref` mapping) map Crossref
types to Bibcite bundles (e.g. `journal-article` → `journal_article`, `book-chapter` →
`book_chapter`, `proceedings-article` → `conference_proceedings`, `other` → `miscellaneous`) and
Crossref fields to Bibcite fields (e.g. `title`→`title`, `subject`→`keywords`,
`abstract`→`bibcite_abst_e`, `published-*`→`bibcite_year`, `container-title`→`bibcite_secondary_title`,
`ISSN`→`bibcite_issn`, `DOI`→`bibcite_doi`). `update_10001` installs the `crossref_doi` mapping if a
site is missing it; `hook_uninstall` deletes both mappings.

## Request content type

`CrossrefSubscriber` (service `bibcite_crossref.crossref_subscriber`, `event_subscriber`) on
`KernelEvents::REQUEST` registers request format `crossref` for MIME
`application/x-crossref-refer`.
