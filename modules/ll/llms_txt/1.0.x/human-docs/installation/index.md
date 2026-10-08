# Installation

## Requirements

- **Drupal 10.3+ or 11.1+** (`core_version_requirement: ^10.3 || ^11.1`).
- **PHP 8.1.6 or newer**.
- Core's **Text** module (`text`) — enabled automatically as a dependency.
- **Do not** run this alongside the `llmstxt` or `llms_txt_generator` modules;
  it conflicts with both.
- Optional: **markdownify_views**, which unlocks tokens that render
  Markdown-tagged Views into the file.

## Install with Composer

From the project root:

```bash
composer require drupal/llms_txt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/llms_txt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llms_txt -y
```

There are no submodules.

## Let your web server serve /llms.txt

The module registers a Drupal route at `/llms.txt`, but web servers commonly
block or short-circuit `.txt` files in the web root before Drupal ever sees the
request. You must add a rule that passes `/llms.txt` to Drupal. For Nginx:

```
location = /llms.txt {
  access_log off;
  try_files $uri @drupal;
}
```

(Adjust `@drupal` to match your server's Drupal fallback location.) On a
multilingual site the module already keeps `/llms.txt` at the site root without a
language prefix, so no extra work is needed there.

## Verify it worked

Visit **Content → llms.txt** (`/admin/content/llms-txt`) — the config form should
load. Then open `/llms.txt` in a browser; you should see Markdown served with a
`text/markdown` content type. If you get a 404 or a raw/blocked response, revisit
the web-server rule above.
