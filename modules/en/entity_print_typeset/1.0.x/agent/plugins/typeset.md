<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `typeset` print-engine plugin

The module's entire code surface is one class:
`src/Plugin/EntityPrint/PrintEngine/Typeset.php` →
`Drupal\entity_print_typeset\Plugin\EntityPrint\PrintEngine\Typeset`, extending
`Drupal\entity_print\Plugin\EntityPrint\PrintEngine\PdfEngineBase`.

Annotation:

```
@PrintEngine(
  id = "typeset",
  label = @Translation("Typeset.sh"),
  export_type = "pdf"
)
```

So Entity Print discovers it as a PDF export engine named *Typeset.sh*.

## Install & enable

```bash
composer require drupal/entity_print_typeset
drush en entity_print_typeset -y
```

Depends on the `entity_print` module (declared in `entity_print_typeset.info.yml`).

### The paid typeset.sh library (required, not bundled)

The module ships **no** `composer.json` and does not pull the renderer automatically. typeset.sh is a
commercial pure-PHP HTML-to-PDF library requiring a valid subscription. Per the README you must add
its private Composer repository with your credentials and require it:

```bash
composer config repositories.typesetsh composer https://packages.typeset.sh
composer config -g http-basic.packages.typeset.sh "{PUBLIC_ID}" "{TOKEN}"
composer require typesetsh/typesetsh
```

Note a naming discrepancy in source: the README requires `typesetsh/typesetsh`, while the class
docblock shows `composer require "typesetsh/typeset.sh"`. Either way the PHP namespace consumed is
`Typesetsh\` (`Typesetsh\HtmlToPdf`, `Typesetsh\Result`). Credentials are stored by Composer in
`auth.json` / global http-basic config — the module itself stores no token, key or endpoint.

The engine only becomes selectable when the library is present:
`dependenciesAvailable()` returns `class_exists('Typesetsh\HtmlToPdf')`.

## Configuration

None in this module. It defines no config object, no schema, no settings form and no route. You
select the engine wherever Entity Print offers an engine choice (Entity Print's own settings form and
print links). `getPaperSizes()` returns a single size, `['a4' => 'A4']`.

## How HTML becomes a PDF (methods)

`PdfEngineBase` supplies the shared configuration/paper-size plumbing; this class implements the
render/output methods:

- `__construct()` — instantiates `new HtmlToPdf()` into `$this->htmlToPdf`.
- `addPage($content)` — calls `$this->htmlToPdf->render($content)` and stores the returned
  `Typesetsh\Result` in `$this->result`. (Rendering is a single call; there is no multi-page
  accumulation.)
- `send($filename, $force_download = TRUE)` — emits `Content-Type: application/pdf` and a
  `Content-Disposition` header (`attachment` when forcing download, else `inline`) using the caller's
  `$filename`, then `print $this->result->asString()`.
- `getBlob()` — returns `$this->result->asString()` (raw PDF bytes) for programmatic callers.
- `getPrintObject()` — returns the underlying `HtmlToPdf` instance.
- `create()` — a thin override that just calls `parent::create()`.

The HTML passed to `addPage()` is produced by Entity Print's own entity rendering pipeline; this
module does not build or fetch it. Rendering is fully in-process PHP — the module does **not** shell
out to any binary and makes no HTTP calls of its own.

## Operating notes

- Only A4 output is offered by this engine.
- The release is 1.0.0-alpha2 and self-described as between experimental and proof-of-concept; PDF
  access and which entities can be printed are governed entirely by Entity Print's own access checks.
