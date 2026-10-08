# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.4 or newer** for this 2.0.x branch (it uses the `\Dom\HTMLDocument`
  class). If you are on an earlier PHP version, install the 1.0.x branch instead —
  it uses `\DOMDocument` and is functionally identical.

There are no other Drupal module dependencies for the base module. The optional UI
submodule additionally needs the `string_logger` module (for its log display).

## Install with Composer

From the project root:

```bash
composer require drupal/html_transformer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_transformer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_transformer -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Examples** | `html_transformer_examples` | Sample transformer plugins (such as `<b>`→`<strong>` and `<i>`→`<em>`) that show the plugin pattern. Handy as a learning reference. |
| **UI** | `html_transformer_ui` | A testing form at `/html-transformer/transform` for running HTML through selected/automatic plugins and viewing the output and log. Adds the `use html_transformer_ui` permission and needs the `string_logger` module. |

For example, to enable the interactive UI:

```bash
drush en html_transformer_ui -y
```

## Verify it worked

For the base module, confirm the service is available — code calling
`\Drupal::service(\Drupal\html_transformer\HtmlTransformerInterface::class)` should
resolve without error. If you enabled the UI submodule, grant the
`use html_transformer_ui` permission to a trusted role and visit
**`/html-transformer/transform`**; you should be able to paste HTML, run plugins,
and see the transformed output.
