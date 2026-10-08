# Drush commands

Registered via `drush.services.yml` → `Drupal\ai_metering\Commands\AiMeteringCommands`.

| Command | Alias | Does |
|---|---|---|
| `ai-metering:quota-reset` | `aim-quota-reset` | Reset a user's monthly token quota counter. |
| `ai-metering:set-user-budget` | `aim-budget` | Set the monthly token budget for a specific user. |
| `ai-metering:sync-pricing` | `aim-sync` | Sync AI model pricing from the configured PricingSource. |
| `ai-metering:litellm-user-spend` | `aim-user` | Show spend data from the LiteLLM proxy for a user. |
| `ai-metering:litellm-report` | `aim-report` | Show the global spend report from the LiteLLM proxy. |

```
drush aim-budget <uid> <tokens>     # set a user's monthly token budget
drush aim-quota-reset <uid>         # clear their used-quota counter
drush aim-sync                      # refresh model prices
drush aim-report                    # LiteLLM global spend
```
Run `drush <command> --help` for exact arguments/options.
