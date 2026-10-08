# Update Helper — manual setup guide

**Update Helper** (`update_helper`) is a developer tool that makes it easier to
**ship configuration changes through module and distribution update hooks**.
Instead of asking site owners to reconfigure things by hand after an upgrade, you
capture the exact configuration delta once and let it apply itself when they run
`drush updatedb`.

It has two cooperating halves. A **Drush generator** diffs your site's active
configuration against a module's exported YAML, works out precisely what changed,
and writes two artifacts: a *Configuration Update Definition* (CUD) file in your
module's `config/update/` folder, and a matching `hook_update_N()` in the module's
`.install` file. A **runtime service** (`update_helper.updater`) then applies that
CUD safely from the update hook — importantly, it only changes config that still
matches an expected baseline, so a site owner's hand-edits or an already-applied
update are skipped with a warning rather than clobbered.

Update Helper is aimed at module and distribution maintainers, not site
administrators — it has **no admin UI, no permissions, and stores no
configuration of its own**. It depends on the **Config Update** module and needs
the project-local Drush (version 12 or newer). An optional submodule,
**Update Helper Checklist**, can present site owners with a checklist of which
updates have run.

This guide is written for a **human** developer. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the Config
   Update dependency, and the optional Checklist submodule.

## Where it lives in the admin menu

Nowhere — Update Helper adds no admin pages. You work with it entirely from the
command line (`drush generate …`, `drush updatedb`) and from your module's code.

## How to use it

The typical workflow, run from your project with the local Drush
(`vendor/bin/drush`):

**1. Generate a configuration update.** After making a config change you want to
ship, run:

```bash
drush generate update_helper:configuration-update
# aliases: drush generate config-update  /  configuration-update
```

It asks which module the update belongs to, a description, which modules' config
to include in the diff, and whether to generate the update **from active
configuration**. It then diffs active config against the module's exported YAML,
writes the CUD to `<module>/config/update/<name>.yml`, adds a `hook_update_N()` to
`<module>.install`, and re-exports the changed config so code and database agree.

There are two modes. In **forward/normal mode** you answer *no* to "from active
configuration": you install the old version, make your code and config changes in
the working tree (without exporting), then generate, and the command captures the
delta and exports the new YAML. In the more robust **reverse mode** you have
already committed the new exported config; you install the old version, bring in
the new code, then answer *yes*, and the delta is taken from the now-current
active configuration.

**2. The generated update hook applies the CUD.** It looks like this and requires
no editing:

```php
function mymodule_update_9001(): string {
  /** @var \Drupal\update_helper\Updater $updater */
  $updater = \Drupal::service('update_helper.updater');
  $updater->executeUpdate('mymodule', 'mymodule_update_9001');
  return $updater->logger()->output();
}
```

**3. Site owners run `drush updatedb`.** That runs the hook, which applies the CUD
— but only where the live config still matches the CUD's expected baseline, so
local customisations aren't overwritten. Any config that has drifted is skipped
and noted in the update output. Always review the generated code before shipping
it.
