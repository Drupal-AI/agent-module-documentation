<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, recipe & settings

## Install / enable

```
composer require drupal/webnewsletter   # pulls drupal/webform ~6.3.0
drush en webnewsletter -y
```

Requires Webform (`webform:webform`). Core `^11.4 || ^12`. No other dependencies, no config schema,
no Drush commands.

## The default recipe (`recipes/default/recipe.yml`)

`webnewsletter.install`'s `hook_install($is_syncing)` applies the module's own default recipe when the
module is installed standalone (skipped during config sync / when the recipe itself installs the module,
guarded by `\Drupal::isConfigSyncing()` and `$is_syncing`). It uses
`RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'))`.

The recipe (`type: install`):
- installs `webform` then `webnewsletter`;
- imports Webform config (`config.import: webform: '*'`) — brings in the `newsletter_subscribe` webform
  (public form at `/newsletter/subscribe`; see [../plugins/subscribe-handler.md](../plugins/subscribe-handler.md));
- excludes several optional Webform JS libraries (choices, jquery.chosen, codemirror, jquery.select2,
  tabby, popperjs, tippyjs) via `webform.settings` `simpleConfigUpdate`.

Note: a recipe installs modules in config-syncing mode, so a module's own `hook_install()` cannot apply
a sibling recipe — a parent recipe must list `webnewsletter`'s recipe/config explicitly.

## Settings form

Route `entity.webnewsletter_emails.settings` → `/admin/structure/webnewsletter-emails`
(`src/Form/WebnewsletterEmailsSettingsForm.php`, `_permission: administer web newsletter emails`).

It is a minimal `FormBase`: it renders a placeholder markup line ("Settings form for a web newsletter
emails entity type.") and a Save button whose submit only prints a status message. It stores **no
configuration** — the module ships no config object or schema. Its real purpose is to be the
`field_ui_base_route` for the entity, so the **Settings / Manage fields / Manage form display /
Manage display** tabs (Field UI) hang off this page, letting you add fields to and configure the
`webnewsletter_emails` entity.

![WebNewsletter settings / Field UI base page](../../../../../../../screenshots/webnewsletter/12.0.x/settings-form.png)

## Permissions to assign

- Full management: `administer web newsletter emails` (restricted; also unlocks the settings tab and grants all CRUD).
- Delegated management: mix `view` / `create` / `edit` / `delete web newsletter emails` per role.
- The public `/newsletter/subscribe` form needs no permission (open to anonymous by the recipe's webform access config).
