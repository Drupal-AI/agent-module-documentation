<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Insert Colorbox

Insert Colorbox stores its settings in the config object **`insert_colorbox.config`**. It has no
route of its own — its two fields are injected into the parent Insert settings form
(`insert.config` → `/admin/config/content/insert`, permission `administer filters`) via
`hook_insert_config_form()` / `hook_insert_config_submit_form()`.

## Config object `insert_colorbox.config`

Shipped defaults (`config/install/insert_colorbox.config.yml`):

```yaml
style: 'image'   # image style shown INSIDE the colorbox
gallery: '0'     # gallery grouping mode
```

| Key | Values | Meaning |
|---|---|---|
| `style` | an image style machine name, `image` (original), or `0` | Which image the Colorbox opens. `0` = reuse the field widget's "Link image to" setting; `image` = original file; otherwise a derivative of the named image style. |
| `gallery` | `post` \| `page` \| `field_post` \| `field_page` \| `0` | How inserted images are grouped into Colorbox galleries. `post` = one gallery per node; `page` = one gallery for the whole page (`gallery-all`); `field_post` / `field_page` = per field; `0` = no gallery (each image opens alone). |

The `gallery_id` produced follows Colorbox's own scheme (`gallery-<entity_type>`, `gallery-all`,
`gallery-<entity_type>-<field>`, `gallery-<field>`) and, when `colorbox.settings`
`advanced.unique_token` is on, is suffixed with a random token.

## Read / set with drush

```bash
drush cget insert_colorbox.config
drush cset insert_colorbox.config gallery page -y
drush cset insert_colorbox.config style thumbnail -y
```

## Insert styles it adds

For image insert (`INSERT_TYPE_IMAGE`), `insert_colorbox_insert_styles()` adds one option per image
style named `colorbox__<image-style-name>` (label `Colorbox <style>`). Selecting one in a field
widget's **Insert** settings (parent module's `third_party_settings.insert.styles`) makes that
Colorbox option available when inserting. Config schema: `insert_colorbox.config` (string `style`,
string `gallery`).
