# Configuration

Microwave has two stages: **tell it what to warm** on the settings form, then
**queue and run** the warming with Drush (or cron). Nothing is warmed until you
do both.

## Open the settings form

1. Log in as a user who has the **`configure microwave`** permission (grant it at
   **People → Permissions** to the role that manages warming — an administrator
   by default).
2. Go to **Configuration → System → Microwave**, or navigate directly to
   `/admin/config/system/microwave`.

## Choose what to warm

The settings form (`MicrowaveSettingsForm`) lets you select the targets:

- **Content types** — tick the node bundles whose pages you want warmed. For each
  selected type you can optionally set a **date field and a period** so that only
  *recent* nodes are warmed (for example, only nodes published in the last 30
  days), rather than every node of that type. This keeps the queue focused on the
  content that actually matters after a release.
- **Taxonomy vocabularies** — tick the vocabularies whose term pages should be
  warmed. Term URLs are built from the canonical term route.
- **Custom URLs** — enter arbitrary paths to warm, **one per line**. Use this for
  the front page, landing pages, or any route that isn't a node or term.

Only published nodes and terms are warmed (the queries filter on `status = 1`).
Save the form when you're done.

## Queue the URLs with Drush

Once the settings are saved, use these commands to add the matching URLs to their
queues. Each command clears its own stale queue first, then re‑queues:

| Target | Command | Alias |
|--------|---------|-------|
| Custom URLs | `drush microwave:process_custom_urls` | `mpcu` |
| Nodes | `drush microwave:process_nodes_urls` | `mpnu` |
| Taxonomy terms | `drush microwave:process_terms_urls` | `mptu` |
| Commerce products *(submodule)* | `drush microwave:process_commerce_product_urls` | `mpcpu` |

Large sets are batched (around 100 items at a time) to avoid memory spikes. These
commands are designed to be called from a **CI pipeline right after a
deployment**.

## Run the warming queues

Queuing only records the URLs; the actual page requests happen when the queue
workers run. Let cron process them, or trigger a queue immediately:

```bash
drush queue:run microwave_custom_cron
drush queue:run microwave_node_cron
drush queue:run microwave_term_cron
drush queue:run microwave_commerce_product_cron
```

Each queued URL is warmed by a plain GET through the `microwave.warmer_requests`
service.

## Good to know

- **Built‑in SSRF guard.** Before requesting any queued URL, Microwave validates
  it: the scheme must be `http`/`https` **and** the host must equal the current
  site's host, otherwise the request is refused and logged. Microwave will not
  warm external URLs.
- **Where to look when something fails.** Warmer failures are logged to the
  `microwave` logger channel — check **Reports → Recent log messages**.
- A typical post‑deploy flow is: run the `process_*` commands to queue, then run
  the `queue:run` workers, all from CI.
