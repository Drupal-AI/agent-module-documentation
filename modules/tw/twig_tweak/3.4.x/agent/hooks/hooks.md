# Hooks (twig_tweak.api.php)

Twig Tweak lets modules and themes register extra Twig functions, filters and tests. Each hook is
invoked via both the module handler and the theme manager, so implement it in a `*.module` or a
theme's `*.theme` file. Return nothing; mutate the passed array in place.

```php
use Twig\TwigFunction;
use Twig\TwigFilter;
use Twig\TwigTest;

// Add functions.
function hook_twig_tweak_functions_alter(array &$functions): void {
  $functions[] = new TwigFunction('var', static fn (string $name): ?string => match ($name) {
    'foo' => 'Foo',
    default => NULL,
  });
}

// Add filters.
function hook_twig_tweak_filters_alter(array &$filters): void {
  $filters[] = new TwigFilter('str_pad', 'str_pad');
  $filters[] = new TwigFilter('ucfirst', [\Drupal\Component\Utility\Unicode::class, 'ucfirst']);
}

// Add tests (usable as `{% if x is outdated %}`).
function hook_twig_tweak_tests_alter(array &$tests): void {
  $tests[] = new TwigTest('outdated', static fn ($node): bool => /* … */ TRUE);
}
```

Note: `getTests()` ships no built-in tests — the tests array starts empty and is populated only by
these hooks.
