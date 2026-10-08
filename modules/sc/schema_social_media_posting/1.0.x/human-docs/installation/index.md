# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Schema.org Metatag 2.x or higher**, including its `schema_article` component,
  which this module depends on. Schema.org Metatag in turn builds on the
  contributed **Metatag** module.

There are no PHP‑library or other third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_social_media_posting -W
```

The Composer package name (`drupal/schema_social_media_posting`) matches the
module's machine name (`schema_social_media_posting`). The `-W`
(`--with-all-dependencies`) flag lets Composer pull in Schema.org Metatag and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_social_media_posting -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_social_media_posting -y
```

Enabling it will also enable its Schema.org Metatag dependency (`schema_article`)
and Metatag if they are not already on. This gives you the `SocialMediaPosting`,
`BlogPosting`, and `DiscussionForumPosting` types.

## Enable LiveBlogPosting (optional)

If you also need the `LiveBlogPosting` type, enable the companion submodule that
ships with this project:

```bash
drush en schema_live_blog_posting -y
```

A **Schema.org: LiveBlogPosting** fieldset then appears alongside the others on the
Metatag settings screens.

## Verify it worked

Go to **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`), add or edit default meta tags, and confirm you
see a **Schema.org: SocialMediaPosting** section among the available fields.
