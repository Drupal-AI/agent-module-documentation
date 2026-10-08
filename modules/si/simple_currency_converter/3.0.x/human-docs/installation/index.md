# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- At least one **feed submodule** enabled so the module has a source of exchange
  rates (see below). Without a feed there is nothing to convert with.
- No other contrib module dependencies and no extra PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_currency_converter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_currency_converter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and a feed

Enable the base module together with at least one exchange‑rate feed submodule:

```bash
drush en simple_currency_converter ecb_scc -y
```

## Submodules — choose your feeds

| Submodule | Machine name | What it provides |
|-----------|--------------|------------------|
| **European Central Bank feed** | `ecb_scc` | Rates from the ECB (EUR‑based). The feed URL is hardcoded. |
| **FloatRates feed** | `floatrates_scc` | Rates from FloatRates (JSON). Adds its own settings form at `/admin/config/regional/simplecurrencyconverter/floatrates`, gated by the **Administer Floatrates settings** permission. |
| **Notifier** | `notifier_scc` | Emails an administrator when a conversion check fails (for example when both feeds return nothing). |

Enable at least one of `ecb_scc` or `floatrates_scc`; you can enable both and set
one as a fallback. Add `notifier_scc` if you want failure alerts:

```bash
drush en floatrates_scc notifier_scc -y
```

## After enabling

1. Grant the **Administer simple currency converter** permission to the roles that
   should configure it (**People → Permissions**).
2. Open the settings form and set the price selector, feeds, base currency, and
   cache lifetime — see [Configuration](../configuration/index.md).

## Verify it worked

Visit a page that renders prices matching your configured CSS selector, open the
currency picker, and choose a different currency — the prices should update to the
converted amounts.
