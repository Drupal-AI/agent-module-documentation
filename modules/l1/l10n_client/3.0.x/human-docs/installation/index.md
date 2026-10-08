# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** — the project declares `^8.8 || ^9 || ^10 || ^11`;
  note the `l10n_client_ui` submodule itself declares `^8.8 || ^9 || ^10`, and the
  project ships a hidden `^11` compatibility stub.
- Core's **Locale** module (`locale`) — the on‑page editor saves into Locale's
  translation store, and it's enabled automatically as a dependency of
  `l10n_client_ui`.
- At least one **non‑English language** configured, since the on‑page pane works
  while viewing the site in a language other than English.

This 3.0.x branch is an **alpha** release (`3.0.0-alpha3`); bear that in mind for
production use.

## Install with Composer

From the project root:

```bash
composer require drupal/l10n_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/l10n_client -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The project's functionality lives in its submodules — enabling the top‑level
`l10n_client` module alone does not give you the on‑page editor. Enable the UI
submodule:

```bash
drush en l10n_client_ui -y
```

This pulls in core Locale automatically.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Localization client UI** | `l10n_client_ui` | The on‑page interface‑translation editor (the main feature). Depends on core Locale. Enable this to use the module. |
| **Localization client contributor** | `l10n_client_contributor` | Adds the ability to contribute your translations to a remote localization server (e.g. `localize.drupal.org`) using an API key. Optional; enable only if you want to share translations upstream. |

To also enable contributing translations upstream:

```bash
drush en l10n_client_contributor -y
```

## Set permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant:

- **Use localization client UI** — to the roles that should translate on‑page.
- **Administer languages** — to those who should reach the settings form (usually
  administrators only).
- **Contribute translations to localization server** — only if you enabled the
  contributor submodule and want those users to push translations upstream.

## Verify it worked

Switch the site to a non‑English language and browse to any page as a user with
the *use localization client UI* permission. The on‑page translation pane should
be available. If you'll be translating admin pages, disable the **Overlay** module
first — the pane cannot translate through it. Then continue to
[Configuration](../configuration/index.md).
