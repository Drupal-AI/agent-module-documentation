# Configuration

Schema.org Mapper has two configuration surfaces: a **read‑only overview** page
under the admin menu, and the **per‑bundle Schema.org Mapper tab** where you
actually build mappings. All mapping changes require the restricted **Administer
Schema.org Mapper** (`administer schema_org_mapper`) permission — grant it only to
trusted roles, since it controls what structured data your site publishes.

## The overview page (read‑only)

Go to **Configuration → Search and metadata → Schema.org Mapper**
(`/admin/config/search/schema-org-mapper`). This page is informational only: it
gives you a status overview of the module. You cannot change any mapping here —
that is done on the per‑bundle tabs.

## Map a bundle

The submodules you enabled (Node, Taxonomy, Block, Views) each add a **Schema.org
Mapper** tab to their bundles. Open the bundle you want to describe — for example a
content type, a vocabulary, a custom block type, or a View display — and click its
**Schema.org Mapper** tab.

On that tab:

1. **Choose the Schema.org type.** Add one or more types that apply to the bundle
   (Product, Article, Event, Place, and so on) from the curated catalog of 43 types
   and 155 properties. The most‑used types appear first.
2. **Map each property to a source.** For every property, pick where its value comes
   from:
   - **An entity field** — select one of the bundle's own fields from a list.
   - **A fixed value** — type a constant, such as `USD`.
   - **A token** — use a token such as `[node:title]` or `[site:name]`.
   Sources can be combined. Any property you leave unmapped is simply omitted from
   the output, keeping the markup aligned with the visible page.
3. **Build nested objects if needed.** Properties such as `offers →
   priceSpecification`, `brand`, `address`, or `geo` render as collapsible sections.
   A child object is only emitted when at least one of its sub‑properties has a
   value, so you never get empty stubs.
4. **Ordered lists.** For `FAQPage` and `BreadcrumbList` you can build ordered
   multi‑value lists — either from a repeater field (one item per referenced entity)
   or from parallel multi‑value fields aligned by position, which is numbered
   automatically.
5. **Save.** The JSON‑LD is emitted in the page `<head>` at render time. The render
   cache is invalidated when you change the configuration, so updates appear on the
   next page load.

## Output control and normalization

The module normalizes values before output automatically: images and files become
absolute URLs, media references resolve to the file URL, entity references become a
canonical URL or label, links become URLs, dates become ISO‑8601, rich text becomes
clean plain text, and numbers and prices are formatted the way Google expects. You
can also choose how the output is grouped — a single `@graph` containing every type
(recommended), or one JSON‑LD block per type.

## Check the result

Visit a page of the bundle you mapped, view its source, and confirm a JSON‑LD block
in the `<head>` carries your type and values. Running the URL through Google's Rich
Results Test or Schema Markup Validator is the quickest way to confirm the output is
valid. Because output is generated read‑only from existing content and there are no
anonymous or mutating endpoints, the module is safe from a structured‑data
standpoint as long as the `administer schema_org_mapper` permission stays with
trusted users.
