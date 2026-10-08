# Configure Islandora Core

## Core settings form

Route `system.islandora_settings` → `/admin/config/islandora/core` (`IslandoraSettingsForm`), requires
`administer site configuration`. Writes the `islandora.settings` config object. There is also a menu hub at
`/admin/config/islandora` (`system.admin_config_islandora`).

### Fields → `islandora.settings` keys

| Form field | Key | Default | Meaning |
|---|---|---|---|
| Broker → URL | `broker_url` | `tcp://activemq:61613` | STOMP/AMQP broker for emitted events. |
| Broker → Provide user identification / User / Password | `broker_user` / `broker_password` | — | Optional broker credentials (password uses core `state`, not config). |
| JWT Expiry | `jwt_expiry` | `+2 hour` | Lifetime of JWTs minted for microservice callbacks (`strtotime`-style). |
| Upload location | `upload_form_location` | — | Stream-wrapper dir for the Add/Upload media & children wizards. |
| Allowed Mimetypes | `upload_form_allowed_mimetypes` | — | Whitelist for those upload forms. |
| Node Delete with Media and Files | `delete_media_and_files` | `TRUE` | Deleting a node also deletes its media + files. |
| Redirect after media save | `redirect_after_media_save` | — | Return to the node after saving media. |
| Use multiple queries for term URI lookups | `fast_term_queries` | `TRUE` | Performance toggle for term→URI resolution. |
| Fedora URL | `fedora_rest_endpoint` | — | Fedora REST base; enables Fedora sync/flysystem `fedora://`. |
| Fedora URL Display (checkboxes) | `gemini_pseudo_bundles` | `[]` | Node/media/term bundles whose JSON-LD should include the linked Fedora URI. |
| Allow header links | `allow_header_links` | `TRUE` | Emit HTTP `Link` headers relating nodes↔media↔files. |

The form also links to the JSON-LD module's RDF namespace settings (`system.jsonld_settings`).

### Set with Drush (examples)

```bash
drush cset islandora.settings broker_url 'tcp://activemq:61613' -y
drush cset islandora.settings jwt_expiry '+2 hour' -y
drush cset islandora.settings fedora_rest_endpoint 'http://fcrepo:8080/fcrepo/rest' -y
```

## RDF mappings report

Route `system.islandora_rdf_mappings` → `/admin/reports/islandora/rdf_mappings`
(`RdfMappingsReportController`), requires `administer site configuration`. Lists configured Drupal
field→RDF-property mappings and taxonomy term→URI (`field_external_uri`) values — useful for auditing the
linked-data output produced with the `jsonld` module.

## What the settings drive

- `broker_url` (+ optional user/password) configures the STOMP connection (`StompFactory`) used by the
  emit-event Actions.
- `jwt_expiry` is used by `JwtEventSubscriber` to sign tokens so microservices can call back into Drupal's
  media/REST endpoints (see [../api/services.md](../api/services.md)).
- `allow_header_links` toggles the `MediaLinkHeaderSubscriber` / `NodeLinkHeaderSubscriber`.
- `delete_media_and_files` interacts with the Delete reaction and the confirm-delete forms.
