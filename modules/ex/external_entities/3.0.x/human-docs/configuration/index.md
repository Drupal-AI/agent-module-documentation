# Configuration

Configuring External Entities means **defining an external entity type**: telling
Drupal where the data lives, how to read it, and how each remote field maps to a
Drupal field. There is no single global settings form — the work happens per type.

## Where to configure

1. Log in as a user with the **`administer external entity types`** permission.
2. Go to **Structure → External entity types** and add a new type (or edit an
   existing one).

## 1. Name the external entity type

Give the type a label and machine name, just as you would a content type. This is
the entity type your remote records will appear as throughout Drupal (in Views,
references, and view modes).

## 2. Choose a storage client

The **storage client** is the plugin that knows how to fetch (and, where supported,
write) the data. The base module provides a **REST** client for API sources; the
**xnttsql** submodule adds a **SQL database** client, and further clients are
available as add-ons. Configure the client for your source — for a REST source that
typically means the endpoint URL and any request parameters or headers.

- Point the client at your source. Prefer **HTTPS**.
- If the source needs authentication, supply the credential through a mechanism
  that keeps it out of exported config — the **Key** module or an environment
  variable — rather than typing a raw secret into the form.
- If any part of a source URL could be influenced by request input, be aware of
  **SSRF** risk and constrain it to trusted destinations.

## 3. Map the fields

**Field mappers** and **property mappers** describe how values from the source
become Drupal field values. The module ships:

- a **Simple** mapper for straightforward key-to-field mapping, and
- a **JSONPath** mapper for pulling values out of nested API responses by
  expression.

Map at least an **id** (the unique key for each remote record) and a **label**, then
map the remaining fields you want to surface. Fields that aren't mapped to a source
value (or a constant) simply stay empty.

## 4. Configure display and use

Once the type is defined and mapped:

- Use **Manage display** to control how records render, with view modes like any
  entity.
- Enable **xntt_views** to list and filter the records in Views.
- Reference the records from other content, add Pathauto aliases
  (`external_entities_pathauto`), and so on.

## Writing back to the source

If your storage client supports updates, editing an external entity saves the
changed values **back to the remote source**, not to Drupal's database. If you need
to store extra data that has no home in the source, External Entities supports
**annotations** — a linked local Drupal entity where you can keep custom fields.

## A note on access and privacy

External-entity access follows the configuration you set. Make sure sensitive
remote data isn't exposed more broadly than intended, and remember that fetching
and displaying third-party data is a data flow you are responsible for.
