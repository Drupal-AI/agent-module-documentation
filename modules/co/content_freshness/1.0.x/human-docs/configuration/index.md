# Configuration

Setting up Content Freshness Indicator is a two‑part job: set the thresholds and
enable content types on the settings form, then place the badge on each content
type's display.

## Open the settings form

1. Log in as a user with the **Administer Content Freshness Indicator**
   permission (`administer content freshness`; an administrator by default).
2. Go to **Administration → Configuration → Content → Content Freshness
   Indicator**.

## Set the freshness thresholds

The badge has three tiers, and you control where each one begins by setting day
thresholds:

- **Fresh threshold** — the number of days after the last update during which
  content counts as **Fresh** (green).
- **Aging threshold** — the number of days after which content moves to **Aging**
  (yellow). Content older than the Aging threshold is treated as **Stale** (red).

So content is Fresh up to the Fresh threshold, Aging between the two thresholds,
and Stale beyond the Aging threshold. You can set these globally and override them
**per content type**, so different types can age at different rates.

## Enable the content types

Choose which content types should show the freshness badge. Only enabled types get
a badge; leave a type off and its content shows nothing.

## Save

Click **Save** to store the thresholds and enabled types.

## Position the badge on the display

The badge is exposed as a **pseudo‑field**, so you decide where it appears through
the normal display settings:

1. Go to **Structure → Content types → *(your type)* → Manage display**.
2. Find the **Content Freshness** pseudo‑field and drag it out of the *Disabled*
   region into the position you want (for example near the title or at the top of
   the body).
3. Save the display.

Now content of that type shows the color‑coded badge, along with the relative
"Updated N days ago" text, in the position you chose. The badge includes ARIA
labels so it remains accessible to assistive technology.
