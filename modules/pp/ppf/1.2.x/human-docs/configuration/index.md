# Configuration

Preprocessor Files works out of the box with sensible defaults — the settings form
only lets you change *where* it looks for preprocessor files and *what* they are
called, plus a convenience button to scaffold a starter folder.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Preprocessor Files**, or navigate directly to
   `/admin/config/ppf`.

## The settings

- **File extension** — the suffix the module looks for when discovering
  preprocessor files. The default is `.preprocess.php`, which is why a file named
  `node.preprocess.php` is picked up. Change this only if it clashes with another
  convention in your project; every preprocessor file must then use the new
  extension.
- **Preprocessor directory** — the folder (default `preprocessors/`) inside each
  theme or module where the module scans for files. Files can live in subfolders
  within it, mirroring how Drupal discovers templates.
- **Generate a starter folder** — the form can create the `preprocessors/` folder
  in your default theme for you, along with a blueprint file, so you have somewhere
  to start without creating the directory by hand.

## Save

Click **Save configuration**. Clear caches (`drush cr`) afterwards so the theme
registry picks up any files in a newly configured location.

## Setting it from Drush

You can also set the extension directly:

```bash
drush cset ppf.settings preprocessor_files_extension '.preprocess.php' -y
```

## A note on trust

Remember that the files this module discovers are executable PHP. Treat them with
exactly the same care as `.theme` files or templates, keep them under version
control, and only allow people you trust to write to the theme and module
directories.
