# Multisite Easy Commands — manual setup guide

**Multisite Easy Commands** (`msl`) makes Drush friendlier on a Drupal multisite
install. On a multisite you normally have to append `--uri=https://example.com` to
every Drush command so it knows which site to act on — easy to forget, and easy to
paste the wrong URL. MSL ("Multi Site List") removes that chore: you register your
sites once, then run your command through `drush msl` and pick the target site
from an interactive list.

Under the hood it reads the available sites from your `sites.php` file and from a
small module configuration list, and — unless you already passed `-l` or `--uri` —
prompts you to choose one. It then appends the correct `--uri=` and runs the
underlying command for you. A "persist" option can remember your selection across
several commands during a long maintenance session, and a "clear" option forgets
it again.

Everything runs on the command line under whatever account executes Drush; there
is **no web‑facing execution path**. The one small settings form it adds is just
for registering the list of site URLs and names, so you do not have to keep them in
your head. It is recommended to install MSL on the main project site; otherwise you
would still have to pass `--uri` to reach the config form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Drush is the only prerequisite).
2. [Configuration](configuration/index.md) — register your multisite URLs and
   names, and learn the `drush msl` command and its options.

## Where it lives in the admin menu

Once enabled, the site list form sits at `/admin/config/msl-configuration` (route
`msl.admin_settings_form`), reachable by a user with the **Administer site
configuration** permission. You can also add and manage sites entirely from the
terminal using the command's `--add`, `--remove`, `--save`, and `--clear` options
described in the configuration guide.
