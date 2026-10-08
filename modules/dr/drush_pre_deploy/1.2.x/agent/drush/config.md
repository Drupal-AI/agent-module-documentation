<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drush_pre_deploy — auto-injecting pre-deploy into `drush deploy`

By default the two commands (`deploy:pre-hook`, `deploy:pre-hook-status`) are registered normally and
you run `drush deploy:pre-hook` yourself, before `drush deploy`. To make `drush deploy` run pending
pre-deploy hooks **automatically at its start**, you must also load the module's *global* Drush
command.

## The global pre-command hook

`src/global/DrushPreDeployHookCommands.php` declares `@hook pre-command deploy`. When `drush deploy`
starts, it:

1. Finds `deploy:pre-hook` (if the command is missing — module not enabled — it logs a warning
   `Drush pre-deploy: skipping external execution of drush deploy:pre-hook, the drush_pre_deploy
   module must be enabled beforehand.` and returns without aborting the deploy).
2. Logs `Drush pre-deploy hook start.` and re-dispatches `deploy:pre-hook` to the current site alias
   as a subprocess with the current redispatch options, streaming its output in realtime
   (`$process->mustRun($process->showRealtime())`).

The net effect: `deploy:pre-hook` → `updatedb` → `cache:rebuild` → `config:import` → `cache:rebuild`
→ `deploy:hook`.

## Why it needs a manual include

This file lives under `src/global/`, which is **not** part of Drush's automatic
`drush.services.yml`/PSR-4 command discovery. Drush only loads it if the project points an `include`
path at that directory. Add a `drush/drush.yml` at the **project root** (Drush discovers it
automatically):

```
.
└── ROOT_PROJECT_PATH/
    └── drush/
        └── drush.yml
```

```yaml
drush:
  include:
    - ${env.PWD}/web/modules/contrib/drush_pre_deploy/src/global
```

Notes:
- `${env.PWD}` resolves to the directory Drush is invoked from — run `drush deploy` from the project
  root so the include path resolves. Adjust the `web/modules/contrib/...` segment to your
  installer-paths layout.
- Without this include, `drush deploy` runs the stock sequence and pre-deploy hooks are only executed
  when you call `drush deploy:pre-hook` explicitly.
- The module itself ships **no** `drush.yml`; the file above is something the site maintainer adds.
