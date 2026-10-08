# Configuration

DaData API's configuration is small: connect the module to your DaData account by
supplying your **API token**. From there, the Base, Cleaner, and Suggestions APIs
are available to your code.

## Open the settings form

1. Log in as a user with the permission to administer the module (an administrator
   by default).
2. Go to the DaData API settings form in the **Configuration** area (the
   `dadata_api.settings` route).

## Enter your credentials

- **API token** — the token from your [dadata.ru](https://dadata.ru/) account.
  This authenticates every request the module makes to DaData. **Treat it as a
  secret:** keep it out of version control. Where your workflow allows, supply it
  from an environment variable rather than committing it in a config export (for
  DDEV, `ddev dotenv set .ddev/.env …` and then reference the variable).

Save the form. Once the token is set, the module can call DaData on your behalf —
the **Base API** (version, balance, usage statistics), the **Cleaner API** (data
standardization and correction), and the **Suggestions API** (directory search,
nearest address, IP location).

## Privacy and data flow

Remember that DaData is an **external service**. Whatever values you send for
cleaning or suggestions — addresses, company names, and similar — **leave your
site and go to DaData**. Account for this in your privacy policy, and only send the
data you actually need enriched.
