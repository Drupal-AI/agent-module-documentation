# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only Drupal dependency, enabled
  automatically when you turn on this module.
- **A LAMP server with Python 3 support**, plus the Python **Newspaper3k** (or
  **Newspaper4k**) library and its natural‑language corpora installed on the web
  server. This is a genuine prerequisite: the plugin shells out to Python at
  migration time. See the upstream
  [newspaper3k‑php‑wrapper](https://github.com/2dareis2do/newspaper3k-php-wrapper)
  for full installation and setup instructions.

Because the plugin fetches remote pages over the network from the server, make
sure outbound HTTP(S) egress is permitted and that you only feed it trusted URLs
from your migration definitions.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_process_newspaper3k -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_process_newspaper3k -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the Python prerequisites

The plugin cannot work without Newspaper3k/4k on the server. If you use DDEV, the
maintainers suggest adding hooks to your project's `.ddev/config.yaml`.

For **Newspaper3k**:

```yaml
hooks:
  post-start:
    - exec: 'pip3 install newspaper3k'
    - exec: 'curl https://raw.githubusercontent.com/codelucas/newspaper/master/download_corpora.py | python3'
```

For **Newspaper4k** on newer DDEV (1.23+):

```yaml
webimage_extra_packages: [python3, python-is-python3, python3-pip, python3-typing-extensions]
hooks:
  post-start:
    - exec: 'pip3 install newspaper4k --break-system-packages'
    - exec: 'pip3 install lxml_html_clean --break-system-packages'
```

Run `ddev restart` after editing the file so the hooks take effect.

## Enable the module

```bash
drush en migrate_process_newspaper3k -y
```

## Verify it worked

Confirm Python and the library are reachable in the web environment (for DDEV,
`ddev exec python3 -c "import newspaper"` should succeed). Then add the
`migrate_process_newspaper3k` plugin to a migration and run
`drush migrate:import` against a page you know is a straightforward article — the
mapped body/summary should come through as clean text.
