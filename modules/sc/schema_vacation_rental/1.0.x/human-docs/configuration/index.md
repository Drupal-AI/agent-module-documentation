# Configuration

Schema.org VacationRental has no settings form of its own. It adds a
**VacationRental** type to the Schema.org Metatag framework, and you configure it
from Metatag's settings screens by pointing each property at a value from your
content — usually node tokens.

## Set up the VacationRental mapping

1. Log in as a user who can administer meta tags (an administrator by default).
2. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`).
3. Edit the content type you use for your rental listings (or add a new default
   meta tag configuration for that entity type and bundle).
4. Expand the **Schema.org: VacationRental** fieldset.
5. Fill in the `@VacationRental` fields with node tokens (or fixed values) so each
   property draws from the listing's real content.
6. Save the configuration.

For the full list of properties the `VacationRental` type supports, see
<https://schema.org/VacationRental>.

## How to check the result

Visit one of your rental pages and view its source (or run the URL through Google's
Rich Results Test). A JSON‑LD block in the `<head>` should now contain a
`VacationRental` entry populated with your mapped values.

Keep the mapped values accurate to the listing — structured data should match what
a visitor actually sees. The module grants no special access and stores nothing
beyond the mapping configuration.
