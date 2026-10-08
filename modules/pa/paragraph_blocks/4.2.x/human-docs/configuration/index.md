# Configuration

Paragraph Blocks is configured in three places: a **global settings form**, a
**per-field** enable checkbox, and a **per-Paragraphs-type** default admin title.

## Global settings

Go to **Configuration → Content authoring → Paragraph Blocks**
(`/admin/config/content/paragraph_blocks`). The form requires the **Administer
paragraphs settings** permission and saves to the `paragraph_blocks.settings` config
object.

| Setting | Default | What it does |
|---|---|---|
| **Max cardinality** | `10` | For *unlimited* paragraph fields, how many delta blocks are offered for placement. (Fields with a fixed cardinality use their own limit; `0`/empty falls back to 10.) |
| **Individual block UI** | off | Show a checkbox per paragraph *item* in Layout Builder Restrictions, instead of one checkbox per field. |
| **Suppress label** | off | Hide the block label field when placing a paragraph block — the paragraph's admin title is already used as the label, so this removes a redundant field. |
| **Library items only** | off | Only offer paragraphs that reference items from the Paragraphs Library, reducing clutter in the block chooser. |

```bash
drush config:set paragraph_blocks.settings max_cardinality 20 -y
drush config:set paragraph_blocks.settings suppress_label true -y
drush config:get paragraph_blocks.settings
```

## Per field: enable or disable Paragraph Blocks

On a paragraph **entity-reference field's** edit form, a checkbox **"Enable Paragraph
Blocks"** appears (for fields whose handler is the default paragraph handler). Untick
it to stop that field's items from being exposed as blocks. The setting is stored as a
third-party setting on the field config, so it exports with your configuration.

## Per Paragraphs type: default admin title

Each paragraph item has an **admin title** — a string field the module adds to
paragraph entities — that identifies it in the block-placement UI and becomes the
block's label. To make these populate automatically, set a **"Default admin title"**
on the Paragraphs type's edit form:

- When the **Token** module is enabled, this field accepts tokens (for example
  `[paragraph:field_text]`) and shows a token browser, so the admin title can derive
  from the paragraph's own content. The generated title is truncated to 100
  characters.
- New paragraphs of that type get the admin title filled in on creation.

## How the blocks appear in Layout Builder

Once a field is enabled and its paragraphs have admin titles:

- The module derives one block per bundle per item position (delta), named like
  "*Field label item N*", shown under the **Paragraphs** category in the "Add block"
  chooser.
- **Cardinality-1 fields are skipped** — render those as a normal field instead.
- Unavailable items are removed from the chooser, and block labels are overridden with
  each paragraph's admin title.
- You can restrict which paragraph blocks are allowed on a given display using
  **Layout Builder Restrictions**; the **Individual block UI** setting above controls
  whether restrictions are per-item or per-field.

Layout Builder configuration is kept in sync with paragraph order automatically (the
module skips reordering while a Workspace is syncing, so it plays nicely with
Workspaces publishing).
