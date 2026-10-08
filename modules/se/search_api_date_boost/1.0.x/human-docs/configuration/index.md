# Configuration

Search API Date Boost is configured entirely from within your Search API index —
there is no separate settings page. You enable one processor and then tune it for
each date field. These screens are gated by Search API's own admin permissions, so
you'll need a role that can administer Search API.

## Enable the processor

1. Go to **Administration → Configuration → Search and metadata → Search API**.
2. Edit the index you want to affect (it should use the **Database** backend).
3. Open the **Processors** tab.
4. Tick **Date field-based boosting** to enable it.

Only date fields that are already added to the index will be available to boost,
so make sure the relevant date field is part of the index's fields first.

## Per-field settings

Once the processor is enabled, its settings list every field on the index whose
type is *date*. For each one you can set two values:

- **Boost factor** — a dropdown of Search-API-style values (`0.00`, `0.10`,
  `0.20`, … `1.00`, … up to `21.00`). This is the maximum lift the field can give:
  the full amount a future-dated or just-now item receives. Setting a field's
  factor to `0.00` effectively switches boosting off for that field.
- **Decay period (days)** — default **30**. This controls how quickly the boost
  fades for past-dated content. A **larger** value decays slowly, so older items
  keep more of their lift (good for evergreen-ish content). A **smaller** value
  decays sharply, strongly favouring only the very freshest items (good for
  fast-moving news).

You can give each date field its own factor and decay period — for example a
different recency weighting on a *start date* field than on an *end date* field.

## How the boost is calculated

For each item and each configured field the processor:

1. Works out the age in days: `age_days = (now − date_value) / 86400`. If the
   field holds several values, it uses the **most recent** one.
2. If the date is in the **future** (`age_days < 0`), the boost is the full
   **boost factor**.
3. If the date is in the **past**, the boost is
   `boost_factor × exp(−age_days / decay_period)`, capped at the boost factor —
   so it starts high and decays with age.
4. The result is **added** to the item's existing boost, and only when both the
   decay period and the boost factor are greater than zero.

This means recency ranking layers on top of Search API's own full-text relevance
and any other field boosts, rather than replacing them.

## Save and re-index

Click **Save** on the index, then **re-index** your content so the new boosts are
written into the index. Until you re-index, the changed weights won't take effect.
