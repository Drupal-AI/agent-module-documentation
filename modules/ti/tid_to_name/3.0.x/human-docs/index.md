# Term ID to Name — manual setup guide

**Term ID to Name** (`tid_to_name`) is a tiny developer/theming helper that adds
a single Twig function, `tn()`, to your site. Give it a taxonomy term ID and it
returns that term's name — already translated for the language currently being
rendered. If the ID is invalid or the term doesn't exist, it quietly returns an
empty string instead of throwing an error.

This solves a very common theming annoyance: you often have a raw term ID in
scope — a Views contextual‑filter argument, a value on a custom field, a number
passed into a component — but what you actually want to print is the human‑readable
term name. Without this module you'd write a preprocess function to look it up.
With it, you write `{{ tn(123) }}` directly in the template.

Because it resolves the translation for the current interface language
automatically, it's a good fit for multilingual sites: the same
`{{ tn(id) }}` prints the term's German name on the German page and its English
name on the English page. There is no configuration, no permissions, and no admin
UI — you enable it and start calling the function.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Term ID to Name adds no menu items, no settings page, and no
permissions. Its only surface is the `tn()` Twig function you call from your
templates.

## How to use it

Call `tn()` with a term ID anywhere you write Twig:

```twig
{# Simple lookup #}
{{ tn(123) }}

{# Override a View's title using a taxonomy contextual-filter argument #}
{{ tn(arguments.term_node_tid_depth) }}

{# Loop over several term IDs #}
{% for id in term_ids %}{{ tn(id) }}{% if not loop.last %}, {% endif %}{% endfor %}
```

A few things worth knowing:

- The argument can be an integer or a numeric string.
- Invalid input — `0`, a negative number, or anything non‑numeric — returns an
  empty string, so you never get a fatal error from a bad ID.
- A term that has been deleted (or has no translation) also returns an empty
  string, which makes it safe to use in templates that render untrusted data.
- The returned name is a plain string and passes through Twig's normal
  autoescaping.

That single function is the entire public API — there is nothing else to learn.
