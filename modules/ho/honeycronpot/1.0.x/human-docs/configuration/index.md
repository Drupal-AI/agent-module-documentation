# Configuration

Honeycronpot needs **no configuration to work** — as soon as it's enabled and cron
runs, it starts rotating the Honeypot field name automatically. Everything on this
page is optional fine‑tuning.

## Where the settings live

The module's options sit alongside Honeypot's own settings under **Configuration →
Content authoring → Honeypot configuration**. Open that page to review or adjust
how the rotated field name is built.

## What you can adjust

- **Field‑name prefix** — the fixed leading text used when the module generates a
  new honeypot field name. Adjust it only if the default clashes with something on
  your forms; most sites can leave it as is.
- **Base names** — the set of base words the module draws from when it composes the
  rotated field name. Customising these lets you adapt the generated names to your
  site's conventions and keeps them unpredictable to bots.

After changing anything, save the form. The new prefix and base names take effect
on the next rotation (the next cron run).

## How the rotation is triggered

There is nothing to schedule inside the module — it hooks into Drupal's normal
cron. Each qualifying cron run updates the honeypot field name to a fresh value, so
the more regularly cron runs, the more often the name moves. Keep the honeypot
protection meaningful by leaving Honeypot's own protections (its time‑based checks
and the honeypot field itself) enabled; Honeycronpot complements them rather than
replacing them.
