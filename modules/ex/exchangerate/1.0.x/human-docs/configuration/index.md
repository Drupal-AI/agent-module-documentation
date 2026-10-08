# Configuration

Exchange Rate needs a little setup before it can show anything: it must know your
API key so it can fetch rates. After that, you place one or both blocks and tune
how they look.

## 1. Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Exchange Rate Settings**.

On this form you set:

- **API Key** — paste the key you obtained from ExchangeRate‑API. This is
  required for the module to fetch any rates. Treat it as a secret (see the
  installation note about keeping it out of version control).
- **Base Currency** — the currency all rates are expressed against. Defaults to
  **USD**.
- **Enable Cache** — turn caching on or off. With caching on, the module stores
  the latest rates in Drupal's cache and reuses them until they expire, which
  avoids an API call on every page load and keeps pages fast.
- **Cache Duration** — a numeric value for how long cached rates stay valid
  (default **1**).
- **Cache Unit** — whether that duration is counted in **minutes** or **hours**.

Click **Save configuration**. When the cache expires, the module fetches fresh
rates on the next request and stores them again. If you disable caching, it
fetches live rates on every page load — simpler, but slower and heavier on your
API quota.

## 2. Place the Exchange Rate Block

This block displays live rates for the currencies/countries you choose.

1. Go to **Structure → Block layout → Place block**.
2. Find **Exchange Rate Block** and place it in the region you want.
3. In the block's configuration form:
   - **Base Currency Display** — enable or disable showing the base currency.
   - **Description Text** — optional text shown above the rates.
   - **Layout** — choose one of the bundled layouts (layout‑1 through layout‑4).
   - **Countries** — select which countries/currencies to display, and drag the
     rows to set their order.
   - **Cache Duration** and **Cache Unit** — per‑block caching for its API calls,
     in minutes or hours.
4. **Save block**. The block renders immediately with the selected rates.

## 3. Place the Currency Conversion Block

This block gives visitors an interactive converter.

1. Go to **Structure → Block layout → Place block**.
2. Find **Currency Conversion Block** and place it in a region.
3. **Save block**.

The block renders a form where a visitor enters an amount, submits it, and sees
live conversion results from the selected base currency into multiple target
currencies — all via AJAX, without a full page reload.

## Theming and extensibility

You can override the module's Twig templates and add custom CSS/JS for a tailored
look. Developers can also implement `hook_exchangerate_countries_alter()` to add,
change, or remove the list of countries the module offers.
