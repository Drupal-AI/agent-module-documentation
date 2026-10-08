# Twig Slugify — manual setup guide

**Twig Slugify** (`twig_slugify`) adds a single `slugify` filter to Twig that turns
any string into a clean, URL-safe "slug". Write `{{ 'Some Title'|slugify }}` in a
template and you get `some-title`. It is powered by the well-known
[`cocur/slugify`](https://github.com/cocur/slugify) PHP library, which handles
transliterating accented characters to ASCII, lowercasing, and swapping unsafe
characters for a separator.

There is nothing to configure — no settings page, no permissions, no services you
need to wire up. Once the module is enabled, the filter is available everywhere Twig
runs. It is aimed at themers and template authors who want to derive anchor IDs, CSS
class fragments, `data-*` attribute values, or SEO-friendly slugs from field values
without dropping into PHP.

This guide is written for a **human** working in theme templates. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Twig Slugify has no admin UI. It simply registers the `slugify` Twig
filter for use in templates.

## How to use it

Use the `slugify` filter anywhere in a Twig template:

```twig
{{ 'Hello World!'|slugify }}              {# hello-world #}
{{ node.label|slugify }}                  {# slug from a node title #}
{{ term.name|slugify }}                   {# slug from a taxonomy term name #}
```

The filter takes an optional **options** array as a second argument, passed straight
through to `cocur/slugify`, so you can change how the slug is built:

```twig
{{ title|slugify({'separator': '_'}) }}   {# hello_world — underscore separator #}
{{ title|slugify({'lowercase': false}) }} {# keep the original case #}
```

Common options include:

- **`separator`** — the word separator (default `-`).
- **`lowercase`** — force lowercase (default `true`).
- **`regexp`** — a custom regex of allowed characters.
- **`rulesets`** — transliteration rulesets, e.g. language-specific ones.

See the [cocur/slugify documentation](https://github.com/cocur/slugify) for the full
list of options. Typical uses: building in-page anchor IDs from headings, generating
predictable fragment identifiers for accordion/tab components, creating CSS class or
`data-*` values from labels, and producing SEO-friendly URL fragments at render time.
