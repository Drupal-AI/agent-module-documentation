<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invoke a compiler; inputs

To run a compiler you build one or more **input** value objects, ask the manager for the
plugin, and call `compile()` with the inputs as variadic arguments.

```php
use Drupal\compiler\CompilerInputFile;
use Drupal\compiler\CompilerInputSource;

$manager = \Drupal::service('plugin.manager.compiler');
$compiler = $manager->createInstance('uppercase'); // a CompilerPluginInterface

$result = $compiler->compile(
  new CompilerInputFile('/path/a.txt'),   // read from a file
  new CompilerInputSource('literal text'),// raw in-memory source
);
```

There is **no context, options, or data object** in 2.0 — inputs are passed directly and the
plugin returns the compiled result (any type). A compiler throws on error.

## Input classes

All inputs extend the abstract `Drupal\compiler\CompilerInput` (`@internal` base), which holds
a `public readonly string $value` and declares `abstract getSource(): string`. Two concrete,
`final`, `@api` implementations ship:

| Class | `getSource()` returns | Use for |
|---|---|---|
| `CompilerInputFile($path)` | `file_get_contents($this->value)` — the file's contents | a source file on disk |
| `CompilerInputSource($src)` | `$this->value` verbatim | a raw source string already in memory |

Both are constructed with a single string argument:

```php
$file   = new CompilerInputFile('/path/to/style.scss');
$source = new CompilerInputSource('.a { color: red; }');

$file->getSource();   // contents of /path/to/style.scss
$source->getSource(); // '.a { color: red; }'
$file->value;         // '/path/to/style.scss' (the raw stored value)
```

## Inside a compiler

A compiler iterates its variadic inputs and reads each with `getSource()` — it does not care
whether the bytes came from a file or a literal:

```php
public function compile(CompilerInput ...$inputs): mixed {
  foreach ($inputs as $input) {
    $bytes = $input->getSource();
    // ... transform $bytes ...
  }
}
```

## Gotchas

- `CompilerInputFile::getSource()` calls `file_get_contents()` with **no error handling** — a
  missing/unreadable path yields a PHP warning and `FALSE`. Ensure the path is valid before
  compiling.
- `value` is `readonly` — construct a new input object to change a path or source string.
- The module ships no compiler plugins — `createInstance($id)` needs an id another module
  registered.
- Migration from 1.x: `->get()` is now `->getSource()`; `CompilerInputDirect` is now
  `CompilerInputSource`; `CompilerContext`/`RefineableCompilerContext` and the options/data
  arrays are removed — pass inputs straight to `compile()`.
