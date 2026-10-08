# Workflow — how a module gets documented

This is the exact loop used to generate everything under `modules/`. It is resumable:
state lives in [`../pagination.md`](../pagination.md).

## Environment

Drupal 11 site in DDEV (`module-documentor`). Inside the container run `drush` /
`composer` directly; from the host prefix with `ddev`. Contrib installs to
`web/modules/contrib/{name}`. If the site breaks at any point, reinstall with
`drush site:install -y` and continue — no generated data depends on site content.

### PHP extensions the stock image lacks

Some modules fail at `composer require` because a *dependency* needs a PHP extension that is not
built into the DDEV web image — `oidc` → `sop/jwx` → `sop/crypto-types` → **`ext-gmp`** (wave 71).
The error reads "it is missing from your system", classified by `safe-install.sh` as
`missing-php-extension`. This is an environment problem, not a dead module: add the extension and
retry rather than skip-listing.

```bash
ddev config --webimage-extra-packages='php${DDEV_PHP_VERSION}-gmp'
ddev restart
ddev exec 'php -m | grep gmp'
```

Extensions added so far: **gmp** (`oidc`, wave 71), **oauth** (`lti_tool_provider`, wave 81).

### npm-asset / bower-asset packages need asset-packagist

A module whose front-end library is distributed through npm requires it as `npm-asset/<name>`, and
those packages do not exist on packages.drupal.org. The failure reads as if the module were broken:

```
drupal/charts_apexcharts requires npm-asset/apexcharts ^4 -> could not be found in any version,
there may be a typo in the package name.
```

It is not a typo and not a dead module — the repository is simply not configured. Add it once and
it persists, because `wave-reset.sh` only trims `require` and leaves `repositories` alone:

```json
"repositories": [
    { "type": "composer", "url": "https://packages.drupal.org/8" },
    { "type": "composer", "url": "https://asset-packagist.org" }
]
```

Added in wave 87 for `charts_apexcharts`, which then installed. `oomphinc/composer-installers-extender`
was already in `config.allow-plugins`, which is what places these packages into `web/libraries`.
Classify this failure as an environment gap rather than skip-listing the module.

## Installs are per wave, not cumulative

**Install only the modules the current wave needs, then remove them and reset the database
before the next wave.** `scripts/wave-reset.sh` does the whole cycle.

Waves 1–51 installed cumulatively and it stopped working. By wave 52 the root had **2,311
requirements**, and new modules could no longer resolve against it: wave 54 attempted ten
projects that each had a verified Drupal 11 release and installed **none** of them — every
failure a version clash with something an earlier wave had pinned (`symfony_mailer_queue`
needs `symfony_mailer ^1.4/^1.5` against a pinned `^2.0`; `aos` needs `animate_on_scroll
^1|^2` against a pinned `^3.0`). Saturation is inherent to the cumulative model: each module
installed makes the next one likelier to conflict.

The per-wave cycle:

```bash
scripts/wave-reset.sh                                   # baseline: core only, fresh DB
scripts/next-wave.sh 40 | scripts/check-d11.sh --stdin --only-ok > wave.txt
ddev exec 'cd /var/www/html && bash agent-module-documentation/scripts/safe-install.sh --file agent-module-documentation/wave.txt'
ddev exec 'cd /var/www/html && bash agent-module-documentation/scripts/wave-prepare.sh --file agent-module-documentation/wave.txt'
# … read source, write docs, commit …
scripts/wave-reset.sh                                   # tear down before the next wave
```

Consequences worth knowing:

- A wave's modules are only installed **while that wave is being documented**. Live
  verification (`drush cget`, route checks, `drush en`) has to happen before the reset.
- Cross-wave dependencies disappear: a module documented in wave 30 is no longer on disk, so
  do not write docs that assume it is installed.
- The original cumulative site's `composer.json`/`composer.lock` are archived in
  `.campaign-backups/`; `cp .campaign-backups/composer.lock.pre-reset composer.lock &&
  composer install` restores all ~2,300 modules if a past wave ever needs re-verifying.

## Picking what to document

Two sources, cheapest first.

**A. Modules already on disk** — `scripts/undocumented-on-disk.sh [--verbose]`.
Composer pulls dependencies, and dependencies are modules too; by wave 53 the site had
50+ contrib modules nobody had ever put on a wave list. They need **no composer
resolution at all**, cannot fail to install, and are usually already enabled. Exhaust this
pool before requiring anything new — wave 53 was built entirely from it.

**B. The campaign list** — `scripts/next-wave.sh [N]`, then **pre-filter**:

```bash
scripts/next-wave.sh 250 | scripts/check-d11.sh --stdin --only-ok > wave.txt
```

`check-d11.sh` asks drupal.org's release-history feed whether a project has *any* D11
compatible release. This matters: in the rank ~1598-1801 slice, **26 of 40 projects had no
D11 release at all** and burned 1-2 minutes of composer resolution each before failing.
The check costs ~1s per project. It is a heuristic — a project can pass and still fail on
dependency conflicts — so composer remains the arbiter, but it removes the hopeless cases.

Record everything unusable in `scripts/.campaign-skip` **with a reason comment** so it is
never re-served. Prefer a bare project name on its own line with the reason in a `#` comment
above it; `next-wave.sh` takes the first whitespace-delimited field, so the older
`project<TAB>reason` format also works.

**The reason is not bookkeeping — it is what makes the entry reviewable.** Checked on 2026-08-07,
every entry in the file against packages.drupal.org:

- **129 skip-listed projects now have a Drupal 11 release**, and *all 129* are early-wave entries
  with **no recorded reason**. Every entry that carries a reason is either still NO-D11 or was
  skipped for a permanent cause — a dependency conflict, a project→module rename, a metapackage,
  code that breaks the site.
- So the reasonless entries were almost certainly skipped for "no D11 release yet", a condition
  that expired. They are permanently excluded from a campaign whose purpose is documenting D11
  modules.

Those 129 are listed in `scripts/.campaign-recheck`, which is **not** consulted by `next-wave.sh` —
re-serving them is a deliberate act:

```bash
head -40 scripts/.campaign-recheck | grep -v '^#' > wave.txt
# then the normal safe-install / wave-prepare cycle
```

Anything that fails again goes back into `.campaign-skip` **with a reason this time**, and comes
out of the recheck file. Composer stays the arbiter.

## Loop

For each module picked above:

1. **Pick the next module.** Take its `field_project_machine_name`,
   `field_composer_namespace`, `field_active_installs_total`, description, and category
   term refs from the feed. Skip modules already present under `modules/`.

2. **Install.** `composer require drupal/{name} -W`. Note the resolved version from the
   Composer output (e.g. `token (1.17.0)`). Prefer `scripts/safe-install.sh --file wave.txt`
   for a batch — it isolates failures and rolls composer.json back after each one.

3. **Determine the version directory.** `major.minor.x` (drop the patch): `1.17.0` →
   `1.17.x`. Confirm against `web/modules/contrib/{name}/{name}.info.yml`.

4. **Read the source** (this is what the docs replace). In priority order:
   - `{name}.info.yml` — description, `package`, `dependencies`, `configure`, `recommends`.
   - `composer.json` — `require` (the module's own deps), `suggest`, `conflict`.
   - `README.md` / `README.txt`, and any `docs/`.
   - `{name}.routing.yml` — admin paths and the `configure` route target.
   - `{name}.permissions.yml` — permissions the module defines.
   - `config/install/*.yml`, `config/schema/*.yml` — default settings & their schema.
   - `src/` — services (`*.services.yml`), plugin managers (`Plugin/…`, `src/*Manager.php`,
     `Attribute/`, `Annotation/`), forms, hooks (`src/Hook/*`), event subscribers.
   - `drush.services.yml` / `src/Drush/` — Drush commands.
   - `{name}.api.php` — the hooks the module invites you to implement.
   - Any submodule `modules/*/{sub}.info.yml`.

5. **Enable & set up.** `drush en {name} -y`. Read the resulting config, resolve the
   `configure` route, note permissions. Prefer the simplest tool for each step
   (`drush`/config over UI). When a module has admin **forms/UI**, drive them with
   `agent-browser` and save screenshots to `<project-root>/screenshots/{name}/{version}/`
   — **outside** this repo (they are binary artifacts, not committed) — referenced from the
   relevant solution doc. See [browser-screenshots.md](browser-screenshots.md).

6. **Write the docs** into `modules/{ab}/{name}/{version}/` (`{ab}` = machine name's first
   two letters — the bucket that keeps `modules/` browsable, e.g. `modules/to/token/1.17.x/`):
   - `data.json` — see [file-formats.md](file-formats.md).
   - `usage.md` — short summary `---` long summary `---` 15–30 use cases.
   - `agent/start.md` + `agent/{solution_type}/{name}.md` — only the solution types the
     module actually warrants (`configure`, `plugins`, `extend`, `api`, `hooks`, `drush`,
     `permissions`, `theming`). Each doc must be cheaper to read than the source.

7. **Recurse** into every submodule (step 4–6), writing it nested under its parent at
   `modules/{ab}/{parent}/modules/{submodule_name}/{version}/` (deeper if the submodule
   itself has submodules; the two-letter bucket applies only to the top-level parent).

8. **Update taxonomy.** Add any new category/subcategory to
   [`../categories.yml`](../categories.yml) — never duplicate an existing name.

9. **Advance** `pagination.md` when a page is fully processed.

## Verify before moving on

- `drush pm:list --status=enabled` includes the module.
- **It is really installed, not half-installed.** A module can sit in `core.extension` with no
  `system.schema` entry — `hook_install()` never ran, so default config is missing and the
  module misbehaves while reporting as Enabled. Check with
  [`../scripts/repair-half-installed.sh`](../scripts/repair-half-installed.sh) `--list`
  (`--repair N` fixes them via a real uninstall/install cycle, in batches of N).
- `data.json` is valid JSON; `usage.md` has three `---` blocks and 15–30 bullets.
- Links in `agent/start.md` resolve; the `configure` value matches a real route.
- Helper: [`../scripts/validate-docs.sh`](../scripts/validate-docs.sh) `modules/{ab}/{name}/{version}`
  (run it inside the container — it needs `php`).

## When a module cannot be documented live

Some modules install but cannot be enabled, or take the site down when they are. Document them
**from source** and say so explicitly in `data.json` (`version_note`) and at the top of
`agent/start.md`, with the actual error. Seen in waves 52–53:

- `content_sync` 5.0.x-dev — normalizer signature incompatible with core `serialization`; fatals
  every container build, and cannot be uninstalled with Drush because bootstrap fails. Recovery:
  remove it from `core.extension` directly in the `config` table, truncate the cache tables.
- `domain_language` 2.0.0-alpha2 — `services.yml` passes one argument to a four-argument
  constructor; the config override service is built during container compilation, so the site
  fatals as soon as it is enabled.
- `graphql_metatag` — targets the GraphQL 3.x plugin API (`graphql_core`), so it cannot be
  enabled alongside graphql 4/5 regardless of its core constraint.

A module that fatals the container blocks **every** subsequent `drush en` in the same wave, which
looks like the whole batch failing. If a wave's modules all report FAILED, check for one of these
first.

### The seven shapes of "contrib does not match this core"

By wave 86 this had become the single most common reason a module cannot be documented live, and it
is worth recognising by shape rather than rediscovering each time. All seven produce a fatal; where
the fatal happens decides how much damage it does.

1. **Core narrowed a signature, contrib did not follow.** `views_better_rest`,
   `same_page_preview`, `push_notifications` (waves 80–82) — a `validate(mixed, Constraint): void`
   in core against contrib's older signature. Fatal on **class load**.
2. **Contrib widened a return type.** `rest_entity_recursive` 2.0.6-rc8 (wave 86) declares
   `: array|string|int|float|bool|ArrayObject|NULL` where core declares `: array`. PHP return types
   are covariant — a child may narrow, never widen — so the class cannot load at all.
3. **A concrete type hint against a service something decorates.** `complete_webform_exporter`
   (wave 85) type-hints `FileUrlGenerator` and breaks when `lupus_decoupled_ce_api` replaces it;
   `jsnlog` (wave 86) type-hints `PathMatcher` and breaks because **core's own `path_alias`
   declares `decorates: path.matcher`** — which makes that one universal rather than conditional.
   Fatal at **container compile**, so site and Drush both die.
4. **A container parameter core removed.** `apigee_edge` 4.1.0 (wave 86) injects
   `%main_content_renderers%`; Drupal 11.4 no longer defines it →
   `DefinitionErrorExceptionPass: You have requested a non-existent parameter`.
5. **A latent circular service reference that a second module surfaces.** `aws_cloudwatchlogs`
   (wave 87) tags `aws_cloudwatchlogs.log` as `{ name: logger }` — so it is collected into
   `logger.factory` — while depending on a service that takes `@logger.channel.aws_cloudwatchlogs`,
   a channel obtained **from** `logger.factory`. Core resolves channels lazily, so it works alone.
   `flowdrop_runtime` declares `decorates: logger.factory`, and the two together give
   `ServiceCircularReferenceException`. **Neither module fails on its own**, which makes this the
   hardest shape to attribute — the fix belongs to the module with the latent cycle, not the one
   that exposed it.
6. **An upstream class sealed with `final` that a companion module extends.** `canvas` 1.8.0
   declares `final class ComponentTreeLoader`; `canvas_override` 1.0.0-beta1 extends it →
   *"cannot extend final class"*, fatal on class load. Same contrib-vs-contrib family as the next
   shape but a different mechanism: sealing rather than changing a signature, and nothing in
   either module's composer constraints prevents the pairing.
7. **Contrib-vs-contrib arity inside one family.** The EPT modules (waves 83, 85, 86):
   `ept_core`'s widget base gained two constructor arguments and the components that **override**
   the constructor were left calling it with five. Components that do **not** override inherit
   correctly. None of them constrains `ept_core`'s version, so composer resolves a mismatched pair.
   The rule is greppable: `parent::__construct(` with five arguments in an EPT component is
   suspect.

### A "curl error" can be a permanent packaging bug, not a network blip

`flag_lists` 4.0.4 failed with:

```
curl error 3 while downloading
https://packages.drupal.org/files/packages/8/p2/drupal/flag ^4.0@beta || ^5.0.json:
URL rejected: Malformed input to a URL function
```

Look at what is in that URL. The release's `composer.json` has a require **key** that
concatenates the package name with its constraint:

```json
"require": {
  "drupal/flag ^4.0@beta || ^5.0": "*"
}
```

The name and the constraint belong on opposite sides of the colon. Composer takes the key as a
package name, builds a metadata URL from it, and curl refuses the spaces and pipes.

Three things make this worth its own entry:

- **It reads as transient and is not.** `safe-install.sh` classified it `network` because the
  message contains "curl error". Retrying it will fail identically forever. There is now a
  `broken-manifest` case, matched *before* the network case, for `Malformed input to a URL`.
- **The error names the wrong project.** It says `drupal/flag`. Nothing is wrong with `flag` —
  the bad manifest is in `flag_lists`. Chasing the named package is a dead end.
- **Only the one release is affected**, and it is the newest one. `4.0.3` installs cleanly. So
  the fix is to pin to the previous release, not to skip-list the module:

  ```bash
  ddev composer require drupal/flag_lists:4.0.3 -W
  ```

Generally: when composer reports a URL/parse failure, read the URL. If it contains a version
constraint, whitespace or pipes, the problem is a malformed manifest upstream, and the project
named in the message is the *dependency*, not the culprit. Document the version you could
actually install, and note the broken release.

### An eighth shape: a class shipped under the wrong namespace

The "seven shapes" above are all *version* mismatches — contrib against a core it wasn't built for.
Wave 88 added a different way a module can be installed and still break the build: a class file
whose **declared namespace does not match its PSR-4 path**.

`scorm_field` ships `src/Plugin/Validation/Constraint/ScormPackageConstraint.php` — a path that
PSR-4-maps to `Drupal\scorm_field\…` — but the file's first line declares
`namespace Drupal\social_field\…` (a copy-paste from another project). The site runs fine. Then
`drush en <anything>` triggers a validation-constraint plugin discovery and dies:

```
Fatal error: Cannot redeclare class Drupal\social_field\…\ScormPackageConstraint
```

Why it matters for the campaign:

- **It is invisible until a plugin cache rebuild.** A healthy 200-serving site hides it, so it fails
  at install/uninstall time — exactly when you are enabling the next wave's modules.
- **It looks like the new module's fault.** The fatal fired during `drush en mcp_tools_remote`, but
  the broken file is in `scorm_field`, a module already enabled from earlier in the same wave. When
  a `drush en` fatals on a class name that has nothing to do with the module you are enabling, grep
  the whole contrib tree for that class rather than the module named in the command.
- **The fix is upstream's and one line**, so the practical move mid-wave is to note it, uninstall
  the offending module if it blocks progress, and record it — the doc build does not need the module
  enabled.

### A mid-install fatal leaves the rest of the batch half-installed

This happened three times in four waves (`wisski` wave 84, `component` wave 85, `apigee_edge`
wave 86) and the symptom is confusing enough to be worth stating: module installation **ends with a
cache clear**, so a module that fatals there is written into `core.extension` and never gets its
`system.schema` entry — and neither does anything enabled after it in the same batch. Wave 86 lost
**80 of 120 modules** that way.

Those modules report as **Enabled** while `hook_install()` never ran, so their default config is
missing and they misbehave in ways that do not point at the cause.

Recovery, in order of preference:

```bash
ddev exec bash -c 'cd /var/www/html && bash agent-module-documentation/scripts/repair-half-installed.sh --list'
ddev snapshot restore base-minimal      # cleanest when many modules are affected
```

If Drush itself is down, `core.extension` has to be edited directly — connect with PDO, `unset()`
the offending module, `TRUNCATE` the cache tables. Restoring the snapshot and re-running
`wave-prepare.sh` with the culprit removed from `wave.txt` is faster than repairing a long list.

### A healthy website is not evidence of a healthy site

`bs_lib` (wave 85) registers a Drush command whose **constructor** calls
`$theme_handler->getTheme('bs_base')`, which throws when the theme is absent. Drush instantiates
every `drush.command`-tagged service at bootstrap, so the entire CLI died — while `curl` returned
**200** on the front page and the login page, and `drush pm:uninstall bs_lib` could not run either.

Check both surfaces after enabling a wave: a request to the site **and** `drush status`. A
deployment check that only curls the site will not see this class of failure.

### Before committing a wave: check nothing was missed

`wave-prepare.sh` prints a manifest of everything it enabled. It is easy to write docs for most
of that list and lose one or two at the bottom — this happened in wave 66, where `social_wall`,
`group_by_field_widget` and `commerce_fedex` were enabled, inspected and then left undocumented
until a follow-up commit.

Run the on-disk check as the last step before `git add`:

```bash
bash scripts/undocumented-on-disk.sh    # prints any contrib module on disk with no doc directory
```

Empty output means the wave is complete. It resolves project→module renames, so a project whose
module name differs (e.g. `notificationswidget` → `notifications_widget`) is not reported falsely.
