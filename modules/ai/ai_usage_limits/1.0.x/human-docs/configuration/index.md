# Configuration

All configuration happens on one form. Until you set values here, nothing is
capped.

## Open the settings form

1. Log in as a user with the AI module's **Administer AI providers** (`administer
   ai providers`) permission — an administrator by default.
2. Go to **Configuration → AI → AI Usage Limits**, or navigate directly to
   `/admin/config/ai/usage_limits`.

## Retention days

At the top of the form, **Retention days** (default **30**, minimum 1) sets how
long usage is accumulated before Drupal's cron clears a provider's counters and
the window starts over. Match it to your provider's billing cycle (e.g. 30 days),
or shorten it so counters roll over more often on a busy site. Remember cron must
actually run for the reset to happen.

## Per-provider limits

The form lists every provider the AI module knows about, each on its own tab. For
a provider you want to cap:

1. Tick **Enable usage limits** for that provider.
2. Fill in any of the five numeric ceilings you care about — leave a field blank
   or at zero to leave that dimension uncapped:
   - **Input token usage** — tokens sent to the model in prompts.
   - **Output token usage** — tokens the model generates in responses.
   - **Total token usage** — a combined ceiling across input and output.
   - **Cached token usage** — tokens served from the provider's cache.
   - **Reasoning token usage** — tokens spent on model "reasoning" (for providers
     that report it).

Where usage has already been recorded in the current window, each field shows how
many tokens have been consumed and over how many days, so you can see how close a
provider is to its limit.

3. Click **Save configuration**.

You can enable limits for one provider while leaving others uncapped, and you can
un-tick **Enable usage limits** to switch a provider's limits off temporarily
without deleting the values you entered.

## What happens when a limit is hit

Once a provider's accumulated usage exceeds one of its configured limits, the next
AI request to that provider is stopped **before** the provider is called — so you
are not billed for it. If you see AI generation suddenly failing, an exceeded quota
here is a likely cause; the counter clears itself when the retention window rolls
over.

## Inspecting and clearing counts (optional)

Live counts are stored in Drupal's state, not in exported configuration. There are
no dedicated Drush commands, but you can inspect or reset them with core state
commands:

```bash
# See current accumulated usage
drush state:get ai_usage_limits

# Clear all accumulated counts immediately (rather than waiting out the window)
drush state:delete ai_usage_limits
```
