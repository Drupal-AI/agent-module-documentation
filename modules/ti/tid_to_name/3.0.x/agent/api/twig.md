# The `tn()` Twig function

Source: `src/TidToNameTwigExtension.php` (`getFunctions()` returns one `TwigFunction('tn', …)`).

## Signature

```twig
{{ tn(tid) }}
```

- `tid` — an `int|string` taxonomy term ID.
- Returns `string`: the term name, or `''`.

## Behaviour (`getTermNameByTid`)

1. If `tid` is not numeric or `intval($tid) <= 0`, return `''`.
2. Load the `taxonomy_term` entity by `intval($tid)`.
3. If it exists, get the translation for the current interface language via
   `EntityRepository::getTranslationFromContext($term, $currentLangId)` and return its `getName()`.
4. If the term (or the resolved translation) is missing, return `''`.

So it is null-safe and language-aware by default: on a multilingual site `tn()` returns the term name
in the language currently being rendered, falling back per core's translation-context rules. The
returned name is a plain string rendered through Twig's normal autoescaping.

## Common usage

```twig
{# Simple lookup #}
{{ tn(123) }}

{# Override a View title using a taxonomy contextual-filter argument #}
{{ tn(arguments.term_node_tid_depth) }}

{# Loop over several IDs #}
{% for id in term_ids %}{{ tn(id) }}{% if not loop.last %}, {% endif %}{% endfor %}
```

No configuration, and no other public API — the module is exactly this one function.
