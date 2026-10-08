# Configuration

Islandora configuration has two parts: the **Core Settings** form (where you point
Drupal at your broker, JWT, Fedora, and upload settings) and the **Context**
configuration (where you describe how your repository objects behave). This page
covers the Drupal side of both. Nothing on this page changed in 2.19.x — the settings
form and the automation model are the same as 2.18.x.

## Core Settings form

Go to **Configuration → Islandora → Core Settings** (`/admin/config/islandora/core`).
You need the **Administer site configuration** permission. The form saves to the
`islandora.settings` configuration object.

### Message broker

- **Broker URL** *(default `tcp://activemq:61613`)* — the STOMP/AMQP broker Islandora
  publishes events to. Islandora's emit-event actions send messages here for the
  microservices to consume, so this must point at your running ActiveMQ (or
  compatible) broker. When you save the form, Islandora opens a test connection to
  verify the URL is reachable.
- **Provide user identification / User / Password** — optional broker credentials. The
  password is stored in Drupal's state (not exported config), so it won't travel with
  a config export.

### Authentication and Fedora

- **JWT Expiry** *(default `+2 hour`)* — how long the JSON Web Tokens Islandora mints
  stay valid. Those tokens let microservices call back into Drupal's media/REST
  endpoints. The value is a `strtotime`-style string.
- **Fedora URL** — the base URL of your Fedora REST endpoint (for example
  `http://fcrepo:8080/fcrepo/rest`). Setting this enables mirroring content into
  Fedora and the `fedora://` Flysystem scheme. Leave it empty if you're not using
  Fedora.
- **Fedora URL Display** — checkboxes selecting which node/media/term bundles should
  include the linked Fedora URI in their JSON-LD output.

### Uploads and behavior

- **Upload location** — the stream-wrapper directory the "Add/Upload media" and
  "Add/Upload children" wizards write to.
- **Allowed Mimetypes** — a whitelist of mimetypes those upload forms accept.
- **Node Delete with Media and Files** *(on by default)* — when a node is deleted,
  also delete its media and their files.
- **Redirect after media save** — return to the node after saving media.
- **Use multiple queries for term URI lookups** *(on by default)* — a performance
  toggle for resolving taxonomy terms to their external URIs.
- **Allow header links** *(on by default)* — emit HTTP `Link` headers that relate
  nodes, media, and files to each other, so machine clients can discover them.

### Setting values with Drush

```bash
drush cset islandora.settings broker_url 'tcp://activemq:61613' -y
drush cset islandora.settings jwt_expiry '+2 hour' -y
drush cset islandora.settings fedora_rest_endpoint 'http://fcrepo:8080/fcrepo/rest' -y
```

## The RDF mappings report

At **Reports → Islandora RDF Mappings** (`/admin/reports/islandora/rdf_mappings`) you
can review every configured field-to-RDF-property mapping and every taxonomy
term-to-URI value. It's a handy audit of the linked-data (JSON-LD) output. The core
settings form also links to the JSON-LD module's RDF namespace settings.

## The automation engine: Contexts, Reactions, and Actions

This is where Islandora's real behavior is defined, and it lives in the **Context**
module at **Structure → Contexts** (`/admin/structure/context`). Islandora doesn't
hardcode "when X happens, do Y" — you compose it:

- **Conditions** decide *when* a Context applies. Islandora ships many, such as "node
  is an Islandora object", "node has term", "node has parent", "media has mimetype",
  and "uses filesystem". The term-based conditions match against a taxonomy term's
  external URI (`field_external_uri`).
- **Reactions** decide *what* happens. Key ones are **Derivative** (generate
  derivatives), **Index** (push to Search API), **Delete**, and reactions that alter
  the view mode, form display, or JSON-LD type.
- **Actions** are what the Reactions run — usually emitting an event message to the
  broker (for a microservice to process) or indexing to Search API.

### A typical setup

1. Create taxonomy terms for your **models** (Image, Video, Paged Content, …) and for
   **media use** (Original File, Service File, Thumbnail), and set each term's
   `field_external_uri` to the standard Islandora URI.
2. Build a Context: for example, Condition *node has term = Image* → Reaction
   *Derivative* running the image-derivative action from the `islandora_image`
   submodule.
3. Make sure your broker and microservices are running, so the events Islandora emits
   are actually picked up and processed.

## Permissions

Islandora Core defines only three permissions; most access is governed by core
node/media/taxonomy permissions:

- **View checksums** — see file checksum/fixity values in the UI.
- **Manage members** — use the "Add child" / "Batch upload children" tools and the
  manage-members view (actual node creation still needs core create permission).
- **Manage media** — use the "Add media" / "Batch upload media" tools and the
  manage-media view (actual media creation still needs core create permission).

The REST media-source endpoints used by microservices are gated by core `update
media` / node `update` / `create media` permissions, not by these three.
