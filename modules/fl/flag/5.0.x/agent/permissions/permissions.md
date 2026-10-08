# Permissions

Static permissions in `flag.permissions.yml`; per-flag permissions generated dynamically
by `Drupal\flag\Permissions\FlagPermissions::permissions()`.

| Permission | Gates |
|---|---|
| `administer flags` | Define and manage flags and flag settings (restricted/trusted). |
| `administer flaggings` | Delete flaggings belonging to other users (restricted/trusted). |
| `flag <flag_id>` | Use (set) the given flag. Generated per flag via `$flag->actionPermissions()`. |
| `unflag <flag_id>` | Remove the given flag. Generated per flag. |

So each flag you create adds its own `flag NAME` / `unflag NAME` permissions, letting you
grant flagging of a specific flag to specific roles. Global flags additionally respect
the flag type's own access and `hook_flag_action_access()`.
