<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invoke a compiler; contexts and inputs

To run a compiler you build a **context**, then ask the manager for the plugin and call
`compile()`.

```php
use Drupal\compiler\RefineableCompilerContext;
use Drupal\compiler\CompilerInputFile;
use Drupal\compiler\CompilerInputDirect;

$context = new RefineableCompilerContext(
  'uppercase',                              // compiler plugin id
  ['minify' => TRUE],                       // options (associative; string keys only)
  [new CompilerInputFile('/path/a.txt')],   // inputs (array of CompilerInputInterface)
  ['note' => 'run-1']                       // arbitrary user data
);
$context[] = new CompilerInputDirect('literal text'); // ArrayAccess append (refineable only)

$result = \Drupal::service('plugin.manager.compiler')
  ->createInstance($context->getCompiler())
  ->compile($context);
```

## Context classes

| Class | Mutable? | Notes |
|---|---|---|
| `CompilerContext` | no | Constructor sets compiler id, options, inputs, data. Options are filtered to string keys only. |
| `RefineableCompilerContext` | yes | Extends `CompilerContext`, implements `ArrayAccess` + `RefineableCompilerContextInterface`. Adds `setCompiler()`, `setData()`, `setOption()`, `setOptions()`, and `$ctx[$k]=$input` input editing. |

`CompilerContextInterface` getters:

- `getCompiler(): string` — the chosen compiler plugin id.
- `getOptions(): array` / `getOption(string $name)` — per-run options (missing → `NULL`).
- `getInputs(): \RecursiveCallbackFilterIterator` — a **copy** of the inputs at call time,
  flattened, yielding only `CompilerInputInterface` values (nested arrays are traversed).
- `getData()` — the arbitrary user data.

## Inputs

`CompilerInputInterface::get()` returns the raw value. Two shipped implementations
(both extend `CompilerInputBase`, constructed with the value):

- `CompilerInputFile($path)` — `get()` returns a file path (the compiler reads the file).
- `CompilerInputDirect($value)` — `get()` returns the value directly (no file I/O).

There is no behavioral difference in the base class; the two classes are **markers** so a
compiler can decide, per input, whether to treat `get()` as a path or a literal value.

## Iterating inputs

`getInputs()` returns a `RecursiveCallbackFilterIterator` over a `RecursiveArrayIterator`
(`CHILD_ARRAYS_ONLY`). The filter keeps an element if it `hasChildren()` (a nested array) or is
a `CompilerInputInterface`. So you can pass a nested inputs array and still iterate leaves:

```php
foreach ($context->getInputs() as $input) {
  $value = $input->get();
}
```

## Gotchas

- `getInputs()` returns a snapshot copy; mutate inputs via `RefineableCompilerContext`
  array access **before** calling it.
- Options with non-string (numeric) top-level keys are dropped by `CompilerContext`.
- The module ships no compiler plugins — `createInstance($id)` needs an id another module
  registered (e.g. `scss` from `compiler_scss`).
