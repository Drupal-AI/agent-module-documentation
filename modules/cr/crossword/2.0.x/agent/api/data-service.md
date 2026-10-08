<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data service, parsers & the `crossword_file_parser` plugin type

## `crossword.data_service` — `CrosswordDataService`

`src/CrosswordDataService.php` (interface `CrosswordDataServiceInterface`). Constructor args
(`crossword.services.yml`): `@cache.crossword`, `@crossword.manager.parser`, `@module_handler`,
`@logger.factory`. This is the canonical way to get structured puzzle data — prefer it over calling a
parser directly (it caches and runs the alter hook).

`getData(FileInterface $file, $redacted = FALSE)`:
1. Cache lookup in the **`crossword`** bin, keyed by `$file->id()`.
2. On miss, `parserManager->loadCrosswordFileParserFromInput($file)` then `$parser->parse()`; a
   `CrosswordException` is logged to the `crossword` channel and `NULL` is cached (so a bad file isn't
   re-parsed every request).
3. Post-processing independent of file type: `addReferences()` (parse clue text for cross-references
   like "12-Across", "34D", "Starred clues"), `addSquareMoves()` (precompute arrow-key targets, moving
   through black squares but stopping at edges), `convertCrosswordDataToUtf8()` (via
   `Masterminds\HTML5\Parser\UTF8Utils::convertToUTF8` after `mb_detect_encoding` over UTF-8 /
   Windows-1252 / ISO-8859-1 — fixes `json_encode` failures for `drupalSettings`), and
   **`filterXss()`** (`Xss::filter` on title, author, notepad, every fill and every clue text).
4. `moduleHandler->alter('crossword_data', $data, $file)` — the `hook_crossword_data_alter` extension
   point — then cache with the file's cache tags.
5. If `$redacted`, returns `redact()` (blanks every fill that has no `hint`, clears rebus).

Convenience getters (all cache through `getData`): `getAuthor`, `getTitle`, `getDimensionAcross`,
`getDimensionDown`, `getDimensions($delimiter='x')`, `getSolution($black='')` (2D array of fills),
`isRebus`. These back the tokens (crossword_token) and the dimension validator.

### Parsed data shape (see also `tests/files/test.json`)

```
[ 'id', 'title', 'author', 'notepad',
  'puzzle' => [ 'grid' => [[ square, … ], …], 'clues' => ['across'=>[clue…], 'down'=>[clue…]] ] ]
```
A **square**: `fill` (NULL = black square, else a letter/rebus string), `numeral`, `across`/`down`
`{index}`, `moves` (up/down/left/right target or NULL), `circle` (bool), `rebus` (bool), optional
`hint`, optional `image` (`{format, data(base64), width, height}`). A **clue**: `text`, `numeral`,
`references`.

## The `crossword_file_parser` plugin type

- Manager: `crossword.manager.parser` = `CrosswordFileParserManager` (extends `DefaultPluginManager`,
  directory `Plugin/crossword/crossword_file_parser`, interface
  `CrosswordFileParserPluginInterface`, annotation `@CrosswordFileParser` with `id` + `title`).
- Base class `CrosswordFileParserPluginBase` (ContainerFactoryPlugin): loads the file, checks
  `isApplicable()`, and reads `file_get_contents($file->getFileUri())` (trimmed) into `$this->contents`.
- Key manager methods: `filterApplicableDefinitions()` (first definition whose `class::isApplicable()`
  returns TRUE), `loadCrosswordFileParserFromInput()`, `getInstalledParsersOptionList()`,
  `loadDefinitionsFromOptionList()` (respects the field's `allowed_parsers`).
- Interface contract: `public static isApplicable(FileInterface): bool` (cheap structural test) and
  `parse(): array` (throws `CrosswordException` on structural problems so bad files fail validation).

### Bundled parsers (`src/Plugin/crossword/crossword_file_parser/`)

| id | title | `isApplicable()` test |
|---|---|---|
| `across_lite_text` | Across Lite Text | MIME `text/plain` + filename contains `.txt` + body contains `<ACROSS PUZZLE`. |
| `across_lite_puz` | Across Lite Puz | MIME `application/octet-stream` + filename contains `.puz` + bytes 2–12 == `ACROSS&DOWN`. |
| `crossword_compiler_xml` | Crossword Compiler XML | MIME `application/xml` + filename contains `.xml` + body contains `<crossword-compiler`. Parsed with `simplexml_load_string`. Embedded images are validated with `imagecreatefromstring` (a corrupt image throws `CrosswordException`). |
| `ipuz` | ipuz | MIME `application/octet-stream` + filename contains `.ipuz` + body contains `ipuz.org/v`. |

## Extending

- **Alter parsed data**: implement `hook_crossword_data_alter(array &$data, FileInterface $file)`
  (documented in `crossword.api.php`) — e.g. rewrite clue text or change the `moves` logic. Runs once
  per parse, before caching.
- **Support a new file format**: add a `@CrosswordFileParser` plugin under
  `src/Plugin/crossword/crossword_file_parser/` implementing `isApplicable()` + `parse()` (return the
  data shape above). No core changes needed; it appears automatically in the field's `allowed_parsers`
  list.
- **Custom filtering**: override the `crossword.data_service` service to loosen `filterXss()` if you
  need tags beyond the `Xss::filter` allowlist.
