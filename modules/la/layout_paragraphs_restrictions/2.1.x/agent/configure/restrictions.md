# Write restriction rules

## Where
Admin form at `/admin/config/content/layout-paragraphs/restrictions`
(route `layout_paragraphs_restrictions.settings`, permission `administer site configuration`,
form `LPRestrictionsSettingsForm`). It is a single YAML textarea (upgraded to a CodeMirror
editor if `codemirror_editor` is installed). Submitting parses the YAML and saves it to config
`layout_paragraphs_restrictions.settings` under the `restrictions` key. There is no import file
loaded automatically — `example.layout_paragraphs_restrictions.yml` in the module is only a
syntax reference.

## Rule shape
Each top-level key is an arbitrary rule name. A rule has a `context` and either an allow list
(`components`) or a deny list (`exclude_components`):

```yaml
# Allow ONLY these components when adding into the "section" layout Paragraph.
section_allowed:
  context:
    parent_type: section
  components:
    - rich_text
    - image
    - call_to_action

# Forbid one component in a context; everything else stays allowed.
no_accordion:
  context:
    parent_type: section
  exclude_components:
    - accordion
```

`components` is intersected with the currently allowed types (whitelist); `exclude_components`
is subtracted (blacklist). Both may appear on one rule. If a rule matches but sets neither list,
it effectively no-ops on server enforcement.

## Context keys
A `context` is a map of conditions that must **all** match for the rule to apply:

- `parent_uuid` — UUID of the parent component
- `parent_type` — bundle of the parent (layout) Paragraph
- `sibling_uuid` — UUID of the sibling component
- `sibling_type` — bundle of the sibling component
- `region` — region machine name (`_root` when at the top level of the field / not in a region)
- `layout` — layout plugin ID (e.g. `onecol`, `twocol`)
- `field_name` — the Layout Paragraphs reference field name
- `entity_type` — entity type the field is attached to (e.g. `node`)
- `entity_bundle` — bundle the field is attached to (e.g. `blog`)
- `placement` — `before` or `after`

Prefix any value with `!` to negate it, e.g. `region: '!_root'` = "any region except the root".

## Region and layout targeting
```yaml
# Hero allowed only in the content region of onecol and the top region of twocol.
full_width_onecol:
  context: { layout: onecol, region: content }
  components: [hero]
full_width_twocol:
  context: { layout: twocol, region: top }
  components: [hero]

# Keep cta_list out of anything below the root (no nesting).
cta_list_only_in_root:
  context:
    region: '!_root'
  exclude_components:
    - cta_list
```

## Field / entity / bundle scoping
```yaml
restrict_blog:
  context:
    entity_type: node
    entity_bundle: blog
    field_name: field_paragraphs
  components: [text, image]

restrict_field_top_level_only:
  context:
    field_name: field_paragraphs
    region: _root
  components: [section]
```

## Multiple contexts per rule
Pass `context` as a numerically indexed list; the rule applies if **any** context set matches:

```yaml
last_column:
  context:
    - { layout: twocol, region: second }
    - { layout: threecol, region: third }
  components: [callout]
```

## Mercury Editor templates
If the `mercury_editor` module is used, template IDs can be listed as components by appending
the template ID to `me_template_`. Note: the module does not inspect the Paragraph types
*inside* a template, so a forbidden type can still enter a context via a template.

```yaml
components:
  - me_template_3
  - me_template_6
```

## Transform (drag-and-drop variation swap)
Beyond allow/deny, a rule may carry a `transform` map (consumed by the JS guard, see
[../extend/api.md](../extend/api.md)) that converts a dropped component into an allowed
variation instead of blocking it. Keys are source component types (a trailing `*` matches a
prefix), values are the target variation.
