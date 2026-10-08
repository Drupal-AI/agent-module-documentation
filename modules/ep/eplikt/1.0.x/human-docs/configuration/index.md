# Configuration

e-Plikt is configured on a single settings page where you identify your
organisation, set default access rights, and choose which content sources feed the
legal‑deposit RSS export.

## Open the settings form

1. Log in as a user with permission to administer the site's configuration.
2. Go to **Configuration → Web services → e-Plikt**, or navigate directly to
   `/admin/config/services/eplikt`.

## The main settings

- **Publisher unique identifier** — your organisation's identifier, in the form
  `http://id.kb.se/organisations/SE+ev.[-suffix]`. This tells the receiving
  institution (the National Library) who the deposited material comes from, so enter
  the exact value assigned to your organisation.
- **Access rights (default)** — the default access‑rights value applied to the
  exported items. Set this to match the rights that should accompany your deposited
  content.
- **Sources** — tick the content sources you want to enable. The module ships with
  a **Node** source and a **Media** source; enable whichever ones hold the material
  that falls under your mandatory‑delivery obligation.

Click **Save** once these are set.

## Per‑source options appear after saving

After you save the form **with at least one source enabled**, the page reveals
**additional configuration options for each selected source**. Return to the form to
fine‑tune how each source is exported (for example which content it draws in).
Configure each enabled source so that only the intended mandatory‑delivery items are
included.

## Source plugins

For most sites the built‑in **Node** and **Media** sources are enough. If you have a
complex content structure, or embedded content that must be part of the delivery,
you can write your own source plugin — the shipped plugins under
`Drupal\eplikt\Plugin\eplikt` and the `Drupal\eplikt\EpliktSourceBase` base class
are the templates to follow. (This is a developer task; see the
[`agent/`](../start.md) docs for the code‑level detail.)

## Mind who can read the feed

The RSS feed exposes the selected entity content and its downloadable media to
whoever can reach it. If the material is not intended to be public, restrict access
to the feed (for example at the web‑server or access‑control layer) so only the
receiving institution can harvest it, and double‑check that the enabled sources
include only the items you actually mean to deposit.

## Save

Save the form, then load the generated RSS feed and confirm it contains the expected
items and media before handing the feed URL to the receiving institution.
