# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, no PHP libraries, and no third-party JavaScript libraries — the
  module bundles its own small JavaScript and CSS.
- At runtime, a **secure context (HTTPS)** in the visitor's browser, because the
  browser Clipboard API only works over HTTPS.

## Install with Composer

From the project root:

```bash
composer require drupal/cp2clip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cp2clip -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cp2clip -y
```

There is nothing to configure after enabling.

## Verify it worked

Add the class `cp-to-clip` to some text — for example a block or a body field:

```html
<div class="cp-to-clip">Test copy value</div>
```

View that page over HTTPS. A copy button should appear at the end of the text, and
clicking it should place the text on your clipboard. If the button appears but
nothing copies, confirm the site is served over HTTPS.
