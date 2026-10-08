<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sources, resources & the Dataset bundle

The Dataset entity's **bundle is its source plugin** (`bundle_plugin_type = data_pipelines_source`
in `src/Entity/Dataset.php`). Choosing a source at `/admin/content/datasets/add/{source}` picks
both the parser and the field that stores the input.

## Source plugins (`data_pipelines_source`)

- Attribute `#[DatasetSource]` (`src/Attribute/DatasetSource.php`); manager
  `Source\DatasetSourcePluginManager` (parent `default_plugin_manager`).
- Base `Source\DatasetSourceBase`: injects a **source resource** + logger; `getResource()` calls
  `$this->sourceResource->getResource($dataset, $fieldName)` and throws if not a stream;
  `buildFieldDefinitions()` returns the resource's storage field named
  `{baseId}_{source_resource_id}` (e.g. `csv_file`, `json_uri`, `csv_text`).
- Ships two, each **derived per resource** by `Plugin/DatasetSource/SourceDeriver.php` so you get
  `csv:file`, `csv:uri`, `csv:text`, `json:file`, `json:uri`, `json:text`:
  - `CsvSource` (`Plugin/DatasetSource/CsvSource.php`): `extractDataFromDataSet()` opens the
    resource, resolves the delimiter from the `csv_delimiter` list field
    (comma/semicolon/tab/pipe/colon), strips BOM (`NonPrintingCharsTrait::removeBom`) and DOS
    chars, treats the first row as the header, `array_combine`s each subsequent row, and `yield`s
    a `DatasetData`. Parse errors are logged `critical` and yield nothing.
  - `JsonSource` (`Plugin/DatasetSource/JsonSource.php`): `json_decode`s the whole stream; if a
    `{base}_path_to_data` **JSONPath** field is set, narrows to that node via
    `JsonPathTrait::createJsonPath()->find()` (softcreatr/jsonpath). A list yields one
    `DatasetData` per element; an object yields a single record. Adds a `*_path_to_data` string
    field validated by the `JsonPath` constraint.

## Source resources (`data_pipelines_source_resource`)

Services tagged `data_pipelines_source_resource`, collected by `SourceResourceManager` (the
service-id suffix after the last `.` becomes the resource id; must be alphanumeric). Interface
`Source\Resource\SourceResourceInterface`: `getResource()` returns a PHP stream, and
`getResourceBaseFieldDefinition()` returns the entity field that stores the input.

- **`File`** (`Source/Resource/File.php`) — a core **file** field (extension restricted to the
  source id, e.g. `csv`/`json`); `fopen($file->getFileUri(), 'r')`.
- **`Uri`** (`Source/Resource/Uri.php`) — a **link** field (`LINK_EXTERNAL`) holding a remote URL;
  `getResource()` does a Guzzle `GET`, stores the body in `cache.default` under
  `dataset:{machine_name}` for **86400s (24h)** with the dataset's cache tags, and returns it as a
  `php://temp` stream. `BadResponseException`/`GuzzleException` are caught and appended to the
  dataset log. Uses the site's default `@http_client` (default TLS verification).
- **`Text`** (`Source/Resource/Text.php`) — a `string_long` field; the pasted text is streamed
  through `php://temp`.

## DatasetData

`src/DatasetData.php` is an `ArrayObject`-style record passed through validation and transforms;
fields are accessed by name (`$record['field']`, `offsetExists`, `offsetGet`). It is also exposed
as a typed-data type `data_pipelines_data` (`Plugin/DataType/DatasetData.php`) so validation
constraints can run against it.

## Adding a source

Create a plugin extending `DatasetSourceBase` with `#[DatasetSource(id, label, deriver: ...)]`,
implement `extractDataFromDataSet()` (yield `DatasetData`) and, if you need extra storage fields,
override `buildFieldDefinitions()`. To reuse the file/uri/text derivation, set the
`SourceDeriver`. To add a brand-new input medium, register a service tagged
`data_pipelines_source_resource` implementing `SourceResourceInterface`.
