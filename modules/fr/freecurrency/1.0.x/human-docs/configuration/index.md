# Configuration

Getting Currency Converter working is a short, ordered checklist: add your API key,
sync the currency list, sync the rates, and then place the converter block. Do them
in this order the first time, since rates can only sync once currencies exist.

## Open the admin interface

1. Log in as a user with permission to administer the module (it provides its own
   permissions — grant them to trusted roles at **People → Permissions**).
2. Go to **Configuration → Web services → Administer Currency Converter
   (FreecurrencyAPI)**. You'll see three tabs: **Settings**, **Currencies**, and
   **Rates**.

## 1. Settings tab — add your API key

On the **Settings** tab, enter your **FreecurrencyAPI key** and save. This is the
credential the module uses to fetch exchange rates from the service. As noted in
[Installation](../installation/index.md), keep this key in an environment variable /
Key entity rather than committing it. Without a valid key, the currency and rate
syncs below won't succeed.

## 2. Currencies tab — sync the currency list

Open the **Currencies** tab and **synchronize** the data manually. This pulls the
list of available currencies from FreecurrencyAPI and stores them locally as
currency entities. You need this before rates will have anything to attach to.

## 3. Rates tab — sync the exchange rates

Open the **Rates** tab and **synchronize** the data manually. This fetches the
current exchange rates for your synced currencies and stores them locally.

## 4. Confirm automatic updates

Rates are meant to refresh on a schedule when **cron** runs. To confirm the
scheduled update works, go to **Reports → Status report**
(`/admin/reports/status`) and run cron, then check that rate data updates. As long as
cron runs regularly, you won't need to sync by hand again — the manual sync is mainly
for the initial setup and ad‑hoc refreshes.

## 5. Place the converter block

Go to **Structure → Block layout** (`/admin/structure/block`) and add the
**Freecurrency Converter** block to whichever region you want it to appear in. This
is the front‑end widget visitors use to convert amounts.

## Customizing the display

Currencies and rates are shown through Views, so you can adjust their presentation
freely:

- **Freecurrency Currencies** and **Freecurrency Rates** views live under **Structure
  → Views** (`/admin/structure/views`). Edit them to change columns, filters,
  sorting, or styling to suit your site.

## Using it in code

If you need conversion from your own module or template logic, call the service
directly:

```php
\Drupal::service('freecurrency.converter')->convert($value_from, $value_to, $value_amount);
```
