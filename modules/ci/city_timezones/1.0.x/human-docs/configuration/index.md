# Configuration

City Timezones works out of the box — the settings here are **optional tuning** to
make the city list shorter and more relevant to your audience. The default list
(GeoNames `cities500`) is large, so most sites will want to narrow it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → City Timezones**, or navigate
   directly to `/admin/config/regional/city-timezones`.

## Settings

### Countries to include

Restrict the city list to one or more countries (by GeoNames country code). If your
users are all in a handful of countries, limiting the list here makes the selector
far quicker to scan and search. Leave it unrestricted to offer worldwide cities.

### Minimum city population (list size)

Choose a minimum-population threshold so only larger cities appear. A higher
threshold (for example, cities over 15,000 people) produces a shorter, faster
dropdown; a lower threshold includes many smaller towns at the cost of a bigger
list. There is also a **custom** option if you want to set your own population
value rather than pick from the presets — useful for tuning the balance between
coverage and list length.

### Use Chosen

Toggle whether the city selector is enhanced with the **Chosen** searchable
dropdown. With it on, users type to filter cities; with it off, the selector falls
back to a plain HTML `<select>`.

## Save

Click **Save configuration**. Reload the account form and check the city selector
now reflects your country and population choices.

> **Tip:** a shorter list isn't just cosmetic — it also means the JSON endpoint that
> feeds the selector returns less data, so trimming by country and population keeps
> the widget snappy on large sites.
