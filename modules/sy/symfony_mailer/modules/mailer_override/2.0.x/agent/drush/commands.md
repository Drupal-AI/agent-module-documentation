# Drush commands

Class `Drupal\mailer_override\Drush\Commands\MailerOverrideCommands` (autowired,
`OverrideManagerInterface`).

## mailer:override {action} [id]
`override(string $action, string $id = ALL_OVERRIDES)` — run an override action.
- `{action}`: `import`, `enable`, or `disable`.
- `[id]`: an override id (e.g. `user`, `contact`, `commerce_order`); omit to apply to **all**
  overrides.

Prompts for confirmation (shows the pending warnings), then executes.
```bash
drush mailer:override enable user          # redirect core user emails into Mailer Plus
drush mailer:override enable               # enable all available overrides
drush mailer:override import contact       # (re)import the contact override's default policies
drush mailer:override disable commerce_order
```

## mailer:override-info
`overrideInfo()` — lists every override with columns **Name**, **State**, **Import**
(and any warnings). Supports `--format` (table default, or json/yaml/etc.).
```bash
drush mailer:override-info
drush mailer:override-info --format=json
```
