# Configuration

Config Export JSON is driven by a single settings form where you list exactly which
configuration to expose as JSON.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Services → Config Export JSON**, or navigate directly to
   `/admin/config/services/config-export-json`.

## Choose the configs to expose

Enter the configuration you want to share, **one per line**, using either of these
forms:

- `config.name` — expose the whole config object (for example `system.site`).
- `config.name:key` — expose a single key of a config object (for example
  `system.site:name` for just the site name).

Only the objects and keys you list here are included — the module never exports your
whole site's configuration by default. When you **Save**, the module regenerates
the static JSON file at `sites/default/files/config/config.json`, and the same data
becomes available from the REST resource at `/api/config.json`.

## Security — what you list becomes public

This is the most important part of configuring the module:

- The REST endpoint (`/api/config.json`) is only protected by the **access
  content** permission, which anonymous visitors have by default. In practice the
  endpoint is **anonymous-readable**.
- The generated `config.json` file lives in the **public files directory** and is
  web-readable with **no permission check whatsoever**.

So treat every value you expose as **public information**. Before adding anything to
the list:

- **Never expose config that contains secrets** — API keys, tokens, passwords,
  private keys, connection credentials, or anything else sensitive.
- Prefer the `config.name:key` form to expose only the specific keys you need,
  rather than a whole object that might also carry sensitive keys.
- **Review the exposed list before every deploy.** A config object that was safe
  yesterday can gain a sensitive key after a module update or a settings change.

## Save

Click **Save configuration**. The static `config.json` is regenerated immediately.
Confirm the file (and, if enabled, `/api/config.json`) contains only what you
intended to share.
