# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Bootstrap Styles** module (`bootstrap_styles`, `^1.1 || ^2.0`) — a hard
  dependency that supplies the style definitions. Composer pulls it in
  automatically.
- Core's **Layout Builder** in use on the entity displays you want to style. This
  is a practical requirement (the module enhances Layout Builder) rather than a
  formal `info.yml` dependency, so make sure Layout Builder is enabled and turned
  on for at least one content type.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, and pulls in Bootstrap Styles.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies. Layout Builder and Bootstrap Styles are
enabled automatically as dependencies, but you can name them explicitly to be
sure:

```bash
drush en layout_builder_blocks -y
```

After enabling, add or edit a block inside a Layout Builder layout and you should
see the new **Content** / **Style** tabs on the block form.

## Verify it worked

1. Make sure Layout Builder is enabled for a content type (Structure → Content
   types → *your type* → Manage display → **Use Layout Builder**).
2. Edit that entity's layout, click **Add block** (or edit an existing block).
3. The block form should now show a **Content** tab and a **Style** tab. If the
   Style tab is present, the module is working.

Next, decide which style controls editors get and whether to limit which blocks
can be styled — see [Configuration](../configuration/index.md).
