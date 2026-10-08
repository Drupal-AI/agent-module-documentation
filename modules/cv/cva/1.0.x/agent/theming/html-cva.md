# Using `html_cva` in Twig

`html_cva(...)` returns a `Cva` object; call `.apply(selections, extra_classes)` on it to get
the final class string. Available in any Drupal Twig template once the module is enabled.
Requires `twig/html-extra` ^3.12 (installed as a Composer dependency of this module).

## Signature

```twig
html_cva(
  base: 'string of always-on classes',        {# optional #}
  variants: {                                   {# optional: option name -> {value: classes} #}
    color: { blue: 'bg-blue', red: 'bg-red' },
    size:  { sm: 'text-sm', lg: 'text-lg' },
  },
  default_variant: { size: 'sm' },              {# optional: value used when a variant is not passed to apply() #}
  compound_variants: [                          {# optional: extra classes when several options match together #}
    { color: ['red'], size: ['lg'], class: 'font-bold' },
  ],
)
```

`.apply(selections, extra)`:
- `selections` — a map of variant name → chosen value, e.g. `{color: 'red', size: 'lg'}`.
- `extra` (optional 2nd arg) — additional classes appended verbatim (e.g. Drupal's `class`/attributes).

Output order is deterministic: **base**, then each matched **variant** value's classes (in the
order variants are declared), then matching **compound** classes, then the **extra** argument.

## Minimal example

```twig
{% set alert = html_cva(
  base: 'alert',
  variants: {
    color: { blue: 'bg-blue', red: 'bg-red', green: 'bg-green' },
    size:  { sm: 'text-sm', md: 'text-md', lg: 'text-lg' },
  }
) %}

<div class="{{ alert.apply({color: 'red', size: 'lg'}) }}">…</div>
{# class="alert bg-red text-lg" #}
```

## Default variants

Values in `default_variant` are used for any option you omit in `apply()`:

```twig
{% set alert = html_cva(
  base: 'alert',
  variants: {
    color:   { blue: 'bg-blue', red: 'bg-red' },
    rounded: { sm: 'rounded-sm', md: 'rounded-md' },
  },
  default_variant: { rounded: 'md' }
) %}
{{ alert.apply({color: 'blue'}) }}   {# "alert bg-blue rounded-md" #}
```

## Compound variants

Add classes only when **all** listed options match:

```twig
{% set alert = html_cva(
  base: 'alert',
  variants: {
    color: { blue: 'bg-blue', red: 'bg-red' },
    size:  { sm: 'text-sm', lg: 'text-lg' },
  },
  compound_variants: [{ color: ['red'], size: ['lg'], class: 'font-bold' }]
) %}
{{ alert.apply({color: 'red', size: 'lg'}) }}   {# "alert bg-red text-lg font-bold" #}
{{ alert.apply({color: 'blue', size: 'lg'}) }}  {# "alert bg-blue text-lg"  (no font-bold) #}
```

## Passing through Drupal `class` / attributes

The 2nd `apply()` argument appends per-instance classes:

```twig
<div class="{{ alert.apply({color: color, size: size}, class) }}">…</div>
```

## Tailwind conflict resolution (optional)

Install `tales-from-a-dev/twig-tailwind-extra` to get a `tailwind_merge` filter that
de-duplicates conflicting Tailwind utilities produced by `apply()`:

```twig
<div class="{{ alert.apply({color: color, size: size}, class)|tailwind_merge }}">…</div>
```

## Notes

- No configuration, permissions, or Drush commands — the whole surface is this Twig function.
- Rendering programmatically: `\Drupal::service('twig')->renderInline($twig_string)` picks up
  `html_cva` too (useful in tests/verification).
