# Configuration

Starrating has no central settings page. You configure it per field, using Drupal's
Field UI: add a **Star rating** field, choose how editors enter the score, and choose
how it displays.

## Add a Star rating field

1. Go to the bundle you want to rate — for example **Structure → Content types →
   [your type] → Manage fields** (`/admin/structure/types/manage/<type>/fields`).
2. Click **Create a new field** (or **Add field**) and choose **Star rating** as the
   field type.
3. Give it a label (e.g. "Food", "Overall rating") and continue.

## Field setting: maximum rating value

On the field's settings you'll find one option:

- **Maximum rating value** (`max_value`) — the top of the scale, from **1 to 10**
  (default **10**). Set it to 5 for a classic five‑star field, or to whatever suits
  your rating. This defines how many positions the score can go up to.

Save the field settings.

## How editors enter a rating

Starrating uses a **select‑list widget**: on the entity's edit form the editor picks a
whole number from **0 up to the maximum**, where **0** means "Not selected" (no
rating). You set this on **Manage form display**; there are no extra widget options —
it's just the drop‑down.

## Choose how the rating displays

On the bundle's **Manage display** screen (`…/display`), pick one of three formatters
for the field:

### Icons (the "Star rating" formatter)

Renders the score as a row of icons. It has three options:

- **Icon type** — the icon set to use. There are 17 choices: *star*, *starline* (an
  outlined star), *check*, *heart*, *dollar*, *smiley*, *food*, *coffee*, *movie*,
  *music*, *human*, *thumbsup*, *car*, *airplane*, *fire*, *drupalicon*, and *custom*.
  Pick one that fits the meaning of the rating — hearts for "loved it," fire for
  "spiciness," dollars for a price level, and so on.
- **Icon color** — one of **eight** color variants (1–8) for the icon set.
- **Fill blank** — when on, the display also draws the *empty* icons from the score up
  to the maximum (for example, 3 filled stars followed by 2 empty ones on a 5‑star
  field). When off, only the filled icons appear.

### Value

Prints the raw number — just the score, with no icons.

### Value / rating

Prints the score as `rate/max` — for example **8/10** — which is handy where a compact
text rating reads better than icons.

Save the display settings.

## Multiple rating fields and view modes

Because these are ordinary fields, you can:

- Add **several independent rating fields** to one content type — for instance
  separate *Food*, *Price*, and *Service* scores, each with its own icon set.
- Use **different formatters in different view modes** — say icons on the full page and
  the plain `8/10` text in a teaser or a View.

## Custom icons (for themers)

If none of the built‑in sets fit, choose the **custom** icon type and override its CSS
in your theme to point at your own icon images. Each icon set is a small CSS‑only
library, so you can also restyle any of the built‑in sets by overriding its CSS. See
the [`agent/`](../agent/start.md) docs' theming notes for the exact library and theme
hook names.
