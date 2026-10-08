# Configuration

Acquia CMS Tour does not have a conventional settings form. What it provides is a
**dashboard page** — the "tour" — that acts as a one-stop onboarding checklist for
a new Acquia CMS site. Rather than holding its own settings, it gathers the setup
steps and integrations a fresh site needs and surfaces them together so you can
work through them without hunting around the admin.

## Open the tour dashboard

1. Log in as a user with permission to administer the site (an administrator by
   default).
2. Open the **Acquia CMS** section of the admin — the tour/dashboard page is
   reached from there via the admin toolbar. (The exact menu path depends on the
   rest of the distribution that is installed alongside it.)

## What you do here

The page presents the configuration steps for an Acquia CMS install as a set of
items. For each one you either enter the relevant details inline or follow the link
to the underlying settings form that owns that configuration — for example
connecting external integrations and API-driven services that other Acquia CMS
modules provide. Working down the list is how you confirm a new site has each piece
configured.

Because the tour aggregates steps that belong to **other** modules in the family,
what appears on the dashboard depends on which Acquia CMS modules are enabled on
your site. Enable the integrations you intend to use first, then return to the tour
to see and complete their steps.

## When to use it

The tour is designed for **initial setup**. Run through it once when standing up a
new Acquia CMS site to make sure nothing is left unconfigured. After the site is
live you rarely need to come back, though it remains a handy reference for checking
whether a given integration has been connected.
