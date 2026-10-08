# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.1`).
- **PHP 8.1.6+** (through 8.5) — `~8.1.6 || ~8.2.0 || ~8.3.0 || ~8.4.0 || ~8.5.0`.
- Core's **Text** module (`text`) — pulled in as a dependency.
- **Do not** enable this alongside the `llmstxt` or `llms_txt_generator` modules;
  they conflict.
- Optional: the **markdownify_views** module, if you want the `llms_txt_views`
  tokens that render Views output as Markdown.

## Install with Composer

From the project root:

```bash
composer require drupal/llms_txt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llms_txt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llms_txt -y
```

## Configure your web server to serve /llms.txt

This step is **required**. Web servers often serve or block `.txt` files in the web
root directly, before Drupal ever runs, so you must tell the server to route
`/llms.txt` to Drupal.

**Nginx** — add this to your server configuration:

```nginx
# Enable support for the llms_txt module
location = /llms.txt {
  access_log off;
  try_files $uri @drupal;
}
```

**Apache** — refer to your server's documentation to allow `/llms.txt` to be handled
by Drupal rather than served as a static file.

> **On DDEV:** DDEV uses Nginx by default; add the `location` block via a custom
> nginx config under `.ddev/nginx_full/` (or `.ddev/nginx/`) and run `ddev restart`.

## Verify it worked

Visit **`/llms.txt`** in your browser (for example
`https://your-site.example/llms.txt`). You should get a Markdown response served as
`text/markdown` rather than a 404 or a raw/blocked file. Then head to **Content →
llms.txt** to author its contents — see [Configuration](../configuration/index.md).
