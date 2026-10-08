# Restrict IP — Drush command

Defined in `src/Drush/Commands/RestrictIpCommands.php` (tagged `drush.command`).

## `restrict_ip:disable` (alias `ripd`)

Toggles the `enable` flag of `restrict_ip.settings`. Despite the name, the single required
argument decides the direction — `enable` turns the restriction **on**, anything else turns it
**off**.

```bash
drush restrict_ip:disable enable    # sets restrict_ip.settings:enable = TRUE
drush ripd enable                   # same, via alias
drush ripd disable                  # sets enable = FALSE
```

Internally: `$config->set('enable', $value === 'enable')->save();`. It logs
`restrict_ip <value>` on success. This is the CLI equivalent of ticking/unticking "Enable
Restricted IPs" on the admin form, handy in deploy scripts or to quickly re-open a locked site
(you can also unlock via `settings.php` — see [../configure/settings.md](../configure/settings.md)).

That is the only Drush command the module ships.
