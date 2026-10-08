# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- Core's **Image** module.
- **Blazy** version 3 or later (`blazy:blazy (>= 3.x)`) — Intense builds on the
  Blazy API. Install it with Composer alongside Intense.
- The third‑party **Intense.js** library, installed as a file on your site (see
  below).

## Install the module with Composer

From the project root:

```bash
composer require drupal/intense -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Blazy and any other
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/intense -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the Intense.js library

The Intense.js library is not a Composer package — download and place it manually:

1. Download the Intense archive from
   <https://github.com/tholman/intense-images/>.
2. Extract it and rename the folder from `intense-images-master` to `intense`.
3. Place it in your site's `libraries` directory so the script is available at:

   ```
   libraries/intense/intense.min.js
   ```

## Enable the module

```bash
drush en intense -y
```

## Verify it worked

Go to a content type's **Manage display** (**Structure → Content types →
*(bundle)* → Manage display**), and check that an image or media field offers the
**Intense** formatter. Set a field to it, save, then view a node with that image —
clicking the image should open the full‑viewport Intense viewer. If nothing
happens, re‑check that `intense.min.js` is present at `libraries/intense/`.
