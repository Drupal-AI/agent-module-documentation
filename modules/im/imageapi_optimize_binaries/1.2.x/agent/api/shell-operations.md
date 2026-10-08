<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shell operations service + binary base class

## Service `imageapi_optimize_binaries.shell_operations`

Class `Drupal\imageapi_optimize_binaries\ShellOperations`, implementing
`ImageAPIOptimizeShellOperationsInterface`. Three methods:

```php
findExecutablePath($executable = NULL);   // absolute path on $PATH, or FALSE
execShellCommand($command, $options, $arguments); // run; $arguments are escaped, $options are NOT
saveCommandStdoutToFile($cmd, $dst);      // capture stdout to a file
```

`$options` are passed through unescaped (the caller pre-builds/escapes flag values);
`$arguments` (e.g. the file path) are escaped by the service. This is the single choke point
through which every binary processor shells out.

## Base class `ImageAPIOptimizeProcessorBinaryBase`

Abstract; extends `imageapi_optimize`'s `ConfigurableImageAPIOptimizeProcessorBase`. It:

- injects `file_system`, `image.factory`, and the `shell_operations` service;
- `defaultConfiguration()` → `['manual_executable_path' => '']`;
- `buildConfigurationForm()` — shows the auto-located path and (gated by the
  `configure imageapi_optimize_binary paths` permission) a **Manually set path** textfield;
- `getFullPathToBinary()` — returns `manual_executable_path` if set, else the auto-detected
  path, else nothing;
- helpers `findExecutablePath()`, `execShellCommand()`, `sanitizeFilename()` (→
  `fileSystem->realpath()`), `saveCommandStdoutToFile()`;
- declares two abstract methods a subclass must implement:
  `executableName()` (the binary name) and `applyToImage($image_uri)` (do the work).

## Write your own binary processor

```php
namespace Drupal\mymodule\Plugin\ImageAPIOptimizeProcessor;

use Drupal\imageapi_optimize_binaries\ImageAPIOptimizeProcessorBinaryBase;

/**
 * @ImageAPIOptimizeProcessor(
 *   id = "mytool",
 *   label = @Translation("My Tool"),
 *   description = @Translation("Optimizes images with mytool.")
 * )
 */
class MyTool extends ImageAPIOptimizeProcessorBinaryBase {
  protected function executableName() { return 'mytool'; }
  public function applyToImage($image_uri) {
    if ($cmd = $this->getFullPathToBinary()) {
      $dst = $this->sanitizeFilename($image_uri);
      return $this->execShellCommand($cmd, ['--optimize'], [$dst]);
    }
    return FALSE;
  }
}
```

Add per-setting form fields + a config-schema mapping `imageapi_optimize.processor.mytool` if
your processor has options.
