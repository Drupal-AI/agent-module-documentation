# Installation

## Requirements

Font Awesome needs **Drupal 10.2+ or 11** (`drupal/core: ^10.2 || ^11.0`). It
has **no hard module dependencies** of its own, so nothing extra is pulled in
beyond the module itself.

Two optional submodules ship inside the project and can be enabled later if you
want them:

- **`fontawesome_iconpicker_widget`** — a visual iconpicker widget as an
  alternative to the text autocomplete.
- **`fontawesome_media`** — a Font Awesome media source, so icons can be reused
  as media entities.

The one thing the module needs but does **not** bundle is the Font Awesome
**icon library** itself (version 6.4.2). By default the module loads that
library from the official Font Awesome CDN, so no download is required to get
started. If you would rather host the library yourself, see
[Provide the icon library](#provide-the-icon-library) below.

## Install with Composer

From the project root:

```bash
composer require drupal/fontawesome -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/fontawesome -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fontawesome -y
```

Once enabled, the settings screen appears under **Configuration → Content
authoring → Font Awesome settings** (`/admin/config/content/fontawesome`).

## Provide the icon library

Font Awesome offers two ways to deliver the icon assets to the browser. You
choose between them on the [settings page](../configuration/index.md); this
section covers what each option needs on the server side.

### Option A — Load from the CDN (default)

Out of the box the module serves the library from the Font Awesome CDN. There is
nothing to download: as long as the load method is left on its default and the
site can reach the CDN, icons render immediately. This is the quickest way to
get going.

### Option B — Host the library locally

For offline installs, or where privacy rules forbid third-party requests, you
can host the library yourself. Download and extract it with the module's Drush
command:

```bash
drush fa:download
```

This fetches and unpacks the Font Awesome library into
`libraries/fontawesome` under your Drupal root (you can pass a different path as
an argument). The command skips the download if a `css/` directory already
exists there. After downloading, switch the settings page over to the local
(non-CDN) delivery so the module serves the files you just installed — see
[Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator and go to
`/admin/config/content/fontawesome`. You should see the **Font Awesome settings**
page with a **Font Awesome Method** selector and a **Save configuration** button:

![The Font Awesome settings page after installation](../images/settings.png)

If that page loads, the module is installed correctly. Next, review the
[configuration](../configuration/index.md) to choose how the library loads and
to add the icon field.
