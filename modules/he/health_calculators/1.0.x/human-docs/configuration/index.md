# Configuration

The umbrella `health_calculators` module has nothing to configure itself — all of
the settings belong to the calculator submodule you enabled. This page covers the
**Caffeine Calculator**, the calculator bundled with this release.

## Configure the drink list

1. Log in as an administrator and go to **Configuration → Development tools →
   Caffeine Calculator** (`/admin/config/tools/caffeine-calculator`).
2. Configure the **list of drinks** together with the amount of caffeine each
   one contains. This is the data the public form uses: when a visitor picks a
   drink and enters a serving size, the calculator uses these values to estimate
   the caffeine in that serving.
3. Save.

## The public calculator form

Once the drinks are set up, the calculator is available to visitors at
`/body-calculators/caffeine-calculator`. There a visitor:

- selects a **drink** from your configured list,
- enters the **size** of their serving, and

then sees the estimated caffeine for that serving, plus a **recommended daily
caffeine amount** worked out from the age, weight, and any restricting medical
condition they provide.

Because the form is public, place a link to it wherever it fits your site (a menu
item, a block, or a body link), and — given this is an indicator, not medical
advice — consider adding a short disclaimer nearby.

## Adding more calculators later

Body Health Calculators is designed as a package that will gain more calculators
over time. When additional calculator submodules become available, enable the one
you want (it will pull in this parent automatically) and configure it from its own
settings page under **Configuration**.
