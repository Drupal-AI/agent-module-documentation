# Configuration

All of the module's behavior comes from the rules you write in one settings form.

## Open the restrictions form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Layout Paragraphs → Restrictions**,
   or navigate directly to
   `/admin/config/content/layout-paragraphs/restrictions`.

The form is a single **YAML** textarea (it becomes a CodeMirror editor if the
CodeMirror Editor module is installed). Whatever you enter is parsed and saved as
configuration. The module ships an `example.layout_paragraphs_restrictions.yml`
file as a syntax reference — it is *not* loaded automatically.

## How a rule is shaped

Each top‑level key is a rule name you choose. A rule has a **context** and either an
allow list (`components`) or a deny list (`exclude_components`):

```yaml
# Allow ONLY these components inside a "section" layout paragraph.
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

- **`components`** is a whitelist — the allowed types are narrowed to just these.
- **`exclude_components`** is a blacklist — these types are removed, everything else
  stays.

## The context conditions

A `context` is a set of conditions that must **all** match for the rule to apply.
The available keys are:

- **`parent_type`** — the bundle of the parent (layout) paragraph.
- **`sibling_type`** — the bundle of a sibling component.
- **`region`** — the region machine name (`_root` means the top level of the field,
  i.e. not inside a region).
- **`layout`** — the layout plugin ID (e.g. `onecol`, `twocol`).
- **`field_name`** — the Layout Paragraphs reference field name.
- **`entity_type`** — the entity type the field is attached to (e.g. `node`).
- **`entity_bundle`** — the bundle the field is attached to (e.g. `blog`).
- **`parent_uuid` / `sibling_uuid`** — match a specific parent or sibling.
- **`placement`** — `before` or `after`.

Prefix any value with `!` to negate it, for example `region: '!_root'` means "any
region except the top level".

## Common patterns

Restrict a component to specific layouts and regions:

```yaml
full_width_onecol:
  context: { layout: onecol, region: content }
  components: [hero]
```

Scope a rule to one field on one bundle:

```yaml
restrict_blog:
  context:
    entity_type: node
    entity_bundle: blog
    field_name: field_paragraphs
  components: [text, image]
```

Apply a rule if **any** of several contexts match by passing a list:

```yaml
last_column:
  context:
    - { layout: twocol, region: second }
    - { layout: threecol, region: third }
  components: [callout]
```

## Mercury Editor templates and transforms

If you use Mercury Editor, list template IDs as components by appending the ID to
`me_template_`, e.g. `me_template_3`. (Note the module does not inspect the
paragraph types *inside* a template.) A rule may also carry a `transform` map that,
during drag‑and‑drop, converts a dropped component into an allowed variation instead
of blocking it — the keys are source component types (a trailing `*` matches a
prefix) and the values are the target variation.

## Save

Submit the form to parse and store the rules. Enforcement is immediate: the
add‑component dialog only offers valid types, and drag‑and‑drop moves are checked
live in the builder. Because the rules are stored as configuration, they export and
deploy with the rest of your site config.
