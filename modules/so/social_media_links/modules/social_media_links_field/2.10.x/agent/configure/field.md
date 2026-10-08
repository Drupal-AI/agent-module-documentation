# Add & configure the field

Field type `social_media_links_field` (`src/Plugin/Field/FieldType/SocialMediaLinksFieldItem.php`).
Add via **Field UI** (Manage fields → Add field → "Social Media Links Field") on any bundle.
Config schema: `config/schema/social_media_links_field.schema.yml`.

## Field (instance) settings
| Setting | Type | Meaning |
|---|---|---|
| `iconset` | string | Iconset plugin id used to render the icons (from the parent module's iconsets). |
| `platforms` | sequence | Per-platform: `enabled` (bool), `description` (label), `weight` (int) — controls which networks are offered and their order. |

## Stored value
Each field value is a `platform` (string, the platform plugin id) + `value` (string, the
account/handle). The platform plugin's URL prefix/suffix build the final link.

## Widgets & formatter
| Id | Kind |
|---|---|
| `social_media_links_field_default` | Widget — multi-row editor (one row per enabled platform). |
| `social_media_links_field_select` | Widget — select-based, compact entry. |
| `social_media_links_field_default` | Formatter — renders icon links like the block. |

Base widget: `SocialMediaLinksFieldBaseWidget`; form element `SocialMediaLinksPlatforms`
(`src/Element/`).

## Theming
Output uses the `social_media_links_platforms` theme hook. `hook_theme_suggestions` adds
field-aware suggestions so you can override per field/entity type/bundle:
`social_media_links_platforms__<field_name>`,
`social_media_links_platforms__<entity_type>__<bundle>`,
`social_media_links_platforms__<entity_type>__<field_name>`, and the combined
`…__<entity_type>__<field_name>__<bundle>`.

Defining new networks or icon sets is done in the parent module — see
`social_media_links` `plugins/platform.md` and `plugins/iconset.md`.
