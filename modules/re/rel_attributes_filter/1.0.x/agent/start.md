<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rel Attributes Filter (rel_attributes_filter) — agent index

Provides **three core `@Filter` plugins** that add `rel` attributes to `<a>` tags at render time.
Enable them per **text format** — there is no settings form, no permissions, no plugin type to
implement, and no Drush. Core-only. Core requirement `^8 || ^9 || ^10 || ^11`.

The whole module is `src/Plugin/Filter/{Nofollow,Noopener,Noreferrer}Filter.php` (three near-identical
classes) plus `hook_help()` in `.module`.

## Filter plugins (real ids)

| Plugin id | Title | Token added |
|---|---|---|
| `filter_nofollow` | Add nofollow to all links | `nofollow` |
| `filter_noopener` | Add noopener to all links | `noopener` |
| `filter_noreferrer` | Add noreferrer to all links | `noreferrer` |

All three are `FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE` and extend `FilterBase` with no settings.

## Behaviour (verified against source + live)

- Parses with `Html::load($text)` (DOMDocument), iterates `getElementsByTagName('a')`, re-emits with
  `Html::serialize()` — no regex.
- **Only anchors with `target="_blank"` are modified.** The plugin *titles* say "all links" but the
  code gates on `target === '_blank'` (`NofollowFilter.php:30`); plain and `target="_self"` links are
  left untouched.
- If a `rel` already exists, the new token is **prepended**: existing `rel="nofollow"` +
  `filter_noopener` → `rel="noopener nofollow"` (`NofollowFilter.php:31-36`). Otherwise `rel` is created.
- The token is a **hardcoded constant** (never from config or request input), so no attribute/markup
  injection; DOMDocument serialization escapes existing attribute values.

## What you'd do → where

- **Enable the filters on a text format, set filter order, and understand the exact transform** →
  [configure/rel_attributes_filter.md](configure/rel_attributes_filter.md)

## Key facts

- No `configure` route (config is done inside the Text Formats UI at
  `admin/config/content/formats`). No `.routing.yml`, `.permissions.yml`, `.services.yml`,
  `config/install`, or `config/schema`.
- No dependencies beyond core `filter`. `hook_help()` is the only module-file code.
- Based on the "Noopener filter" module, extended with `nofollow`/`noreferrer`. `hook_link_alter`
  support is explicitly not provided.
