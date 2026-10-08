<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multisite Easy Commands (MSL) makes Drush friendlier on multisite installs by letting you select the target site interactively instead of always passing `--uri`.

---

The module ships Drush commands (`src/Commands/MultiSiteEasyCommands.php`) and one admin config form at `/admin/config/msl-configuration` (`administer site configuration`) for registering the list of sites. When you run the wrapped command, MSL reads sites from `sites.php` and from module config, and — unless you already passed `-l` or `--uri` — prompts you to choose one, then appends the chosen `--uri=` and runs the underlying command with `passthru()`. A "persist" option remembers the selected URI in state so subsequent commands reuse it until cleared.

Everything runs on the CLI under whatever account executes Drush; there is no web-facing execution path. The `passthru()` call interpolates the assembled Drush command including site URIs sourced from `sites.php`/config, so treat those config values as trusted (they are set by developers with `administer site configuration` and executed locally), the same trust boundary as any Drush alias.

---
- Run Drush against a chosen multisite without typing `--uri` every time.
- Pick the target site from an interactive list.
- Remember a selected site URI across several commands, then clear it.
- Register your multisite URLs in a simple admin form.
- Speed up repetitive multisite maintenance on the CLI.
- Reduce mistakes from pasting the wrong `--uri`.
- Combine sites from `sites.php` with an extra configured list.
- Streamline cache clears across many sites.
- Onboard new developers to a multisite's site list quickly.
- Standardise how a team targets sites in Drush.
- Persist a working site during a long maintenance session.
- Bypass the prompt by passing `-l` or `--uri` explicitly.
- Keep multisite operations scriptable and repeatable.
- Avoid memorising every site's URI.
- Centralise the site roster in module configuration.
- Support ad-hoc Drush tasks across a multisite estate.
