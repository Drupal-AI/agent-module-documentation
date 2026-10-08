<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Language Switcher Extended

One settings form, one config object. It changes how **core's** Language Switcher block
renders its links; you still place/enable the core block separately at Admin → Structure →
Block layout.

- UI: **Admin → Configuration → Regional and language → Language Switcher Extended**
- Path: `/admin/config/regional/language/language-switcher-extended`
- Route: `language_switcher_extended.settings` (this is the `configure` route in `*.info.yml`)
- Permission: `administer language_switcher_extended`
- Config object: `language_switcher_extended.settings` (schema type `config_object`, exportable)
- Default install config: only `mode: 'default'` is written.

## Keys in `language_switcher_extended.settings`

| Key | Type | Values | Meaning |
|---|---|---|---|
| `mode` | string | `default`, `always_link_to_front`, `process_untranslated` | Top-level behaviour. `default` = leave core switcher untouched. `always_link_to_front` = point every item at its language front page. `process_untranslated` = inspect the current content entity and act on languages it isn't translated into. |
| `untranslated_handler` | string | `hide_link`, `link_to_front`, `no_link` | Only used when `mode = process_untranslated`. What to do with a link whose language has no translation: remove it, repoint to `<front>`, or render as `<nolink>` (adds class `language-link--untranslated`). |
| `translation_detection` | string | `default`, `is_published` | How "translated" is decided. `default` = translation exists **and** current user has view access. `is_published` = translation exists **and** is published. |
| `hide_single_link` | boolean | `true` / `false` | When hiding untranslated links leaves fewer than 2 links, drop the remaining link(s) too (empty switcher). |
| `hide_single_link_block` | boolean | `true` / `false` | When `hide_single_link` triggers, hide the whole block (`links = NULL`) instead of an empty list. (In the form/processor but not in `config/schema`.) |
| `current_language_mode` | string | `default`, `hide_link`, `no_link` | The link to the language you are already viewing. `default` = leave it, `hide_link` = remove it, `no_link` = render as `<nolink>` with class `is-active`. Applied whenever `mode` is not `default`. |
| `show_langcode` | boolean | `true` / `false` | Replace each link title with its language code (e.g. `en`, `de`) instead of the full name. Applied in every non-default mode. |

Form field visibility: `untranslated_handler`, `translation_detection`, `hide_single_link`
only show when `mode = process_untranslated`; `hide_single_link_block` only when
`hide_single_link` is checked; `current_language_mode` shows whenever `mode` is not
`default`.

## Set via drush

```bash
# Behaviour A — hide links for untranslated languages on entity pages:
drush cset language_switcher_extended.settings mode process_untranslated -y
drush cset language_switcher_extended.settings untranslated_handler hide_link -y

# Behaviour B — repoint untranslated languages to their front page:
drush cset language_switcher_extended.settings mode process_untranslated -y
drush cset language_switcher_extended.settings untranslated_handler link_to_front -y

# Behaviour C — show untranslated languages as un-clickable text:
drush cset language_switcher_extended.settings mode process_untranslated -y
drush cset language_switcher_extended.settings untranslated_handler no_link -y

# Every switcher item -> its language front page (ignores translation state):
drush cset language_switcher_extended.settings mode always_link_to_front -y

# Refinements:
drush cset language_switcher_extended.settings translation_detection is_published -y
drush cset language_switcher_extended.settings hide_single_link true -y
drush cset language_switcher_extended.settings current_language_mode no_link -y
drush cset language_switcher_extended.settings show_langcode true -y

# Inspect / reset:
drush cget language_switcher_extended.settings
drush cset language_switcher_extended.settings mode default -y
```

## Notes

- Nothing happens until core's **Language Switcher** block is placed and the site is
  multilingual with translatable content.
- Processing only acts on **content entity** pages: the processor finds the first
  `ContentEntityInterface` among the route parameters; on non-entity/admin/404 pages it
  no-ops, so the switcher falls back to core behaviour.
- `always_link_to_front` and `process_untranslated` are mutually exclusive `mode` values —
  you cannot do both at once from this config.
