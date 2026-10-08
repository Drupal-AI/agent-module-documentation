# Installation

## Requirements

AOS JS is deliberately lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no other module dependencies, no third-party Composer packages, and no PHP
library requirements. The AOS JavaScript itself ships with the module (with a CDN fallback),
so nothing extra is required to get animations working.

## Install with Composer

From the project root:

```bash
composer require drupal/aosjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aosjs -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aosjs -y
```

That's all it takes. On a standard install the base module immediately attaches AOS to every
non-admin page and initializes it, so any element carrying `data-aos` attributes animates on
scroll — see the [overview](../index.md#how-to-use-it).

## Submodules — enable only what you need

AOS JS ships two optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AOS JS UI** | `aosjs_ui` | An admin UI for attaching animations to CSS selectors (no markup edits), plus AOS init options such as disabling animations on phone/tablet/mobile. When enabled, it takes over attaching AOS, so the base module's automatic site-wide attach steps aside. |
| **AOS JS Animate.css** | `aosjs_animatecss` | Swaps AOS's built-in animation set for the Animate.css library's effects. This too takes over attaching AOS from the base module. |

For example, to add the selector-management admin UI:

```bash
drush en aosjs_ui -y
```

## Optional: self-host the AOS library

If you prefer not to load AOS from a CDN (for privacy or offline use), place a copy of the
AOS library at `libraries/aos` so its bundled path resolves. When the local files are
present, the module serves them instead of the CDN. (Use the **AOS JS UI** submodule if you
want to switch which AOS version or loading method is used.)

## Verify it worked

Add `data-aos="fade-up"` to an element on a content page, clear caches, and scroll the page
in a logged-out or non-admin view — the element should fade up into place as it enters the
viewport.
