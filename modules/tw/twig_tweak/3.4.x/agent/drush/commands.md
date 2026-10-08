# Drush / console commands

Registered in `drush.services.yml` (Symfony console commands). Available via Drush.

- `drush twig-tweak:debug` (alias `twig-debug`) — list all Twig functions, filters, globals and
  tests currently registered. Filter output by a search word:
  ```shell
  drush twig-tweak:debug
  drush twig-tweak:debug --filter=date
  ```
- `drush twig-tweak:validate` (alias `twig-validate`) — validate Twig **syntax** across templates.
  (For code style use `friendsoftwig/twigcs`.) Requires `symfony/finder`.
- `drush lint:twig` — lint a template (or directory, or STDIN with `-`) and report the first syntax
  error. Options: `--format` (default `txt`), `--show-deprecations`.

These are handy for discovering which helpers (including any added by the alter hooks) are active.
