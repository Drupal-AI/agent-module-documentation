# Configuration

Setting up Microsoft Entra User Sync has three parts: registering an Azure app,
storing its credentials securely as a **Key**, and then creating one or more
synchronisations that map Entra users into Drupal.

## 1. Register the Azure app

In the Azure / Entra portal, register an application for your tenant and grant it
the Graph permission the module needs — **`User.Read.All`** and nothing more
(least privilege). Note the tenant ID, client ID, and client secret; you will
store the secret as a Key in the next step.

## 2. Store the credentials as a Key (do not hard‑code secrets)

Authentication is handled entirely by the **MS Graph API** module, which stores the
tenant credentials as a **Key** entity — the secret never lives in EntraSync's own
configuration or code. EntraSync's sync form only *references* an existing key: its
key selector is filtered to keys of type **"MS Graph API Key"** (`ms_graph_api`), so
you must create a key of that type, not a generic key.

Create the key through the **Key** module (Configuration » System » Keys, or the
"create a new key" link on the sync form), choosing the **MS Graph API Key** type and
entering the tenant ID, client ID, and client secret from your Azure app as the MS
Graph API module documents. Follow that module's guidance at Administration »
Configuration » Web Services » Microsoft Graph API to complete the connection.

As with any secret, prefer a key provider that keeps the value out of exported
configuration and version control (for example an environment-variable or file
provider) rather than storing it directly in the database, and give the key a tightly
restricted set of editors. Add one key per tenant you sync. Keep these keys tightly
secured — an Entra app credential can read your whole directory.

## 3. Create synchronisations

With the key(s) in place, add as many synchronisations as you need, each using one
of your tenant keys. For each synchronisation you typically:

- **Choose the tenant/key** it connects with.
- **Select which Entra user properties to fetch.**
- **Filter the fetched results** by any of those properties, using the available
  operators — for example to import only a certain department or email domain.
- **Map Entra properties to Drupal fields.** You map each fetched property to one
  of your own Drupal (text) fields on the target entity.
- **Choose the target entity plugin** — user or node (both ship with the module).
  - For **users**: decide which **roles** incoming users get, whether they are
    **active**, and whether to send a **welcome email** to active users.
  - For **nodes**: decide **published** status and whether each update creates a
    **new revision**.
- **Decide on delta queries.** Leave delta on so subsequent syncs fetch only new
  or changed users (much faster); disable it temporarily if you change the fetched
  properties or the mapping and need a full re‑sync.
- **Schedule it on cron** if you want the user list to stay up to date
  automatically.

> **Security reminders.** Assign incoming users **least‑privilege roles** — the
> module can grant roles, so a careless mapping can over‑privilege accounts. The
> sync reads real user PII from Microsoft over the network, so run over HTTPS and
> keep the app's Graph scope at the `User.Read.All` minimum. Managed entities are
> stored in Drupal so the module can detect deactivations in Entra and block or
> unpublish the corresponding Drupal account.
