# Configure Paragraph Blocks

## Global settings — `paragraph_blocks.settings`

Route `paragraph_blocks.settings` → `/admin/config/content/paragraph_blocks`
(form `ParagraphBlocksSettingsForm`, permission `administer paragraphs settings`).
Schema: `config/schema/paragraph_blocks.schema.yml`.

| Key | Default | Meaning |
|---|---|---|
| `max_cardinality` | `10` | For unlimited paragraph fields, how many delta blocks are offered for placement. `0`/empty = the deriver falls back to 10. Fields with a fixed cardinality use their own limit. |
| `individual_block_ui` | `false` | Show a checkbox per paragraph *item* in Layout Builder Restrictions instead of one checkbox per field. |
| `suppress_label` | `false` | Hide the block label field when placing a paragraph block (the paragraph's admin title is already the label). |
| `library_items_only` | `false` | Only offer paragraphs that reference items from the Paragraphs Library. |

```bash
drush config:set paragraph_blocks.settings max_cardinality 20 -y
drush config:set paragraph_blocks.settings suppress_label true -y
drush config:get paragraph_blocks.settings
```

## Per-field: enable/disable Paragraph Blocks

On a paragraph **entity-reference field**'s edit form (`field_config_edit_form`), a checkbox
**"Enable Paragraph Blocks"** appears (only for fields whose handler is `default:paragraph`).
Stored as a third-party setting on the field config:

`field.field.<entity>.<bundle>.<field>` → `third_party_settings.paragraph_blocks.status`
(integer; default treated as enabled/`TRUE`).

Schema: `field.field.*.*.*.third_party.paragraph_blocks` → `status` (integer).

## Per paragraph type: default admin title

On the Paragraphs type form, **"Default admin title"** sets
`third_party_settings.paragraph_blocks.default_admin_title` on the `paragraphs_type` config
entity. When the Token module is enabled the field accepts tokens (e.g.
`[paragraph:field_text]`) and shows a token browser; the aggregated title is truncated to
100 characters. New paragraphs of that type get the admin title on creation
(`hook_ENTITY_TYPE_create`).
