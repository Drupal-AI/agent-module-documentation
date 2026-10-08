# Configuration

All of this module's behaviour is driven by two settings on one small form.

## Open the settings form

1. Log in as a user with the **Administer config import locale** permission.
2. Go to **Configuration → Regional and language → User interface translation**,
   then open the **Config import settings** tab — or navigate directly to
   `/admin/config/regional/translate/config-import-settings`.

## Interface translation overwrite behaviour

This is the main choice — what a config import is allowed to do to your interface
(UI string) translations:

- **Default** — core behaviour. Interface translations **may be overwritten** if a
  matching string is imported through config import. This is what Drupal does
  without the module.
- **No overwrites** — existing interface translations are **kept**, but genuinely
  new translations may still be added. This is the sweet spot for most sites:
  editors' customised strings survive, yet new strings shipped in config still
  flow in.
- **Nothing** — config imports **never** add or change interface translations at
  all. Use this to freeze translations completely (handy for debugging where an
  overwrite is coming from, too).

## Context

This decides *when* the chosen behaviour applies:

- **CLI** — apply only when Drupal runs on the command line, e.g. during a
  `drush config:import` in a deployment. This is the common choice: protect
  translations during automated deploys while leaving the web UI alone.
- **UI** — apply only in the web interface.
- **Everywhere** *(leave the context empty)* — apply in all contexts.

When the running context doesn't match your choice, the module falls back to
core's **Default** behaviour.

## Save

Click **Save configuration**. Changes take effect on the next config import.

## Setting it from the command line

If you prefer to set the policy as part of a deployment script:

```bash
ddev drush cset config_import_locale.settings overwrite_interface_translation no_overwrite -y
ddev drush cset config_import_locale.settings overwrite_context cli -y
```

> **A note on the "context" option.** The form also shows a second radio set for
> config-translation overwriting, but only the interface-translation behaviour
> and context are actually consumed by the module. The CLI/UI limiting has also
> been observed reading a slightly different config key internally across
> versions, so treat context-limiting as best-effort and verify it behaves as
> expected on your version before relying on it in production. The safe, always-
> reliable knob is the overwrite behaviour itself (Default / No overwrites /
> Nothing).
