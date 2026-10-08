# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The following modules, which Composer will install with the project:
  - **[Paragraphs](https://www.drupal.org/project/paragraphs)** — builds the job
    content structure.
  - **[Field Group](https://www.drupal.org/project/field_group)** — groups the job
    fields in the editing form.
  - Core **Serialization**, **REST**, and **Search** — expose and index the job
    data.
- Googlebot must be able to **crawl** your job pages for the structured data to be
  useful (no `robots.txt` block or robots meta tag on those pages).

The module also loads its own `civic_job_posting` asset library.

## Install with Composer

From the project root:

```bash
composer require drupal/civic_job_posting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs, Field
Group, and any shared dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/civic_job_posting -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en civic_job_posting -y
```

This enables Civic Job Posting along with its dependencies and creates the job
content type and its fields.

## Verify it worked

Go to **Content → Add content** and confirm the job content type is available.
Create a test job, publish it, and run the page through
[Google's Rich Results Test](https://search.google.com/test/rich-results) — it
should detect valid `JobPosting` structured data.
