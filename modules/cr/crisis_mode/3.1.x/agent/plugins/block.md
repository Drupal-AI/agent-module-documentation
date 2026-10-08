<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crisis Mode — block plugin & theming

## Plugin
`\Drupal\crisis_mode\Plugin\Block\CrisisModeBlock` (`src/Plugin/Block/CrisisModeBlock.php`), annotation:
```
@Block(
  id = "crisis_mode_block",
  admin_label = @Translation("Crisis Mode Block"),
)
```
Implements `ContainerFactoryPluginInterface`; injects `config.factory`, `language_manager`, `entity_type.manager`, `path_alias.manager`, `file_url_generator`. There is one persistent instance, `crisismodeblock`, created by `crisis_mode_install()` (see config/settings.md). No custom `blockForm()`/access — placement, region, visibility and enabled state are driven by the settings form and the block config entity.

## `build()`
Reads raw data from `crisis_mode.settings` (`->getRawData()`) into a `$content` array, then preprocesses:
- **Language override**: if the config `langcode` differs from the current language, loads `getLanguageConfigOverride($current_language, 'crisis_mode.settings')` and, when it exists, replaces `crisis_mode_title`, `crisis_mode_text` and `crisis_mode_link_title` with the translated values.
- **Block image** (`crisis_mode_block_image[0]` fid): loads the `file`, builds a `medium` image-style URL via `ImageStyle::load('medium')->buildUrl()`, stores it in `crisis_mode_block_image`.
- **Background image** (`crisis_mode_background_image[0]` fid): loads the file, generates an absolute URL (`fileUrlGenerator`), builds `background-image: url(...);`.
- **Background color**: builds `background-color: <value>;`.
- **CTA node** (`crisis_mode_node`): loads the node and resolves its path alias via `path_alias.manager` into `crisis_mode_node`; if no link title is set, defaults to "More Information".

Returns a render array: `#theme => 'crisis_mode'`, `#content => $content`, `#attached => library crisis_mode/crisis_mode`.

## Theme
`crisis_mode_theme()` (in `crisis_mode.module`) declares the `crisis_mode` hook with a single `content` variable. Template `templates/crisis-mode.html.twig` renders a `.crisis-wrapper` whose inline `style` concatenates the background-color and background-image strings, then a title `<h2>`, optional `<img>` (block image), the message body, and an optional CTA `<a>` button. CSS is in `css/crisis_mode.css` (library `crisis_mode/crisis_mode`, CSS-only, `version: VERSION`).

## Operating notes
- The block is only visible when enabled (via the settings checkbox or `drush crisis-mode on`) and placed in a region.
- Multilingual visibility is stored as the block's core `language` visibility condition; translated strings come from config-translation overrides, not the block config.
- Title, link text and image use normal auto-escaped/URL output; the rich message body is rendered as configured HTML (see config/settings.md — it is authored on the `administer crisis mode` screen).
