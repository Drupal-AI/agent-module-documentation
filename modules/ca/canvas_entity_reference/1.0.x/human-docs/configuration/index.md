# Configuration

Canvas Entity Reference works without any configuration — everything on this page
is **optional**. The real behaviour of each reference prop is declared in the
component's YAML (`x-entity-type`, `x-entity-field`, `x-entity-type-bundles`,
`x-entity-widget`), and those per-prop annotations always override the global
settings below.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Canvas Entity Reference**, or
   navigate directly to `/admin/config/content/canvas-entity-reference`.

## Settings

- **Target vocabularies** — Select which taxonomy vocabularies are available for
  entity-reference props globally. Leave everything unchecked to allow all
  vocabularies. A specific prop can still narrow this list with the
  `x-entity-type-bundles` annotation in its YAML.
- **Auto-create terms** — Enable or disable letting editors create a brand-new
  taxonomy term straight from the autocomplete field when the term they type does
  not yet exist. Leave it off if you want authors to choose only from existing
  terms.
- **Default widget** — Choose the widget used for single-value props: **Autocomplete**
  or **Autocomplete (tags)**. Any individual prop can override this with the
  `x-entity-widget` annotation.

## Save

Click **Save configuration**. The new defaults apply to entity-reference props
that do not set their own per-prop overrides.
