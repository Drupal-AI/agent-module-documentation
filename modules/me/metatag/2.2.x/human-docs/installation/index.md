# Installation

## Requirements

Metatag needs:

- **PHP 8.0** or newer.
- **Drupal core 10.3+ or 11** (`^10.3 || ^11`).
- The **Token** module (`drupal/token` `^1.0`) — this is what makes token
  placeholders like `[node:title]` and `[site:name]` work in tag values.
- Drupal core's **Field** module, which ships with core.

Composer pulls in Token automatically when you require Metatag.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Token and any other
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag -y
```

This also enables the required Token and Field dependencies. Once enabled, the
configuration screens appear under **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`).

## Submodules — enable only the tag families you need

The base module ships the **Basic** and **Advanced** tag groups (page title,
description, keywords, canonical URL, `robots`, referrer, geo, and so on). Everything
else lives in optional submodules, so you only add the meta tags you actually use.
Notable ones:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Open Graph** | `metatag_open_graph` | `og:` tags so shared links show rich previews on Facebook, LinkedIn, etc. |
| **Twitter Cards** | `metatag_twitter_cards` | `twitter:` tags for large‑image previews when a link is tweeted. |
| **Facebook** | `metatag_facebook` | Facebook‑specific tags (`fb:app_id`, admins). |
| **Dublin Core** | `metatag_dc` / `metatag_dc_advanced` | Dublin Core metadata for library and academic catalogs. |
| **Favicons** | `metatag_favicons` | Favicon and touch‑icon `<link>` tags for browsers and mobile. |
| **Mobile & UI Adjustments** | `metatag_mobile` | Viewport, `theme-color`, and other mobile‑browser tuning tags. |
| **Verification** | `metatag_verification` | Site‑ownership verification tags for Google, Bing, Pinterest, etc. |
| **hreflang** | `metatag_hreflang` | `hreflang` tags for multilingual, multi‑region sites. |
| **Custom Tags** | `metatag_custom_tags` | Define project‑specific meta tags through the UI without writing code. |
| **Metatag: Views** | `metatag_views` | Attach meta tags to Views pages and displays. |
| **Metatag: Page Manager** | `metatag_page_manager` | Attach meta tags to Page Manager variants. |
| **Extended Permissions** | `metatag_extended_perms` | Fine‑grained, per‑tag edit permissions for editors. |

Enable each one individually. For example, to add Open Graph and Twitter Card support:

```bash
drush en metatag_open_graph metatag_twitter_cards -y
```

## Verify it worked

Log in as an administrator and go to `/admin/config/search/metatag`. You should see
the **Metatag defaults** list with rows such as **Global**, **Front page**,
**Content**, **Taxonomy term**, and **User**, each marked **Active**:

![The Metatag defaults list after installation](../images/defaults.png)

If the page loads and those defaults are listed, the module is installed correctly.
Next, review the [module settings](../configuration/index.md), then move on to
[managing your defaults](../managing-defaults/index.md).
