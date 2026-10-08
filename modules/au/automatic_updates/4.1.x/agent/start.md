# automatic_updates — agent start

Safely updates Drupal **core** via core's Package Manager: push-button "Update now" plus
unattended background updates during cron, guarded by pre-update **validators** and periodic
**readiness/status checks**. Depends on core `package_manager` and `update`. No permissions of
its own — gated by core's `administer software updates`. Config lives on the core Update
settings form (`configure: update.settings`); this module's own config object is
`automatic_updates.settings`. Slated to move into Drupal core.

- Push-button + unattended updates, settings, readiness checks, the Package Manager stage →
  [configure/automatic_updates.md](configure/automatic_updates.md)
- Sandbox managers, validators, StatusChecker service (extend/react to updates) →
  [extend/automatic_updates.md](extend/automatic_updates.md)

Note: the **Automatic Updates Extensions** sub-module (contrib module/theme updates) is
`lifecycle: obsolete` — its functionality has moved into this main module.
