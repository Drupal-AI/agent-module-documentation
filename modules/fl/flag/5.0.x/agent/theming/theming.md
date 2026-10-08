# Theming

## Template
`templates/flag.html.twig` renders a single flag/unflag link. Override by copying into your
theme (theme hook `flag`). Variables include the flag `action` (`flag`/`unflag`), the
`flag` and `flaggable` entities, attributes, and the link title/URL. Flag links are also
exposed as an entity extra field / built via `flag.link_builder`.

## Twig `flag_count()` function
Registered by the `flag.twig.count` service (`FlagCount` Twig extension). Print a flag's
count directly in any template:

```twig
{{ flag_count('bookmark', 'node') }}   {# total flaggings of the 'bookmark' flag on nodes #}
```
The first argument is the flag id, the second the flaggable entity type. Backed by
`flag.count` (`FlagCountManager`).
