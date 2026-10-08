# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Filter** module (`filter`) — enabled by default on standard sites.
- The **`intelektron/chordpro-php`** PHP library, which Composer installs
  automatically with the command below. (Take care not to confuse it with an older,
  unrelated library from a different author.)

## Install with Composer

From the project root:

```bash
composer require drupal/songbook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`intelektron/chordpro-php` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/songbook -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en songbook -y
```

## Turn on the ChordPro filter

Enabling the module does not change any content on its own — you need to switch on
its filter for a text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Create a new text format (or edit an existing one) and enable the **"Parse as a
   ChordPro song with chords"** filter, then save.

Remember that on a format with this filter enabled, CKEditor is replaced by a
plain textarea so you can type raw ChordPro notation.

## Verify it worked

Create or edit a field that uses the ChordPro-enabled text format and paste in a
short ChordPro snippet — for example a `{t:...}` title line and a line with
`[C]` / `[Dm]` chord markers. When you view the saved content, the chords should
render above the lyrics.
