<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Assets — the two-recipe chain

Web Assets is delivered as two Drupal recipes under `recipes/`. The module's only PHP is the install
hook that applies the first one.

## Install flow

`webassets.install` → `webassets_install($is_syncing)`:

```php
if (\Drupal::isConfigSyncing()) { return; }
if (!$is_syncing) {
  RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'));
}
```

So enabling the module (`drush en webassets`) applies `recipes/default`. When the recipe itself is what
installs the module (the recipe's `install: [webassets]` step), `$is_syncing` is true and the hook does
nothing — the recipe has already applied. This guard avoids applying the recipe twice.

## recipes/default (`type: install`)

```yaml
recipes:
  - core/recipes/content_editor_role
  - foundation
install:
  - webassets
config:
  strict: false
  actions:
    user.role.content_editor:
      grantPermission: 'access media overview'
      grantPermissionsForEachMediaType:
        - 'create %bundle media'
        - 'edit own %bundle media'
```

Steps, in order:
1. Apply `core/recipes/content_editor_role` (ensures the content editor role exists).
2. Apply the sibling `foundation` recipe (the heavy lifting — see below).
3. Enable the `webassets` module itself.
4. Grant the **content editor** role `access media overview` plus, for **every** media type,
   `create <bundle> media` and `edit own <bundle> media` (via `grantPermissionsForEachMediaType`).
   No permissions are granted to anonymous or authenticated users, and no `delete`/`edit any` grants.

`strict: false` because dependent modules re-save the media displays afterwards (dependencies get
recalculated), so the recipe must not require the imported config to stay byte-identical.

## recipes/foundation (`type: install`)

```yaml
install:
  - file
  - path
  - image
  - media
  - media_library
  - responsive_image
  - crop
  - focal_point
  - media_remote_audio
  - media_remote_image
  - display_builder
  - display_builder_entity_view
config:
  strict: false
  import:
    media: '*'
    media_library: '*'
    image: '*'
    crop: '*'
    focal_point: '*'
    media_remote_audio: '*'
    media_remote_image: '*'
    display_builder:
      - display_builder.profile.default
```

`foundation` turns on the entire media stack and then **re-imports** the listed modules' shipped config
through the recipe pipeline. The `import` block is required because a recipe installs modules in config
**syncing** mode, so a module's `config/install` entities (e.g. `core.entity_form_mode.media.media_library`)
would not otherwise be created; re-importing them makes the form/view mode entities visible to `load()`
before the recipe's own form and view displays try to resolve them (see the comment in `recipe.yml` and
the project's `AGENTS.md` "Recipes" notes). Its own `config/**` then creates the media types, storage +
field configs, form/view displays, view modes, image styles and responsive image styles documented in
[media-stack.md](media-stack.md).

Note: `media_directories` is a Composer dependency of the project but is **not** in either recipe's
`install:` list, so it is downloaded but not enabled. Older READMEs mention "Layout Builder"; the recipe
actually installs **Display Builder** (`display_builder` + `display_builder_entity_view`).

## Applying standalone

Either recipe applies to a fresh D11.4+/D12 site without enabling the module through the UI:

```bash
php core/scripts/drupal recipe modules/contrib/webassets/recipes/default
# or just the media config, without the Display Builder layer:
php core/scripts/drupal recipe modules/contrib/webassets/recipes/foundation
```
