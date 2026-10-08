# Configure Islandora Mirador

Form: `\Drupal\islandora_mirador\Form\MiradorConfigForm` at `/admin/config/media/mirador`
(route `islandora_mirador.miradorconfig`, permission `administer site configuration`).
Config object: `islandora_mirador.settings` (schema `islandora_mirador.schema.yml`).

## Settings keys (config/install defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `mirador_library_installation_type` | string | `remote` | `remote` = CDN build; `local` = `/libraries/mirador/dist/main.js` |
| `mirador_library_minified` | bool | `false` | Only used when `local`; marks the local build as minified |
| `mirador_language_support` | bool | `false` | Use the current interface language for the viewer UI; adds `languages:language_interface` cache context |
| `mirador_enabled_plugins` | sequence | `{miradorImageToolsPlugin, textOverlayPlugin}` | Which plugin ids' window config to enable (see plugins doc) |
| `mirador_selected_theme` | string | `light` | `light` \| `dark` \| `system` (system resolves to OS preference in JS) |
| `mirador_theme_light_primary` | color_hex | `#1967d2` | Light theme primary MUI palette color |
| `mirador_theme_light_secondary` | color_hex | `#1967d2` | Light theme secondary color |
| `mirador_theme_dark_primary` | color_hex | `#4db6ac` | Dark theme primary color |
| `mirador_theme_dark_secondary` | color_hex | `#4db6ac` | Dark theme secondary color |
| `iiif_manifest_url` | string | `[node:url:unaliased:absolute]/manifest` | Token pattern (node tokens) for the manifest URL |

## Notes

- `iiif_manifest_url` is validated with `token_element_validate` (`#token_types => ['node']`), max length 256, required.
  For paged content point it at a `.../book-manifest` view path.
- Theme validation rejects anything but `light`/`dark`/`system`; colors must match `^#[0-9a-fA-F]{3}([0-9a-fA-F]{3})?$`.
- Switching to `local` requires you to place the compiled build yourself (output of `npm run webpack` of
  mirador-integration-islandora) at webroot `libraries/mirador/dist/main.js`.
- The enabled-plugins checkboxes only flip flags in the Mirador `window` config; the plugin code must already be
  compiled into the Mirador build you are serving.

## Drush / config

```bash
ddev drush config:set islandora_mirador.settings mirador_selected_theme dark -y
ddev drush config:set islandora_mirador.settings mirador_library_installation_type local -y
ddev drush cget islandora_mirador.settings
```

There is no Islandora-Mirador-specific permission — access to this form is core `administer site configuration`.
The `islandora_display` "Mirador" display-hint term is provided by migration `islandora_mirador_tags`
(`drush migrate:import islandora_mirador_tags`).
