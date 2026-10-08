# Configuration

JSON-LD Generator is configured per content type from a single settings form, plus
an optional per-node override field. The whole point is that no custom code is
needed — you choose which content types get structured data and which Schema.org
type each represents, and the module handles the rest.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default).
2. Go to **Configuration → Search and metadata → JSON-LD Generator**.

## Enable JSON-LD per content type

The form lists your content types. For each one:

- **Enable JSON-LD** — tick the content type to turn structured-data generation on
  for it. Leave the others off; only enabled types get JSON-LD.
- **Schema.org `@type`** — choose the type that best describes the content. The
  supported types are **Article**, **BlogPosting**, **NewsArticle**, **Product**,
  **Event**, **FAQPage**, **Organization**, **Person**, **LocalBusiness**, and
  **WebPage**. For example, pick *Article* for a news content type or *Product*
  for a catalogue item.

Click **Save configuration**. When you save, the module automatically:

- creates the shared `field_schema_jsonld` field storage if it does not exist;
- attaches that field to each enabled content type;
- configures the form and view displays; and
- begins injecting JSON-LD into the `<head>` whenever an enabled node is viewed.

## Automatic field mapping

For each enabled type, the module maps standard node fields to Schema.org
properties without any extra setup:

| Node field | Schema.org property |
|------------|---------------------|
| Title | `headline` |
| Created date | `datePublished` |
| Updated date | `dateModified` |
| Body | `description` |

## Per-node custom JSON-LD

Each enabled content type also gets a **Custom JSON-LD** field on the node edit
form. It is optional — leave it empty and the node uses the automatically
generated schema. Use it when a particular node needs extra or different
properties:

- Whatever you enter is **merged** with the generated schema, so you only need to
  add the pieces that differ.
- The custom JSON is **validated before the node is saved** — if it is not valid
  JSON, Drupal blocks the save, so invalid structured data can't be published.

## Save

Save the settings form after enabling content types and choosing their types, and
save each node after editing its Custom JSON-LD field. View a node and check the
page source to confirm the `<script type="application/ld+json">` block reflects
your configuration.
