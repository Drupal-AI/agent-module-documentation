<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending: writing a benchmark scenario

Source: `src/Benchmark/BenchmarkScenarioInterface.php`, `BenchmarkRunner.php`, `BenchmarkResult.php`,
`BenchmarkRunResult.php`, `BenchmarkSkipException.php`, `Examples/UserRoleFilterExampleBenchmark.php`,
`code_benchmarker.services.yml`.

## The contract — `BenchmarkScenarioInterface`

A scenario is ONE comparison of two-or-more equivalent implementations. Implement:

| Method | Returns | Role |
|---|---|---|
| `id()` | `string` | Stable lowercase dot-separated machine name; appears in the URL. |
| `label()` | `string\|\Stringable` | Title above the table (use `TranslatableMarkup`/`t()`). |
| `description()` | `string\|\Stringable` | Multi-paragraph text; template runs `nl2br`, so return plain text, not HTML. |
| `prepare()` | `mixed` | Called once. Load fixtures/ids; return a context passed to `reset()` and every implementation. Throw `BenchmarkSkipException($reason)` to skip. |
| `reset(mixed $context)` | `void` | Clear every cache/static the implementation warms, so iter 1 is cold. |
| `implementations()` | `array<string, callable(mixed):mixed>` | Label → closure, invoked as `$impl($context)` each iteration. Order preserved; baseline first. |

The **last iteration's return value** of each implementation is captured and compared strictly
(`===`) across implementations for the dashboard's "Same return value?" check — return a scalar
(count/hash) that should be identical across implementations to catch silent semantic drift.

## Registering it

Register the class as a service tagged `code_benchmarker.scenario`. With `_defaults: { autowire:
true, autoconfigure: true }` in your module's `services.yml`, dependencies autowire by typehint:

```yaml
services:
  Drupal\my_module\Benchmark\MyBenchmark:
    arguments: ['@entity_type.manager']
    tags:
      - { name: code_benchmarker.scenario }
```

Then `drush cr`. No plugin manager, no config, no UI registration. The controller receives all
tagged services via `!tagged_iterator code_benchmarker.scenario` and dedups by `id()`.

## Runner methodology — `BenchmarkRunner::run()`

1. `prepare()` runs once; a `BenchmarkSkipException` short-circuits to `BenchmarkRunResult::skipped()`.
2. For each implementation, in declaration order, `time()` does:
   - **Warm-up**: `reset()` then one **untimed** call (primes OPcache, class loading, lazy DI).
   - **Pre-iter-1 reset**: `reset()` runs **once more** so iteration 1 pays real cold-cache cost.
   - **Timed loop** of N iterations with **no reset between them** — so any cache an implementation
     populates in iter 1 benefits iters 2..N. That's deliberate: a caching optimized impl's
     cumulative win shows in avg/median/total; a cacheless legacy impl stays flat. The gap is the point.
   - Each sample = `hrtime(TRUE)` delta / 1e6 (ms). Samples sorted; computes iterations, avg, median,
     min, max, population stddev, total, plus `lastResult`.
   - Guard: `$iters < 1` returns a zeroed `BenchmarkResult` (run() is public API reachable outside
     the clamped dashboard).

## Result DTOs

- `BenchmarkResult` — `final readonly`, one per implementation: `label, iterations, avgMs, medianMs,
  minMs, maxMs, stddevMs, totalMs, lastResult`.
- `BenchmarkRunResult` — `final readonly`; private ctor, named constructors `::ran(array $results)`
  and `::skipped(string|\Stringable $reason)`; callers check `$skipped` (replaces the older
  "empty array means skipped" shape).
- `BenchmarkSkipException` extends `\RuntimeException`; `getReason()` preserves a `TranslatableMarkup`
  (prefer over `getMessage()`, which is the construction-time string cast).

## Bundled example

`Examples\UserRoleFilterExampleBenchmark` (registered in `services.yml`, injected `@entity_type.manager`)
counts users holding a role: LEGACY loads every user with `loadMultiple()` and filters `getRoles()`
in PHP; OPTIMIZED pushes the `roles` condition into the entity query and asks for a `COUNT`.
`prepare()` auto-selects the first non-built-in role with members (else skips). Both paths use
`accessCheck(FALSE)` — justified in-code as an admin-only dev tool counting rows regardless of
per-user view access. Neither caches, so it isolates raw SQL-vs-PHP filtering cost.
