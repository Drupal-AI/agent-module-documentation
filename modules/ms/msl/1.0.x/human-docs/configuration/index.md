# Configuration

Setting up Multisite Easy Commands is really two things: registering the list of
sites you want to target, and then running your Drush commands through `drush msl`.
You can register sites either in the admin form or straight from the terminal.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to `/admin/config/msl-configuration` — the **MSL configuration** form. (You
   can also reach it from the module's *Configure* link on the Extend page.)

## Registering sites in the form

The form holds a repeatable list of sites. For each one you provide:

- **Site URL / URI** — the address Drush should target, for example
  `https://example.com`. This becomes the `--uri=` value.
- **Site name** — a friendly label shown in the interactive picker so you can tell
  the sites apart at a glance.

Click **Add more** to add another row, fill in the URL and name, and **Save** the
form. The saved list is combined with any sites MSL finds in your `sites.php`, so
the picker shows both sources together.

## Registering sites from the terminal

If you prefer the CLI, you can manage the same list with command options:

- `--add="https://example.com,example"` — add a site by URL and name (comma
  separated). Quote the value so the shell keeps it as one argument.
- `--remove` — remove a site from the stored list.

## Running commands with `drush msl`

The general form is:

```bash
drush msl "<command and its parameters>" [--option=...]
```

The first argument is the Drush command you want to run, in quotes. For example:

```bash
drush msl cr
```

MSL prompts you to choose which registered site to run `cr` (cache rebuild)
against, then executes it with the right `--uri`. If you pass `-l` or `--uri`
yourself, MSL skips the prompt and uses what you gave it.

## Useful options

- **`--save`** — after choosing a site, remember it as the default for this
  terminal session, so subsequent `drush msl` commands reuse it without asking.
- **`--clear`** — forget the saved default site.
- **`--remove`** — remove the selected site from the stored configuration.
- **`--opt=foo=bar`** — pass a single key/value option through to the underlying
  Drush command. Repeat the flag for several (`--opt=foo=bar --opt=baz=qux`).
- **`--opts="foo=bar,baz=qux"`** — pass several key/value options as one
  comma‑separated list (quote it).
- **`--add="https://example.com,example"`** — add a site (URL, name) from the CLI.

## A note on trust

MSL assembles and runs the final Drush command (including the site URIs from your
`sites.php` and configuration) on the command line. Those values are set by
developers who already have *Administer site configuration* access and run Drush
locally, so treat them as trusted — the same trust boundary as any Drush alias.
There is no web‑facing way to trigger these commands.
