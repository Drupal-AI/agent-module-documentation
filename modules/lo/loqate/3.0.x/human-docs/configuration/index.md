# Configuration

Loqate has two settings forms, both under **Configuration → Web services →
Loqate API** and both requiring the **Administer Loqate API**
(`administer loqate api`) permission.

## 1. Choose the API key

1. Go to **Configuration → Web services → Loqate API**, or navigate directly to
   `/admin/config/services/loqate-api`.
2. The form has a single **Key** selector. Pick the Key entity that holds your
   Loqate API key (the one you created during
   [installation](../installation/index.md)).
3. **Save.**

That's all the base setup requires. From now on the module resolves the selected
Key's value whenever it renders an address element. Individual field widgets and
Webform elements can override this with a *different* Key entity if you need one;
when they don't specify one, this default key is used.

> **Security reminder.** Because Loqate's lookup runs in the browser, the key's
> value is sent to the page. Use a Loqate key restricted to your domain(s), and
> keep the key itself in an environment variable / Key entity rather than plain
> config.

## 2. Map Loqate fields to your address fields

1. Go to **Configuration → Web services → Loqate API → PCA address**, or navigate
   directly to `/admin/config/services/loqate-api/pca-address`.
2. You'll see a draggable table. Each row connects one **address element** on
   your form to one **field in Loqate's response**, and sets how that value is
   used.

Each row has these parts:

- **Address element** — the address field on your form, such as *locality*
  (city), *postal_code*, *address_line1*, *country_code*, *organization*,
  *dependent_locality*, or *administrative_area*.
- **Loqate field** — the name of the field in Loqate's result to pull from, such
  as *City*, *PostalCode*, *Line1*, *Line2*, or *Company*. Leave it empty to map
  nothing.
- **Mode** — how the value is applied:
  - **None** — the mapping is inactive.
  - **Search** — this field feeds the lookup search.
  - **Populate** — the returned value fills this field (the common choice).
  - **Default** — used as a default value.
  - **Preserve** — keep the user's existing value.
  - **Country** — treat the value as the country.
- **Enabled** — whether this row is applied at all.
- **Weight** — drag the rows to control their order.

Out of the box the module enables sensible defaults: City → locality,
PostalCode → postal code, Line1/Line2 → address line 1/2, and Company →
organization (all set to **Populate**), with the remaining rows disabled. For
most sites you can leave these as they are.

3. **Save** when you're happy with the mapping.

## Per‑widget / per‑element overrides

When you use the **PCA Address** field widget or the `pca_address` form element
directly, you can override both the API key (by naming a different Key entity) and
the field mapping (`#pca_fields`) and options (`#pca_options`, e.g. restricting
suggestions to certain countries or showing a "enter address manually" link) on
that specific instance. Anything you don't override falls back to the site‑wide
settings on these two forms.

## One more thing: the external SDK

The address autocomplete loads Loqate's JavaScript from the fixed host
`api.addressy.com`. If your site enforces a Content Security Policy, allow that
host (or self‑host the asset), otherwise the lookup won't load in the browser.
