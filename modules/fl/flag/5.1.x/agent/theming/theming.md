# Theming

## Template
`templates/flag.html.twig` renders a single flag/unflag link (theme hook `flag`). Override
by copying it into your theme. Variables: `action` (`flag`/`unflag`), the `flag` and
`flaggable` entities, `attributes`, `title` (the link text), and `unflag_denied_text`. The
link markup adds CSS classes `flag`, `flag-<id>`, `js-flag-<id>-<entity_id>`, and
`action-flag` / `action-unflag`, plus `rel="nofollow"`. Flag links are also exposed as an
entity extra field / built via `flag.link_builder`.

The link text (`flag_short` / `unflag_short`) is rendered through `#markup` and the
description (`flag_long`) through an HTML attribute, so both are auto-escaped; these
strings are only editable with `administer flags`.

## Twig `flagcount()` function
Registered by the `flag.twig.count` service (`FlagCount` Twig extension). Takes the **flag
entity** and the **flaggable entity** and returns the flag's count (string, `'0'` if none):

```twig
{{ flagcount(flag, node) }}   {# flaggings of this flag on this node #}
```
Backed by `flag.count` (`FlagCountManager`).

## Twig `flaglink()` function
Registered by the `flag.twig.link` service (`FlagLink` Twig extension). Builds a
flag/unflag link render array for an entity by id:

```twig
{{ flaglink('node', node.id, 'bookmark') }}
```
Arguments: entity type id, entity id, flag id. Backed by `flag.link_builder`
(`FlagLinkBuilder`), which returns an empty array if the flag does not apply to the
entity's bundle.

The `flag_count` submodule ships `templates/flag-count.html.twig` (theme hook
`flag_count`) which appends a bracketed count to the link.
