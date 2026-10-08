<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The demo decision-tree webform

This submodule is config-only. Its entire payload is one webform config entity that demonstrates
the standard Webform decision-tree technique. There is no code to call.

## Install & view

```bash
drush en localgov_forms_decision_tree -y
```

Enabling imports `config/install/webform.webform.localgov_forms_demo_descion_tree.yml`. Visit the
form at **`/form/localgov-forms-demo-descion-tree`** (id `localgov_forms_demo_descion_tree`, title
*"Demo Decision Tree: Find the Perfect Playlist"*, status `open`). Note the id/path keep the
upstream misspelling *"descion"*.

## The decision-tree pattern

The form is five `radios` elements. Every question after the first has a `#states` `visible`
condition keyed on a previous answer, so questions appear only when the path leads to them:

```yaml
what_era_are_you_interested_in:      # always visible
  '#type': radios
  '#options': { 1980s: 1980s, 1990s: 1990s }

what_kind_of_music_do_you_like:      # visible once an era is chosen
  '#type': radios
  '#options': { Rock: Rock, Pop: Pop, Singer/Songwriter: Singer/Songwriter }
  '#states':
    visible:
      ':input[name="what_era_are_you_interested_in"]': { checked: true }

do_you_prefer_metal_or_grunge:       # visible only if genre == Rock
  '#states':
    visible:
      ':input[name="what_kind_of_music_do_you_like"]': { value: Rock }

do_you_prefer_lyrics_or_music:       # visible only if genre == Singer/Songwriter
  '#states':
    visible:
      ':input[name="what_kind_of_music_do_you_like"]': { value: Singer/Songwriter }

do_you_prefer_artists_or_pop_stars:  # visible only if genre == Pop
  '#states':
    visible:
      ':input[name="what_kind_of_music_do_you_like"]': { value: Pop }
```

Key points to copy:

- Use `#states: { visible: { ':input[name="EARLIER_ELEMENT"]': { value: 'X' } } }` to branch on a
  specific earlier answer, or `{ checked: true }` to reveal once any option is picked.
- Each terminal branch is just another conditional question/markup — extend the tree by adding more
  `radios`/`webform_markup` elements gated on the branch above them.
- The demo form has `settings.ajax: false`; the parent localgov_forms install defaults enable Ajax
  for new forms, but this exported config sets its own value.

## Reuse

Clone the YAML (change `id`, `title`, `page_submit_path`, the elements and their `#states`) to build
a real eligibility checker / triage form, then import it via config or the Webform UI. Because it is
a plain webform config entity, pair with Config Ignore (see the parent module) if editors will
maintain it in production. Uninstalling the module removes only this demo entity.
