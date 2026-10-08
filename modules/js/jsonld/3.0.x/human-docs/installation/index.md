# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Serialization** module (`serialization`) — the serializer framework
  this module extends.
- The **HAL** module (`drupal/hal`, `^1 || ^2`) — used to build entity and type
  URIs, and required when deserializing incoming Linked Data.
- The **RDF** module (`drupal/rdf`, `^3.0@beta`) — supplies the field‑to‑RDF
  mappings and namespaces that drive the output. **This is the important one:**
  your JSON‑LD is only as rich as the RDF mappings you configure on your content
  types.

In recent Drupal versions HAL and RDF are contributed modules (moved out of
core), which is why they appear as Composer requirements. Composer installs them
for you.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonld -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
HAL and RDF dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonld -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonld -y
```

Drupal enables the `serialization`, `hal`, and `rdf` dependencies at the same
time. There are no submodules.

## Verify it worked

The module ships no user‑facing page, so the quickest check is in code or Drush.
For a saved node, this should return a JSON‑LD document:

```bash
drush php:eval "print \Drupal::service('serializer')->serialize(\Drupal\node\Entity\Node::load(1), 'jsonld');"
```

If you see a `{"@graph":[…]}` document, the format is registered and working.
To fine‑tune the two available options, see
[Configuration](../configuration/index.md).
