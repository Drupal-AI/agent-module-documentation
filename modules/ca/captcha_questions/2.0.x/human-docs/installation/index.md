# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **No module dependencies.** CAPTCHA Questions is self-contained and does not
  require the CAPTCHA module.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/captcha_questions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captcha_questions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha_questions -y
```

## Submodules

- **`captcha_questions_dblog`** — optional database logging of CAPTCHA Questions
  activity. Enable it only if you want that record:

  ```bash
  drush en captcha_questions_dblog -y
  ```

## Verify it worked

Open the module's **Configure** link from the modules list, create a question/answer
pair, and attach it to a form (for example a comment or registration form). Then
load that form as an anonymous user and confirm that a wrong answer blocks
submission while the correct answer lets it through.
