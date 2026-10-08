# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- The **Metatag** module, version **2.0 or newer** (`drupal/metatag:^2.0`).
  Schema.org Metatag builds on Metatag and cannot work without it — Composer
  pulls it in automatically, and Drupal enables it as a dependency.

There are no third‑party PHP library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_metatag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (including Metatag) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/schema_metatag -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base framework:

```bash
drush en schema_metatag -y
```

On its own, the base module does nothing visible — it defines the framework but
provides no Schema.org types. You must also enable at least one type submodule
(see below).

## Submodules — enable the types you publish

Schema.org Metatag ships one submodule per Schema.org type. Enable only the ones
you need; each registers a Metatag group plus its property tags. Enable them
with `drush en`:

| Submodule | Schema.org type it adds |
|-----------|-------------------------|
| `schema_article` | Article / BlogPosting / NewsArticle |
| `schema_book` | Book |
| `schema_course` | Course |
| `schema_event` | Event |
| `schema_how_to` | HowTo |
| `schema_image_object` | ImageObject |
| `schema_item_list` | ItemList |
| `schema_job_posting` | JobPosting |
| `schema_movie` | Movie |
| `schema_organization` | Organization / LocalBusiness |
| `schema_person` | Person |
| `schema_place` | Place |
| `schema_product` | Product |
| `schema_qa_page` | QAPage |
| `schema_recipe` | Recipe |
| `schema_review` | Review |
| `schema_service` | Service |
| `schema_special_announcement` | SpecialAnnouncement |
| `schema_video_object` | VideoObject |
| `schema_web_page` | WebPage |
| `schema_web_site` | WebSite (sitelinks search box) |

The `schema_article_example` submodule is a demonstration/example only — you do
not need it in production.

For example, to add Article and Organization markup:

```bash
drush en schema_article schema_organization -y
```

Each submodule requires the base `schema_metatag` module, which is already
present once you have installed it above. After enabling, configure the new tags
under **Configuration → Search and metadata → Metatag** — see the
[overview](../index.md#where-it-lives-in-the-admin-menu).
