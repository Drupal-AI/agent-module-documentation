<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Typed sequences & Set — API

All classes live in `Drupal\data_structures\DataStructure` (`src/DataStructure/`). Nothing is
registered as a service or plugin — instantiate them directly in custom code. Requires PHP 8.3+.

## Immutable typed sequences

Files: `CallableImmutableSequence`, `FloatImmutableSequence`, `IntImmutableSequence`,
`ObjectImmutableSequence`, `StringImmutableSequence`. Each `implements \IteratorAggregate,
\Countable, \ArrayAccess, \JsonSerializable`.

Constructor (note `final` — you can extend the class but not override the ctor):

```php
// Non-callable variants: __construct(iterable $values, bool|callable $sort = FALSE)
$seq = new IntImmutableSequence([3, 1, 2], TRUE);        // sorted with sort()
$seq = new StringImmutableSequence(['b', 'a'], TRUE);    // strings use natsort()
$seq = new FloatImmutableSequence([$a, $b], fn($x,$y)=>$x<=>$y); // custom comparator (uasort)
// CallableImmutableSequence takes NO $sort arg:
$fns = new CallableImmutableSequence([strlen(...), 'trim']);
```

- **Type enforcement:** every element is checked in the constructor
  (`is_int` / `is_float` / `is_string` / `is_object` / `is_callable`). A mismatch throws
  `\TypeError('Values of <Class> must be type <t>')`. Values are re-indexed 0..n.
- **Immutability:** `offsetSet()` and `offsetUnset()` always throw
  `\RuntimeException('Instances of <Class> are immutable.')`. Read with `$seq[$i]`
  (`offsetGet` returns the typed element) and `isset($seq[$i])`.
- **Sorting** (non-callable variants): pass `TRUE` → `sort()` (Int/Float/Object) or `natsort()`
  (String); pass a comparator → `uasort()`. Results are re-indexed via `array_values()`.

Common methods (all variants):

- `toArray(): array` — the underlying values.
- `isEmpty(): bool`.
- `count(): int`, `getIterator(): \Traversable` (a generator yielding each value),
  `jsonSerialize(): array` (JSON-encodes to the value array).
- `map(callable $callable): static` — `array_map`, returns a new sequence of the same class.
- `reduce(callable $callable, mixed $initial = NULL): mixed` — `array_reduce`.
- `filter(callable $callable): static` — `array_filter`, returns a new sequence.

Extra methods on **String** and **Float** variants only:

- `filterContains(string $needle): static` — keeps values where `str_contains($value, $needle)`.
- `filterBegins(string $needle): static` — keeps values where `str_starts_with($value, $needle)`.

> Note: on `FloatImmutableSequence` these two use `str_contains`/`str_starts_with` on float
> values, so they are only meaningful for stringy input; the String variant is the intended user.

`map`/`filter`/`filterContains`/`filterBegins` re-run the constructor, so the **type invariant is
re-checked** on the result — e.g. `map()`-ing an `IntImmutableSequence` with a callback that
returns strings throws `TypeError`.

## Set / SetInterface

Files: `Set` (`src/DataStructure/Set.php`), `SetInterface`. `Set implements SetInterface`, which
extends `\IteratorAggregate, \Countable, \JsonSerializable`. Constructor is `final`:

```php
$s = new Set([1, 2, 2, 3]);   // deduped to 1,2,3; pass NULL for an empty set
$s->add(3, 4);                // 3 already present → ignored; 4 added
$s->remove(1);
$s->has(2);                   // TRUE
```

Methods:

- `add(...$values): void` — appends each value not already a member.
- `remove(mixed ...$values): void`, `has(mixed $value): bool`, `empty(): void`,
  `isEmpty(): bool`, `toArray(): array`, `count()`, `getIterator()`, `jsonSerialize()`.
- Set algebra, each returning a **new** `Set` (`new static(...)`, so subclasses are preserved):
  - `union(SetInterface $set)` — members of either (via `\AppendIterator`).
  - `intersect(SetInterface $set)` — members in both.
  - `difference(SetInterface $set)` — members of `$this` not in `$set`.
  - `symDifference(SetInterface $set)` — `difference($set)->union($set->difference($this))`.
- `map(callable)`, `reduce(callable, $initial = NULL)`, `filter(callable)` — same semantics as
  the sequences, returning a new `Set`.

**Equality / uniqueness:** `protected membersAreEqual($a, $b)` uses `===` **unless** both members
implement `EqualityInterface`, in which case they are equal iff `get_class($a) === get_class($b)
&& $a->equalTo($b)`. So for value objects, implement `EqualityInterface` to control dedup:

```php
interface EqualityInterface {           // src/DataStructure/EqualityInterface.php
  public function hash(): int|float|string;
  public function equalTo(EqualityInterface $instance): bool;
}
```

(`hash()` is declared for callers that want a comparable scalar; `Set` itself only calls
`equalTo()`.) Extend `Set` for a typed set by overriding `add()` to validate element type before
calling `parent::add()`.
