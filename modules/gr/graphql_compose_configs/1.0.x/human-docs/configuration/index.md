# Configuration

Configuration exposures are managed at `/admin/config/graphql/compose/configs`.
You need the **Administer GraphQL configuration exposure** permission.

## Exposing a configuration

1. Navigate to `/admin/config/graphql/compose/configs`.
2. Click **Add configuration exposure**.
3. **Select the configuration** you want to expose (for example `system.site`).
4. **Choose which fields** within it to expose — expose only the specific keys you
   actually need, not the whole object.
5. **Save** the configuration.

Once saved, the module generates a GraphQL type for it automatically, converting
the config name into a valid GraphQL type name (`system.site` → `systemSite`), and
the chosen fields become queryable:

```graphql
query {
  systemSite {
    name
    mail
    slogan
  }
}
```

## Expose only non‑sensitive configuration — the key rule

This is the setting that carries real risk, so treat it deliberately:

- **Configuration can contain secrets** — API keys, credentials, tokens, private
  settings. Exposing such a config object over GraphQL makes those values
  queryable.
- **Only expose non‑sensitive config.** Before saving an exposure, look at every
  field in the object and confirm none of it is a secret. Expose the minimum set
  of fields, not the entire object "to be safe".
- **Review what you've surfaced** periodically, and re‑check after any config
  change that might add sensitive keys.
- **Configure the GraphQL endpoint's access** so exposed config is only queryable
  by the clients that should see it — in particular, **do not let secrets be
  queryable by anonymous requests**. This module's permission governs who can
  *manage* exposures; it does not by itself restrict who can *query* the resulting
  data — that is the GraphQL server's access model.

## Querying

Any client with access to the GraphQL endpoint can query the exposed types once
they're saved. Combine careful field selection here with proper endpoint access
control to keep configuration data exposed only where you intend.
