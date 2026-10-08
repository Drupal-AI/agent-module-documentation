# Configuration

Setting up HAL Publications 4.x has three parts: the **module settings** (what to
query and how to talk to HAL), the **Hal Author** entities (who the publications
belong to), and the **blocks** that display the lists. Open the settings as a user
with permission to administer site configuration.

## Module settings

The settings form (in the **Configuration** area of the admin menu) is deliberately
short:

- **Portals** — which HAL portal(s) to query. HAL is organized into portals for
  institutions and communities; pick the one(s) whose publications you want to show.
- **Collections** — the HAL collection(s) to pull from within those portals, to
  narrow the results to a specific lab, project, or group.
- **SSL toggle** — whether to verify the SSL/TLS certificate when calling the HAL
  API. **Leave verification enabled in production.** Disabling it makes the site
  accept an unverified certificate, which undermines the security of the connection;
  only consider turning it off temporarily in a broken local/dev network, never on
  a live site.
- **API timeout** — how long to wait for the HAL API to respond before giving up.
  Raise it if HAL is slow and lists are timing out; keep it modest so a slow API
  doesn't hang your pages.

Save the form when you're done. Note that HAL caps API results at **10,000 rows**,
so extremely broad queries are truncated at that limit.

## Hal Author entities

In 4.x, publications are attributed through a dedicated **Hal Author** content
entity that is independent of Drupal user accounts. Create a Hal Author for each
person (or migrate your existing author data) before you place author-specific
blocks, so the module knows whose publications to fetch.

## Placing and sorting publication blocks

Publications are shown through **blocks** you place at **Structure → Block layout**:

1. Place a HAL Publications block in the region where you want the list to appear.
2. In the block's configuration, choose a **sort option** from the predefined set —
   newest first, oldest first, author A–Z, or title A–Z.
3. The list comes with built-in **pagination** and standard **filters** (by author,
   by year, and free-text search) for visitors to narrow the results.
4. Save the block, then clear caches if you don't see your changes immediately.

## Citation styles

The module renders each publication using a shared, fixed set of HAL API fields
across four citation styles — **APA 7, MLA 9, Vancouver, and Harvard** — so output
is consistent regardless of which style you display.

## Verify

Load a page with a HAL Publications block and confirm the list populates from HAL,
sorts the way you selected, paginates, and formats citations correctly. If it's
empty, re-check portals/collections, the API timeout, and that the relevant Hal
Author entities exist.
