# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`).
- The **LMS** module (`lms`) — LMS File Upload extends it.
- Drupal's **private file system** must be configured, because submissions are
  stored there (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/lms_file_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
LMS dependency alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_file_upload -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms_file_upload -y
```

## Configure the private file system

Uploaded submissions use Drupal's **private** file scheme. If you have not already
done so, set the private files path in `settings.php`:

```php
$settings['file_private_path'] = '../private';
```

Point it at a directory **outside** the web root, and make sure your web server
can write to it. Without a configured private path, file-upload activities will
have nowhere to store submissions.

## Verify it worked

With LMS and this module enabled and the private file system configured, add a
file-upload activity to a course, upload a test file as a learner, and confirm the
file is stored under the private scheme and is only downloadable by the learner
and instructor.
