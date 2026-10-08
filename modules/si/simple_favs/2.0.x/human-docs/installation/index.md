# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (to place the heart and "My Favourites" blocks) and, if
  you want the favourite toggle in listings, core **Views** (and optionally Search
  API for indexed node views).
- No other contrib dependencies and no extra PHP libraries. **Font Awesome** is
  optional — if it is present the heart uses a nicer icon, otherwise a built‑in
  fallback icon is used.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_favs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_favs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_favs -y
```

## Place the blocks

Go to **Structure → Block layout** (`/admin/structure/block`) and place:

- the **heart / favourite toggle** block where visitors should be able to bookmark
  the current page, and
- the **"My Favourites"** block wherever you want the saved list shown.

Optionally, edit a node‑based view (or a Search API node index view) and add the
**Simple Favs** Views field to show a favourite toggle in each row.

## Grant permissions and configure

Under **People → Permissions**, give the **Administer simple favs** permission to
the roles that should manage the settings. Then visit **Configuration → User
interface → Simple Favs Settings** to choose storage and display options — see
[Configuration](../configuration/index.md).

## Verify it worked

As a visitor, click the heart on a page — it should switch to a "favourited" state,
and the page should appear in the "My Favourites" block and at **/my‑favourites**.
If you enabled database storage, a logged‑in user's favourites should persist after
logging out and back in.
