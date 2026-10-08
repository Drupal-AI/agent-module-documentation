Data Structures is a developer-only utility module that provides Drush code generators plus ready-to-use typed sequence and set classes so custom code can replace loosely-typed PHP arrays with type-safe objects.

---

The module has no UI, routes, permissions, configuration, or entities — it is a code library plus two `drush generate` generators, aimed at module developers. The generators (`data-structures:map` and `data-structures:typed-sequence`) interactively scaffold value-map classes (public or `readonly` properties) and typed immutable sequence classes into a chosen module. The shipped library, all under `Drupal\data_structures\DataStructure`, includes five immutable typed sequences — `CallableImmutableSequence`, `FloatImmutableSequence`, `IntImmutableSequence`, `ObjectImmutableSequence`, `StringImmutableSequence` — each of which validates every element's type on construction, refuses in-place mutation through `ArrayAccess`, and offers `map()`/`reduce()`/`filter()` (string/float variants add `filterContains()`/`filterBegins()`). It also ships `Set`/`SetInterface`, a collection guaranteeing member uniqueness with `union()`, `intersect()`, `difference()`, `symDifference()`, `map()`, `reduce()`, `filter()`, plus an `EqualityInterface` that lets objects define their own equality (via `hash()`/`equalTo()`) for set membership. Requires PHP 8.3+ and Drush 13+.

---

- Scaffold a typed value-object to replace an associative array with `drush generate data-structures:map`.
- Generate an immutable value map whose properties are `readonly` (default), preventing mutation after construction.
- Generate a mutable value map when the values must change after construction (answer "yes" to the mutable prompt).
- Scaffold a custom typed immutable sequence for any base type or namespaced class with `drush generate data-structures:typed-sequence`.
- Enforce that a collection contains only `int` values by constructing an `IntImmutableSequence`.
- Enforce that a collection contains only `string` values by constructing a `StringImmutableSequence`.
- Enforce that a collection contains only `float` values by constructing a `FloatImmutableSequence`.
- Enforce that a collection contains only `object` values by constructing an `ObjectImmutableSequence`.
- Enforce that a collection contains only `callable` values by constructing a `CallableImmutableSequence`.
- Reject bad input early: passing a mismatched element to a typed sequence throws a `TypeError` at construction.
- Guarantee immutability of a data set — assigning or unsetting an offset on a sequence throws a `RuntimeException`.
- Sort a sequence on construction by passing `TRUE` (uses `natsort()` for strings, `sort()` otherwise) or a custom comparator callable.
- Transform a sequence into a new sequence with `map()`, keeping the type guarantee on the result.
- Reduce a sequence to a single aggregate value with `reduce()`.
- Filter a sequence into a new sequence with `filter()`.
- Filter a string sequence to only entries containing a substring with `filterContains()`, or starting with one via `filterBegins()`.
- Iterate any sequence with `foreach`, count it with `count()`, or JSON-encode it (all implement the relevant SPL/JSON interfaces).
- Build a collection of unique values with `Set`, which silently ignores duplicate `add()` calls.
- Compute the union, intersection, difference, or symmetric difference of two sets for tagging, permission, or membership logic.
- Define custom equality for domain objects by implementing `EqualityInterface` so a `Set` treats logically-equal instances as duplicates.
- Reduce memory use in data-heavy code by storing structured objects instead of large associative arrays.
- Provide type-safe DTOs across service boundaries without hand-writing boilerplate collection classes.
