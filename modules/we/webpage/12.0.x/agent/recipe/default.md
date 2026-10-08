<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The default recipe (`recipes/default`)

Webpage is a config-bundle module: its behaviour is the recipe, not code.

## Install & enable

```bash
composer require drupal/webpage
drush en webpage -y      # webpage_install() applies recipes/default
```

`webpage_install($is_syncing)` calls
`RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'))`, but only
when **not** syncing config (it returns early if `\Drupal::isConfigSyncing()` or `$is_syncing`).
So enabling the module on a running site applies the recipe; a `drush cim` / config-sync install
does not (the exported config already carries everything). You can also apply the recipe directly:

```bash
drush recipe modules/contrib/webpage/recipes/default
```

## Recipe header (`recipe.yml`)

`name: 'Webpage - Default'`, `type: install`.

## Modules enabled (in order)

`node`, `path`, `text`, `user`, `block`, `block_content`, `field`, `content_moderation`,
`workflows`, `menu_ui`, `pathauto`, `field_group`, `smart_trim`, `display_builder`,
`display_builder_entity_view`, `image`, `datetime`, `options`, `menu_link_content`, `views`,
`webform`, `webform_ui`, and finally `webpage` itself.

## Config imported from other modules (`config.import`)

- `display_builder`: `display_builder.profile.default`.
- `image`: `image.style.large`, `image.style.thumbnail`.
- `node` (core content views): `views.view.archive`, `views.view.content`,
  `views.view.content_recent`, `views.view.frontpage`, `views.view.glossary`.
- `user`: `core.entity_view_mode.user.compact`, `views.view.user_admin_people`,
  `views.view.who_s_new`, `views.view.who_s_online`.
- `webform`: `webform.webform.contact`.

`config.strict` lists `field.storage.node.body` (must not already exist / must match).

## Contact form action

Under `config.actions`, the recipe runs a `simpleConfigUpdate` on `webform.webform.contact`:
it rewrites the form `elements` (a flexbox contact form: Your Name — prefilled with
`[current-user:display-name]`, Company name, Business email — prefilled with `[current-user:mail]`,
Phone number, Message, Submit) and points the confirmation/notification email handlers at the
visitor-supplied address (`to_mail: [webform_submission:values:email:raw]`,
`reply_to: [webform_submission:values:email:raw]`). The form has no subject field. It is served
at `/form/contact`. This mirrors Webform's own contact template (an anonymous visitor has no
account email, so the confirmation goes to the address they typed).

## Config entities the recipe creates for the page type

Shipped in `recipes/default/config/` and imported as the module's own config; documented in
[../config/content-type.md](../config/content-type.md):

`node.type.webpage`, `field.storage.node.body`, `field.field.node.webpage.body`,
`core.base_field_override.node.webpage.promote`, `core.entity_view_mode.node.teaser`,
`core.entity_view_mode.node.full`, `core.entity_form_display.node.webpage.default`,
`core.entity_view_display.node.webpage.default`, `core.entity_view_display.node.webpage.teaser`,
`core.entity_view_display.node.webpage.full`, `workflows.workflow.editorial`,
`pathauto.pattern.webpage`.
