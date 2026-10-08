<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# butils service — trait map

Access everything through `\Drupal::service('butils')` (or type-hint `Drupal\butils\BUtils`).

Grouped helpers (by trait):
- **ArrayTrait** `arrayMap($arr,'key.subkey')`
- **CsvTrait** `loadCsv()`, `writeCsv()`
- **DatetimeTrait** `strToStamp()`, `strToDate()`, `dateToStamp()`, `dateToFormat()`
- **EntityTrait** `toEntity()`, `deref($entity,'field.0.subfield')`, `getViewModes()`, `entityBuild()`, `entityRender()`, `entityCountWords()`
- **FieldTrait** `getFieldDefinitions()`, `getFieldDefinitionsDetails()`, `emptyField()`, `viewField()`, `renderField()`, `getFieldValueByIds()`
- **HtmlTrait / DomDocumentTrait / TruncateHTML** HTML/DOM helpers, `domNodeInnerHtml()`
- **MediaTrait, ImageStyleTrait, FileTrait, UriTrait** file/media/url helpers
- **TaxonomyTrait, ParagraphsTrait, MenuTrait, ViewsTrait, RedirectsTrait, StateTrait, UserTrait, StringTrait, JsonTrait/JsonApiTrait, XmlTrait, SqlQueryTrait** domain helpers

Also: `butils.twig_extension` exposes helpers to Twig; `json_metadata` field stores arbitrary
JSON with a preview widget/formatter; node insert/update invoke a `node_save` hook for reuse.