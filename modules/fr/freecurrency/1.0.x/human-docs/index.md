# Currency Converter (FreecurrencyAPI) — manual setup guide

**Currency Converter (FreecurrencyAPI)** (`freecurrency`) adds currency conversion to
your site using the [FreecurrencyAPI](https://freecurrencyapi.com/) service. It
fetches live exchange rates, stores them locally, and provides a ready‑made block for
converting amounts between currencies — handy for shops, price lists, and any site
whose audience spans more than one currency.

Rather than call the remote service on every page load, the module keeps a local copy
of currencies and exchange rates. Those rates refresh on a schedule when **cron**
runs, and you can also refresh them **manually** from the module's administrative
interface. Under the hood, currencies and currency rates are modelled as **entities**,
and the converter is displayed through **Views**, so you can customize how everything
looks. There's also a converter block you place wherever you like.

The one thing you must supply is a **FreecurrencyAPI key**. Because that's a secret,
store it securely (backed by an environment variable / Key entity) and never commit
it to version control. The module supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — entering your API key, syncing
   currencies and rates, and placing the converter block.

## Where it lives in the admin menu

The module's admin interface is at **Administration → Configuration → Web services →
Administer Currency Converter (FreecurrencyAPI)**, with **Settings**, **Currencies**,
and **Rates** tabs. See [Configuration](configuration/index.md).

## How to use it

Once configured (API key added, currencies and rates synced), place the **Freecurrency
Converter** block at **Structure → Block layout** wherever you want visitors to
convert amounts. You can tailor the currency and rate listings by editing the
**Freecurrency Currencies** and **Freecurrency Rates** views under **Structure →
Views**.

You can also use the converter from your own code as a service:

```php
\Drupal::service('freecurrency.converter')->convert($value_from, $value_to, $value_amount);
```

> **Tip:** To see the module in action with sample data, the Drush command
> `drush freecurrency-seeding` generates demonstration data.
