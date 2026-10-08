# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- The **Book** module (`book`). Core's Book module was deprecated in Drupal 10 and
  moved to the contrib [Book](https://www.drupal.org/project/book) project — this
  2.0.x release of Custom Book Block targets contrib **Book ^2.0**. Composer pulls
  it in as a dependency.
- No third‑party PHP or JavaScript library requirements.

> **Which version?** Match Custom Book Block to your Book setup: on Drupal 8–10
> with core Book, use `^1.0`; on Drupal 10 with contrib Book `^1.0`, use `^1.1`;
> on **Drupal 10.3 || 11 with contrib Book ^2.0**, use this **`^2.0`** release.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_book_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Book
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_book_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_book_block -y
```

The Book module is enabled at the same time as a dependency.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm **Custom
Book Block** appears among the blocks you can place. Place it, set its options, and
view a book page to check the navigation renders the scope you configured.
