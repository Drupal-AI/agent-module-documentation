# Template suggestions added by Twig Template Suggester

Each row is a `hook_theme_suggestions_HOOK[_alter]()` in `twigsuggest.module`. Suggestions use
double underscores in code and become `--` in the template filename (`block__region` →
`block--region.html.twig`). More specific suggestions win; twigsuggest installs at weight 100 so
it runs late.

## Block (`_block`, plus `_block_alter` de-dupes)

- `block__bundle__<bundle>` and `block__bundle__<bundle>__<region>` (content blocks)
- `block__<region>` and `block__<region>__<block_id>`
- `block__<provider>__<region>`, `block__<base_plugin>`, `block__<base_plugin>__<region>`
- for menu blocks: `block__<provider>__<menu_name>__<region>` (and base-plugin variant)

## Page & HTML (`_page`, `_html`)

- `page__node__<node_type>`
- `html__node__<node_type>`

(current node resolved via `twigsuggest.helper_functions::getCurrentNode()`, covering
canonical/preview/revision routes)

## User (`_user`)

- `user__<uid>`, `user__<view_mode>`, `user__<highest_role>`
- `user__<uid>__<view_mode>`, `user__<highest_role>__<view_mode>`

## Field (`_field`, `_field_alter`)

- `field__<field_name>__<view_mode>`
- `field__<entity_type>__<field_name>__<view_mode>`
- `field__<entity_type>__<bundle>__<field_name>__<view_mode>`
- `field__entity_reference_type__<target_type>` (spliced in by the alter hook)

## Taxonomy term (`_taxonomy_term`)

- `taxonomy_term__<bundle>__<view_mode>`, `taxonomy_term__<view_mode>`
- `taxonomy_term__<tid>__<bundle>__<view_mode>`, `taxonomy_term__<tid>__<view_mode>`

## Form / form element / input (`_form_alter`, `_form_element`, `_input`)

- `form__<form_id>`, `form__<region>`, `form__<region>__<form_id>`, `form__<element_id>`
- `form_element__<element_id>`, `form_element__<type>`, `form_element__webform__<webform_id>`
- `input__<element_id>`

## Container (`_container`)

- `container__has_parent` / `container__no_parent`
- `container__<type>` (element `#type`), `container__<child_type>`
- `container__view__<name>`, `container__view__<name>__<display_id>`
- `container__file`, `container__file__<field_name>` (managed_file)
- `container__<group>` (`#group`), `container__<webform_key>` (`#webform_key`)

## Menu / book tree / menu local action

- `_menu_alter`: `<theme_hook_original>__<region>` and `menu__<region>`
- `_book_tree`: `book_tree__<region>`
- `_menu_local_action_alter`: appends `__<route_piece>` for each dot-separated part of the link's
  route (e.g. `menu_local_action__entity__node__add`)

## Layout (`_layout_alter`, opt-in)

Rewrites Display Suite layout suggestions (`onecol` → `one__col` style) **only when**
`twigsuggest.settings:alternate_ds_suggestions` is TRUE. Off by default. See
`configure/settings.md`.

## Global variable

`twigsuggest_preprocess()` adds **`base_path`** to every template, e.g.
`<img src="{{ base_path ~ directory }}/images/icon.svg">`.

To use any suggestion: create the matching file in your theme's `templates/` directory and rebuild
caches. Enable Twig debug (`services.yml` `twig.config.debug: true`) to see the full suggestion
list in the HTML comments for a given element.
