# Configuration

Entity View Redirect is administered through the site's **Configuration** area (it
adds its own admin page, reachable to roles that hold the module's administration
permission). There you decide, per supported entity type, whether its canonical
view page should be redirected and where to.

## What you configure

- **Which entity types redirect.** The module targets the core **Node**,
  **Taxonomy term**, and **User** view pages. Enable the redirect for the entity
  types whose view pages you want to skip; leave the others alone so they render
  normally.
- **Where they redirect to.** For each enabled type, choose the destination:
  - the entity's **edit form**, which is the typical choice for records you manage
    only through their form; or
  - a **custom internal URL / path** — useful when the real page for that content
    is built elsewhere (for example a Views-based listing or detail page).

## Notes and cautions

- The redirect target is set here by an administrator, not taken from the incoming
  request, so this is not an open-redirect surface.
- Redirecting a view page is site-wide for the entity types you enable. Before
  turning it on, confirm that no audience legitimately needs the normal rendered
  view page for that entity type — otherwise those users will be redirected too.
- Because the effect is global for the chosen types, test on a staging copy first
  and document why the redirect was added, so future maintainers understand the
  behaviour.

After saving, visit an affected entity's view page to confirm the redirect sends
you to the intended destination.
