# Configuration

Setup has three moves: choose the active provider, enter that provider's
credentials, and switch an Address field to the autocomplete widget.

## Step 1 — Choose the active provider

1. Log in as a user with the **Access administration pages** permission.
2. Go to `/admin/config/address-autocomplete-suggestion`.
3. Pick the provider that fits your region and budget:
   - **Google Maps** — broad global coverage; uses a Google API key.
   - **Mapbox Geocoding** — uses a Mapbox access token.
   - **Post.ch** — the Swiss Post address service; good for Swiss addresses, uses
     an endpoint plus basic-auth credentials.
4. Save.

## Step 2 — Enter the provider's credentials

Each provider has its own settings form at
`/admin/config/address-autocomplete/<provider>` (for example the Google or Mapbox
page). Open the one for your chosen provider and enter its credentials:

- **Google Maps** — your Geocoding API key.
- **Mapbox** — your access token.
- **Post.ch** — the endpoint URL and basic-auth username/password.

Keep these credentials out of version control. Save the form.

## Step 3 — Switch an Address field to the widget

1. Go to **Structure → Content types**, pick the content type with your Address
   field, and open **Manage form display**.
2. Set that Address field's widget to **Address autocomplete Suggestion**.
3. Save. Type into address line 1 on that form and suggestions should appear.

## Operational notes

The module exposes an internal endpoint
(`/admin/address_autocomplete_suggestion/addresses`) that takes what the user types
and asks your chosen provider for suggestions. Also worth knowing:

- Once live, **monitor your provider's usage and billing**.
- Keep your API keys and tokens **out of version control**.
- The suggestion results themselves are public geocoding data (not sensitive
  internal data).
