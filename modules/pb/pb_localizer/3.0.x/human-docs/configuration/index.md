# Configuration

Project Browser Localizer works out of the box — the official hub is preconfigured,
so everything on this page is **optional tuning**.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Services → Project Browser Localizer**
   (`/admin/config/services/pb-localizer`).

## The settings

- **Translation badge (flags) on/off** — controls whether the small language flags
  (🇩🇪 🇫🇷 …) appear on translated module cards. These indicators show at a glance
  which modules have been localized. Turn them off if you prefer a cleaner card.
- **Translation hub** — the address of the PB Translation Hub the module fetches
  translations from. This is **preset to the official, community-held hub**
  (`pb.drupaltutorials.de`), so you can leave it alone. Point it at a **custom hub**
  only if your organization runs its own translation server.
- **Category sync** — controls fetching and caching of localized **category names**
  (for example "Access Control", "Commerce") from the hub, so the Project Browser's
  category labels appear in the user's language too.

## About the outbound requests

Because translations are fetched from the hub, the module makes **outbound network
requests** to whatever hub address is configured. With the default hub that is the
community server; with a custom hub it is your own. Only **reviewed** translations
are served (a quality gate), and the module keeps strict cache isolation between
languages so translations do not leak across languages on a multilingual site.

## Save

Click **Save configuration**. Changes take effect on the next Project Browser
load — reopen the browser to see the updated badges, hub, or category labels.
