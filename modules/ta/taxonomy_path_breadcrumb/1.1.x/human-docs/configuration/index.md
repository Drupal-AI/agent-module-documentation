# Configuration

Taxonomy Path Breadcrumb has no global settings page. You configure it per
**vocabulary**, on the vocabulary edit form, and the choice is saved with that
vocabulary's configuration (so it deploys with your site config).

## Set the breadcrumb builder for a vocabulary

1. Log in as a user with the **Administer vocabularies and terms** permission (an
   administrator by default).
2. Go to **Structure → Taxonomy**, then **Edit** the vocabulary you want to
   change (`/admin/structure/taxonomy/manage/<vocabulary>`).
3. Find the **Breadcrumb builder settings** section and the **Select Breadcrumb
   Service** dropdown.

The dropdown has two options:

- **Default** (`taxonomy_term.breadcrumb`) — Drupal's standard behavior. The
  breadcrumb is built from the term's parent hierarchy within the vocabulary.
  This is also what applies when you have never touched the setting.
- **Path based, Drupal core** (`system.breadcrumb.default`) — the breadcrumb is
  built from the URL/path (the core path‑based breadcrumb). Choose this when your
  term pages sit under a section path or use aliases that mirror your site's
  navigation, so the breadcrumb reflects the URL rather than the term tree.

4. Click **Save** on the vocabulary form.

The change takes effect immediately on that vocabulary's term pages. Other
vocabularies are unaffected — each one carries its own choice, so you can use
different strategies across the site and switch a vocabulary back to *Default* at
any time without uninstalling anything.

## How it works (in brief)

The module registers one high‑priority breadcrumb builder that only acts on
taxonomy term pages. On such a page it reads the vocabulary's saved choice and
hands the actual breadcrumb building to the matching core service. There is no
custom breadcrumb rendering — it simply picks which core builder runs, so an
un‑opted vocabulary behaves exactly as core does today.
