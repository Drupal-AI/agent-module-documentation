<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PubMed client & serializer formats

## Service `bibcite_pubmed.client`
`Drupal\bibcite_pubmed\PubmedClient` implements `PubmedClientInterface`. Constructed with
`@http_client` (Guzzle `ClientInterface`). Single method:

- `fetch($pmid)` — accepts an int/string PMID or an array of PMIDs (arrays are `implode(',')`-joined).
  Issues `GET` to `PubmedClient::URL` = `https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi`
  with query `db=pubmed`, `id=<pmid(s)>`, `retmode=xml`. Returns the raw response body (efetch XML
  string). The base URL is a fixed HTTPS constant; only the `id` value comes from the caller.

Reuse it in custom code: `\Drupal::service('bibcite_pubmed.client')->fetch('12345678')`.

## Format `pubmed` — `PubmedEncoder`
`Drupal\bibcite_pubmed\Encoder\PubmedEncoder` (tag `encoder`, format `pubmed`); decode-only
(`DecoderInterface`).

- `decode($data, 'pubmed')` — parses the efetch XML with `new SimpleXMLElement($data)`, requires at
  least one `<PubmedArticle>` (else throws `NotEncodableValueException`), and returns an array of
  per-article value arrays via `getValues()`.
- `getValues()` extracts: `ArticleTitle`, `PublicationType`, `AuthorList` (each `{name, category}`,
  where category is `corporate_institutional` for `CollectiveName` else `primary`), `KeywordList`,
  `Abstract` (AbstractText sections wrapped in `<p>`, labelled sections prefixed with `<b>Label: </b>`),
  `Year` (PubDate/Year → MedlineDate → ArticleDate/Year fallback), `JournalTitle`, `Volume`, `Issue`,
  `Pagination`, `PubDate` (MM/YYYY), `Language`, `ISSN`, `doi` (from ELocationID matching `10.…/`),
  `ISOAbbreviation`, `PMCID` (ArticleId with IdType `pmc`), `PMID`, and a derived
  `url` = `https://www.ncbi.nlm.nih.gov/pubmed/{PMID}`.

## Format `pubmed_id` — `PubmedIdEncoder`
`Drupal\bibcite_pubmed\Encoder\PubmedIdEncoder` (tag `encoder`, format `pubmed_id`); both decode and
encode. Constructor arg `@bibcite_pubmed.client`.

- `decode($data, 'pubmed_id')` — splits the input on newlines into PMIDs, `array_chunk`s them into
  groups of 50, calls `client->fetch($chunk)` per chunk, and merges each chunk decoded via the
  `pubmed` format. This is the bulk-import path.
- `encode($data, 'pubmed_id')` — `array_column($data, 'PMID')` joined by newlines (value arrays → PMID
  list).

## Normalizer `PubmedReferenceNormalizer`
Extends `bibcite_entity\Normalizer\ReferenceNormalizerBase`, priority 5, bound to formats
`pubmed`/`pubmed_id` via `setFormat`. Service properties set the mapping keys: `typeKey=PublicationType`,
`defaultType='Journal Article'`, `contributorKey=AuthorList`, `keywordKey=KeywordList`.
`denormalize()` pulls contributor `name`/`category` columns out of the value array, lets the base class
build the Reference, then re-applies each author's `category` property on the entity's `author` field.

## Request format
`PubmedSubscriber::onKernelRequest` calls `$request->setFormat('xml', ['application/x-pubmed-refer'])`
on every kernel request, registering that MIME type as the `xml` format.
